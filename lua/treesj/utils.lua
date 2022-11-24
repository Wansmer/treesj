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
---@return table
function M.get_preset(node, mode)
  local lang = M.get_node_lang(node)
  local preset = langs[lang]
  local type = node:type()
  return mode and preset[type][mode] or preset[type]
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
---@return boolean
function M.has_node_to_format(tsnode)
  local function configured_and_no_target(tsn)
    local p = M.get_preset(tsn)
    return M.tobool(p and not p.target_nodes)
  end

  return M.check_descendants(tsnode, configured_and_no_target)
end

---Checking if the node contains disabled descendants to format
---@param tsnode userdata TSNode instance
---@param mode string Current mode (split|join)
---@return boolean
function M.has_disabled_descendants(tsnode, mode)
  local p = M.get_preset(tsnode, mode)
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
---@param tsj TreeSJ Current TreeSJ instance
---@return boolean
function M.is_on_same_line(tsj)
  local prev = tsj:prev()
  return prev and prev:range()[1] == tsj:range()[1] or false
end

---Get whitespace between nodes
---@param tsj TreeSJ TreeSJ instance
---@return string
function M.get_whitespace(tsj)
  local prev = tsj:prev()
  if tsj:is_first() or tsj:is_omit() or not prev then
    return ''
  end

  local s_count = 1
  local p = tsj:parent():preset('join')
  if not p then
    if prev:range()[3] == tsj:range()[1] then
      s_count = tsj:range()[2] - prev:range()[4]
    end
    return (' '):rep(s_count)
  end

  s_count = p.space_separator or s_count
  if tsj:prev():is_first() or tsj:is_last() then
    s_count = p.space_in_brackets and 1 or 0
    return (' '):rep(s_count)
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

return M
