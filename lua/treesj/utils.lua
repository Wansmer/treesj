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

---Checking if every item of list meets the condition.
---Empty list or non-list table, returning false.
---@param tbl table List-like table
---@param cb function Callback for checking every item
---@return boolean
function M.every(tbl, cb)
  if not vim.tbl_islist(tbl) or M.is_empty(tbl) then
    return false
  end

  for _, item in ipairs(tbl) do
    if not cb(item) then
      return false
    end
  end

  return true
end

---Checking if some item of list meets the condition.
---Empty list or non-list table, returning false.
---@param tbl table List-like table
---@param cb function Callback for checking every item
---@return boolean
function M.some(tbl, cb)
  if not vim.tbl_islist(tbl) or M.is_empty(tbl) then
    return false
  end

  for _, item in ipairs(tbl) do
    if cb(item) then
      return true
    end
  end

  return false
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
---@param tsn_type string TSNode type
---@param lang? string TSNode lang. Requires if `node` is string
---@param mode? string Current mode (split|join)
---@return table|nil
function M.get_preset(tsn_type, lang, mode)
  if lang and not M.is_lang_support(lang) then
    return nil
  end

  local presets = langs[lang]
  local preset = presets and presets[tsn_type]

  return preset and (preset[mode] or preset)
end

---Return the preset for current node if it no contains field 'target_nodes'
---@param tsn_type string TSNode type
---@param lang string TSNode lang
---@return table|nil
function M.get_self_preset(tsn_type, lang)
  local p = M.get_preset(tsn_type, lang)
  if p and not p.target_nodes then
    return p
  end
  return nil
end

---Return list-like table with keys of option 'target_nodes'
---@param tsn_type string TSNode type
---@param lang string TSNode lang
---@return table|nil
function M.get_targets(tsn_type, lang)
  local p = M.get_preset(tsn_type, lang)
  local targets = p and p.target_nodes
  return (targets and not M.is_empty(targets)) and targets
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

---Returned true if node is not empty
---@param tsn userdata TSNode instance
---@return boolean
function M.skip_empty_nodes(tsn)
  local text = vim.trim(query.get_node_text(tsn, 0))
  return not M.is_empty(text)
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

---Checking if the found node is empty
---@param tsn userdata TSNode instance
---@param preset table Preset for TSNode
---@return boolean
function M.is_empty_node(tsn, preset)
  local framing_count = 2
  local function is_omit(child)
    return vim.tbl_contains(preset.omit, child:type())
  end

  local function is_named(child)
    return child:named()
  end

  local cc = tsn:child_count()
  local children = M.collect_children(tsn, is_named)
  local contains_only_framing = cc == framing_count
  return M.every(children, is_omit) or contains_only_framing
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
---@param root_preset table|nil Preset of root node for check 'recursive_ignore'
---@return boolean
function M.has_node_to_format(tsnode, root_preset)
  local function configured_and_must_be_formatted(tsn)
    local lang = M.get_node_lang(tsn)
    local p = M.get_preset(tsn:type(), lang)
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
  local lang = M.get_node_lang(tsnode)
  local p = M.get_preset(tsnode:type(), lang, mode)
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
  local is_sep = (p and p.separator ~= '') and tsj:text() == p.separator

  if tsj:is_first() or is_sep then
    s_count = 0
  elseif (not p or tsj:is_omit()) and is_on_same_line(tsj:prev(), tsj) then
    s_count = get_sibling_spacing(tsj:prev(), tsj)
  elseif p and (tsj:prev():is_first() or tsj:is_last()) then
    s_count = p.space_in_brackets and 1 or 0
  end

  return (' '):rep(s_count)
end

---Checking if the current node is last with `is_omtit = false`
---@param tsj TreeSJ TreeSJ instance
---@return boolean
local function is_last_no_omit(tsj)
  local parent = tsj:parent()
  if parent and parent:has_preset() then
    local last_no_omit = parent:child(1)
    for child in parent:iter_children() do
      last_no_omit = not child:is_omit() and child or last_no_omit
    end
    return tsj == last_no_omit
  end
  return false
end

---Computed indent for node when mode is 'split'
---@param tsj TreeSJ TreeSJ instance
---@return integer
function M.calc_indent(tsj)
  local parent = tsj:parent()
  if tsj:is_first() or tsj:is_omit() or not parent then
    return 0
  end

  local pp = parent:preset('split')
  local start_indent = parent._root_indent
  local shiftwidth = vim.fn.shiftwidth()
  local common_indent = start_indent + shiftwidth
  local is_last = is_last_no_omit(tsj) and pp.last_indent == 'normal'
  local is_same = pp.inner_indent == 'normal'

  return (is_last or is_same) and start_indent or common_indent
end

---Get base nodes for first/last imitator node in non-bracket blocks
---@param tsn userdata TSNode instance
---@return userdata|nil, userdata|nil
function M.get_non_bracket_first_last(tsn)
  local first = tsn:prev_sibling() or tsn:parent():prev_sibling()
  local last = tsn:next_sibling() or tsn:parent():next_sibling()
  return first, last
end

---Get real end_row and end_column of node
---@param tsn userdata
---@return integer, integer
local function get_last_sym_range(tsn)
  local len = tsn:child_count()
  while len > 0 do
    tsn = tsn:child(len - 1)
    len = tsn:child_count()
  end
  local _, _, er, ec = tsn:range()
  return er, ec
end

---Returned range of node considering the presence of brackets
---@param tsn userdata
---@param p? table
---@return integer, integer, integer, integer
function M.range(tsn, p)
  local non_bracket_node = M.get_nested_key_value(p, 'non_bracket_node')

  -- Some parsers give incorrect range, when `tsn:range()` (e.g. `yaml`).
  -- That's why using end_row and end_column of last children text.
  local sr, sc = tsn:range()
  local er, ec = get_last_sym_range(tsn)

  if p and non_bracket_node then
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

local function is_func(item)
  return type(item) == 'function'
end

---Checking if tsj meets condition in list of string and functions
---Returned 'true' if type of tsj contains among strings or some of 'function(tsj)' returned 'true'
---@param tbl table List with 'string' and 'function'
---@param tjs TreeSJ TreeSJ instance
function M.check_match(tbl, tjs)
  local contains = vim.tbl_contains(tbl, tjs:type())
  local cbs = vim.tbl_filter(is_func, tbl)

  if not contains and #cbs > 0 then
    return M.some(cbs, function(cb)
      return cb(tjs)
    end)
  else
    return contains
  end
end

return M
