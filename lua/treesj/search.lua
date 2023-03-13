local notify = require('treesj.notify')
local langs = require('treesj.settings').settings.langs
local u = require('treesj.utils')
local msg = notify.msg

local ts_ok, parsers = pcall(require, 'nvim-treesitter.parsers')
if not ts_ok then
  notify.error(msg.ts_not_found)
  return
end

local M = {}

---Get lunguage for node
---@param node TSNode TSNode instance
---@return string
local function get_node_lang(node)
  local range = { node:range() }
  local lang_tree = parsers.get_parser()
  local current_tree = lang_tree:language_for_range(range)
  return current_tree:lang()
end

---Return the preset for received node.
---If mode passed, return preset for specified mode
---@param tsn_type string TSNode type
---@param lang? string TSNode lang. Requires if `node` is string
---@param mode? string Current mode (split|join)
---@return table|nil
local function get_preset(tsn_type, lang, mode)
  if lang and not langs[lang] then
    return nil
  end

  local presets = langs[lang]
  local preset = presets and presets[tsn_type]

  return preset and (preset[mode] or preset)
end

---Recursively searches for the configured node among the ancestors
---@param node TSNode TSNode instance
---@param lang string Language of TSNode
---@return TSNode|nil, table|nil
local function search_node_up(node, lang)
  if not node then
    return nil
  end

  local preset = get_preset(node:type(), lang)

  if not (node:named() and preset) then
    node = node:parent()
    return search_node_up(node, lang)
  end

  return node, preset
end

---Recursively searches for a configured node inside the current node and
---returns the first configured node found
---@param node TSNode|nil TSNode instance
---@param lang string TSNode lang
---@param targets table List of target node types
---@return TSNode|nil, table|nil
local function search_inside_node(node, lang, targets)
  if not node then
    return nil, nil
  end

  local target_node, use_preset

  for child in node:iter_children() do
    local target_type = child:named() and targets[child:type()]
    use_preset = target_type and M.get_self_preset(target_type, lang)

    if use_preset then
      target_node = child
    else
      target_node, use_preset = search_inside_node(child, lang, targets)
    end

    if target_node then
      break
    end
  end

  return target_node, use_preset
end

local function get_node_from_field(node, lang, targets)
  for node_type, use_preset in pairs(targets) do
    local fields = node:field(node_type)
    local preset = M.get_self_preset(use_preset, lang)

    if not vim.tbl_isempty(fields) and preset then
      return fields[1], preset
    end
  end
  return nil, nil
end

---Get target node and node data
---@param node TSNode|nil TSNode instance
---@param lang string TSNode language
---@return table|nil
local function search_node(node, lang)
  local viewed = {}
  local tsn_data = {
    lang = lang,
    from_self = false,
    parent = nil,
    mode = nil,
  }
  local preset

  while node do
    node, preset = search_node_up(node, lang)

    if not (node and preset) then
      return nil
    end

    local targets = preset.target_nodes

    local has_targets = targets and not vim.tbl_isempty(targets)
    local not_viewed = not vim.tbl_contains(viewed, node)

    if has_targets and not_viewed then
      local with_target = node
      table.insert(viewed, with_target)

      node, preset = get_node_from_field(node, lang, targets)

      if not node then
        node, preset = search_inside_node(with_target, lang, targets)
      end

      if node then
        break
      else
        node = with_target:parent()
      end
    else
      break
    end
  end

  return vim.tbl_extend('force', tsn_data, { tsnode = node, preset = preset })
end

---Return the closest configured node if found or nil
---@param node TSNode|nil TSNode instance
---@return table
function M.get_configured_node(node)
  if not node then
    error(msg.node_not_received, 0)
  end

  local lang = get_node_lang(node)
  if not langs[lang] then
    error(msg.no_configured_lang:format(lang), 0)
  end

  local start_node_type = node:type()
  local data = search_node(node, lang)

  if not data or not data.tsnode then
    error(msg.no_configured_node:format(start_node_type, lang), 0)
  end

  return data
end

---Return the preset for current node if it no contains field 'target_nodes'
---@param tsn_type string TSNode type
---@param lang string TSNode lang
---@return table|nil
function M.get_self_preset(tsn_type, lang)
  local p = get_preset(tsn_type, lang)
  if p and not p.target_nodes then
    return p
  end
  return nil
end

---Recursively iterates over each one until the state is satisfied
---@param tsnode TSNode TSNode instance
---@param cb function Callback: boolean
---@return boolean
function M.check_descendants(tsnode, cb)
  cb = cb or function() end
  local function _check(node, f)
    local result = false
    for child in node:iter_children() do
      if f(child) then
        return true
      end
      if child:child_count() >= 1 then
        result = _check(child, f)
      else
        result = f(child)
      end
      if result then
        return true
      end
    end
    return result
  end
  return _check(tsnode, cb)
end

---Checking if the node contains descendants to format
---@param tsnode TSNode TSNode instance
---@param ignore table|nil List of types to be ignored
---@param lang string Current lang
---@return boolean
function M.has_node_to_format(tsnode, ignore, lang)
  local function configured_and_must_be_formatted(tsn)
    local has_preset = tsn:named() and M.get_self_preset(tsn:type(), lang)
    local ignored = vim.tbl_contains(ignore, tsn:type())
    return has_preset and not ignored
  end

  return M.check_descendants(tsnode, configured_and_must_be_formatted)
end

---Checking if the node contains disabled descendants to format
---@param tsnode TSNode TSNode instance
---@param mode 'split'|'join' Current mode (split|join)
---@param lang string Current lang
---@return boolean
function M.has_disabled_descendants(tsnode, mode, lang)
  local p = get_preset(tsnode:type(), lang, mode)
  if not p then
    return false
  end
  local function contains_in_no_format_with(tsn)
    return vim.tbl_contains(p.no_format_with, tsn:type())
  end
  return M.check_descendants(tsnode, contains_in_no_format_with)
end

---Returned range of node considering the presence of brackets
---@param tsn TSNode|table TSNode instance or TSNode imitator
---@param p? table
---@return integer, integer, integer, integer
function M.range(tsn, p)
  local function get_last_symbol_range(n)
    local len = n:child_count()
    while len > 0 do
      n = n:child(len - 1)
      len = n:child_count()
    end
    local _, _, er, ec = n:range()
    return er, ec
  end

  local function get_framing_for_non_bracket(n)
    local first = n:prev_sibling() or n:parent():prev_sibling()
    local last = n:next_sibling() or n:parent():next_sibling()
    return first, last
  end

  local non_bracket_node = u.get_nested_key_value(p, 'non_bracket_node')

  -- Some parsers give incorrect range, when `tsn:range()` (e.g. `yaml`).
  -- That's why using end_row and end_column of last children text.
  local sr, sc = tsn:range()
  local er, ec = get_last_symbol_range(tsn)

  if p and non_bracket_node then
    local first, last = get_framing_for_non_bracket(tsn)
    if first then
      local r = { first:range() }
      sr, sc, _, _ = r[3], r[4]
    end
    if last then
      local r = { last:range() }
      _, _, er, ec = _, _, r[1], r[2]
    end
  end

  return sr, sc, er, ec
end

return M
