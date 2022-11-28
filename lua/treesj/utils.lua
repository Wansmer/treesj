local query = require('vim.treesitter.query')
local langs = require('treesj.settings').settings.langs
local notify = require('treesj.notify')
local msg = notify.msg

local ts_ok, parsers = pcall(require, 'nvim-treesitter.parsers')
if not ts_ok then
  notify.error(msg.ts_not_found)
  return
end

local M = {}

---Convert any type to boolean
---@param val any
---@return boolean
function M.tobool(val)
  return val and true or false
end

---Checking if the string or table is is is empty
---@param val string|table
---@return boolean
function M.is_empty(val)
  if type(val) == 'table' then
    return vim.tbl_isempty(val)
  elseif type(val) == 'string' then
    return val == ''
  else
    return false
  end
end

---Get lunguage for node
---@param node userdata TSNode instance
---@return string
function M.get_node_lang(node)
  local range = { node:range() }
  local lang_tree = parsers.get_parser()
  local current_tree = lang_tree:language_for_range(range)
  return current_tree:lang()
end

---Checking if language is configured
---@param lang string Language
---@return boolean
function M.is_lang_support(lang)
  return M.tobool(langs[lang])
end

---Return the preset for received node.
---If mode passed, return preset for specified mode
---@param node userdata TSNode instance
---@param mode? string Current mode (split|join)
---@return table|nil
function M.get_preset(node, mode)
  local lang = M.get_node_lang(node)
  if not M.is_lang_support(lang) then
    return nil
  end
  local preset = langs[lang]
  local type = node:type()
  if preset[type] then
    return mode and preset[type][mode] or preset[type]
  else
    return nil
  end
end

---Return the preset for current node if it no contains field 'target_nodes'
---@param node userdata TSNode instance
---@return table|nil
function M.get_self_preset(node)
  local p = M.get_preset(node)
  if p then
    if p.target_nodes then
      return nil
    end
    return p
  end
  return nil
end

---Checking if node is configured
---@param node userdata TSNode instance
---@return boolean
function M.has_preset(node)
  return M.tobool(M.get_preset(node))
end

---Checking if node preset has option 'target_nodes'
---@param node userdata TSNode instance
---@return boolean
function M.has_targets(node)
  local target = M.get_preset(node).target_nodes
  return target and not M.is_empty(target)
end

---Return list-like table with keys of option 'target_nodes'
---@param node userdata TSNode instance
---@return table
function M.get_targets(node)
  return vim.tbl_keys(M.get_preset(node).target_nodes)
end

---Return list-like table with all configured nodes for language
---@param lang string Language
---@return table
function M.get_nodes_for_lang(lang)
  return vim.tbl_keys(langs[lang])
end

---Recursively finding key in table and return its value if found or nil
---@param tbl table|nil Dict-like table
---@param target_key string Name of target key
---@return any|nil
function M.get_nested_key_value(tbl, target_key)
  if not tbl or vim.tbl_islist(tbl) then
    return nil
  end
  local found
  for key, val in pairs(tbl) do
    if key == target_key then
      return val
    end
    if type(val) == 'table' and not vim.tbl_islist(val) then
      found = M.get_nested_key_value(val, target_key)
    end
    if found then
      return found
    end
  end
  return nil
end

---Get list-like table with children of node
---This function is pretty much copied from 'nvim-treesitter'
---(TSRange:collect_children)
---@param node userdata TSNode instance
---@param filter? function Function for filtering output list
---@return table
function M.collect_children(node, filter)
  local children = {}

  for child in node:iter_children() do
    if not filter or filter(child) then
      table.insert(children, child)
    end
  end

  return children
end

---Return text of node
---@param node userdata TSNode instance
---@return string
function M.get_node_text(node)
  local lines = query.get_node_text(node, 0, { concat = false })
  local trimed_lines = {}
  local sep = ' '
  for _, line in ipairs(lines) do
    line = vim.trim(line)
    if not M.is_empty(line) then
      table.insert(trimed_lines, line)
    end
  end
  return table.concat(trimed_lines, sep)
end

---Recursively iterates over each one until the state is satisfied
---@param tsnode userdata TSNode instance
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
---@param tsnode userdata TSNode instance
---@param root_preset|nil table Preset of root node for check 'recursive_ignore'
---@return boolean
function M.has_node_to_format(tsnode, root_preset)
  local function configured_and_must_be_formatted(tsn)
    local p = M.get_preset(tsn)
    local recursive_ignore =
      M.get_nested_key_value(root_preset, 'recursive_ignore')
    local ignore = recursive_ignore
        and vim.tbl_contains(recursive_ignore, tsn:type())
      or false
    return M.tobool(p and not (p.target_nodes or ignore))
  end

  return M.check_descendants(tsnode, configured_and_must_be_formatted)
end

---Checking if the node contains disabled descendants to format
---@param tsnode userdata TSNode instance
---@param mode string Current mode (split|join)
---@return boolean
function M.has_disabled_descendants(tsnode, mode)
  local p = M.get_preset(tsnode, mode)
  if not p then
    return false
  end
  local function contains_in_no_format_with(tsn)
    return vim.tbl_contains(p.no_format_with, tsn:type())
  end
  return M.check_descendants(tsnode, contains_in_no_format_with)
end

---Convert range (integer[]) to human-readable
---@param range integer[] Range
---@return table
function M.readable_range(range)
  return {
    row = {
      start = range[1],
      end_ = range[3] or range[1],
    },
    col = {
      start = range[2],
      end_ = range[4] or range[2],
    },
  }
end

---Checking if the previos and current nodes place on same line
---@param prev TreeSJ|nil Previous TreeSJ instance
---@param curent TreeSJ Current TreeSJ instance
---@return boolean
local function is_on_same_line(prev, curent)
  return prev and prev:range()[3] == curent:range()[1] or false
end

---Get spacing between siblings (siblings must be placed by same line)
---@param prev TreeSJ
---@param current TreeSJ
---@return integer
local function get_sibling_spacing(prev, current)
  return current:range()[2] - prev:range()[4]
end

---Get whitespace between nodes
---@param tsj TreeSJ TreeSJ instance
---@return string
function M.get_whitespace(tsj)
  local p = tsj:parent():preset('join')
  local s_count = p and p.space_separator or 1

  if tsj:is_first() or tsj:is_omit() then
    s_count = 0
  elseif not p and is_on_same_line(tsj:prev(), tsj) then
    s_count = get_sibling_spacing(tsj:prev(), tsj)
  elseif p and (tsj:prev():is_first() or tsj:is_last()) then
    s_count = p.space_in_brackets and 1 or 0
  end

  return (' '):rep(s_count)
end

---Computed indent for node when mode is 'split'
---@param tsj TreeSJ TreeSJ instance
---@return integer
function M.calc_indent(tsj)
  if tsj:is_first() or (tsj:is_omit() and not tsj:is_last()) then
    return 0
  end
  local si = tsj:parent()._root_indent
  local sw = vim.api.nvim_buf_get_option(0, 'shiftwidth')
  local common_indent = si + sw
  return tsj:is_last() and si or common_indent
end

---Get base nodes for first/last imitator node in non-bracket blocks
---@param tsn userdata TSNode instance
---@return userdata|nil, userdata|nil
function M.get_non_bracket_first_last(tsn)
  local first = tsn:prev_sibling() or tsn:parent():prev_sibling()
  local last = tsn:next_sibling() or tsn:parent():next_sibling()
  return first, last
end

---Returned range of node considering the presence of brackets
---@param tsn userdata
function M.range(tsn)
  local p = M.get_preset(tsn, 'split')
  local sr, sc, er, ec = tsn:range()

  if p and p.non_bracket_node then
    local first, last = M.get_non_bracket_first_last(tsn)
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
