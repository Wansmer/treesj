local query = require('vim.treesitter.query')
local search = require('treesj.search')
local u = require('treesj.utils')

local M = {}

---Checking if tsn is TSNode instance. False if it imitator of tsn
---@param tsn userdata|table
---@return boolean
function M.is_tsnode(tsn)
  return type(tsn) == 'userdata'
end

---Returned true if node is not empty
---@param tsn userdata TSNode instance
---@return boolean
function M.skip_empty_nodes(tsn)
  local text = vim.trim(query.get_node_text(tsn, 0))
  return not u.is_empty(text)
end

---Get list-like table with children of node
---This function is pretty much copied from 'nvim-treesitter'
---(TSRange:collect_children)
---@param tsnode userdata|table TSNode instance or TSNode imitator
---@param filter? function Function for filtering output list
---@return table
function M.collect_children(tsnode, filter)
  local children = {}

  for child in tsnode:iter_children() do
    if not filter or filter(child) then
      table.insert(children, child)
    end
  end

  return children
end

---Return text of node
---@param node TSNode from userdata
---@return string
function M.get_node_text(node)
  -- TODO: concat is deprecated in 0.9+. Refactor later
  local lines = query.get_node_text(node, 0, { concat = false })
  local trimed_lines = {}
  local sep = ' '
  if type(lines) == 'string' then
    lines = vim.split(lines, '\n')
  end
  for _, line in ipairs(lines) do
    line = vim.trim(line)
    if not u.is_empty(line) then
      table.insert(trimed_lines, line)
    end
  end
  return table.concat(trimed_lines, sep)
end

---Checking if the found node is empty
---@param tsnode userdata TSNode instance
---@param preset table Preset for TSNode
---@return boolean
function M.is_empty_node(tsnode, preset)
  local framing_count = 2
  local function is_omit(child)
    return vim.tbl_contains(preset.omit, child:type())
  end

  local function is_named(child)
    return child:named()
  end

  local cc = tsnode:child_count()
  local children = M.collect_children(tsnode, is_named)
  local contains_only_framing = cc == framing_count
  return u.every(children, is_omit) or contains_only_framing
end

---Calculation of the real index if a negative value was passed
---@param i integer
---@param len integer Length of the list for which the index is calculated
---@return integer
function M.fix_index(i, len)
  return i < 0 and (len + 1 + i) or i
end

---Add prev/next links for every child of TreeSJ children list
---@param children TreeSJ[]
---@return TreeSJ[]
function M.linking_tree(children)
  local special_types = {
    'left_non_bracket',
    'right_non_bracket',
    'left_bracket',
    'right_bracket',
  }

  for i, child in ipairs(children) do
    local prev, next = children[i - 1], children[i + 1]
    child:_set_prev(prev)
    child:_set_next(next)

    -- TODO: find next non imitator node
    if
      child:is_imitator() and not vim.tbl_contains(special_types, child:type())
    then
      child:tsnode():_set_range(prev, next)
    end
  end
  return children
end

---Setting value of indent to configured nodes
---@param tsj TreeSJ TreeSJ instance
function M.handle_indent(tsj)
  if tsj._mode == 'split' and tsj:has_preset() and not tsj:is_ignore() then
    local is_norm = tsj:root():preset('split').inner_indent == 'normal'
    local need_sw = not (tsj:is_omit() or tsj:parent():is_omit() or is_norm)

    local sw = need_sw and vim.fn.shiftwidth() or 0

    tsj._root_indent = tsj:_get_prev_indent() + sw
  end
end

---Add or remove last separator in node
---@param tsj TreeSJ TreeSJ instance
---@param preset table
function M.handle_last_separator(tsj, preset)
  local penult = tsj:child(-2)
  local sep = preset.separator

  if penult and not penult:is_framing() and sep ~= '' then
    local has = penult:type() == sep
    local need = preset.last_separator

    if has and not need then
      tsj:remove_child(-2)
    elseif not has and need then
      tsj:create_child({ type = sep, text = sep }, -1)
    end
  end
end

local function get_bracket_imitator_range(tsj, side)
  local tsn = tsj:tsnode()
  local sr, sc, er, ec = tsn:range()
  local sibling

  if side == 'left' then
    er, ec = sr, sc
    sibling = tsn:prev_sibling() or tsn:parent():prev_sibling()
  else
    sr, sc = er, ec
    sibling = tsn:next_sibling() or tsn:parent():next_sibling()
  end

  if sibling then
    if side == 'left' then
      _, _, er, ec = sibling:range()
      sr, sc = er, ec
    else
      sr, sc = sibling:range()
      er, ec = sr, sc
    end
  end

  return sr, sc, er, ec
end

---Create imitator of TSNode
---@param tsj TreeSJ TreeSJ instance
---@param data table { text = '', type = '' }
---@return table
function M.imitate_tsn(tsj, data)
  local imitator = {}
  imitator.__index = imitator
  local text = data.text and data.text or ''
  local ts_type = data.type and data.type or data.text
  local sr, sc, er, ec = search.range(tsj:tsnode())

  local types = {
    ['left_non_bracket'] = { get_bracket_imitator_range(tsj, 'left') },
    ['right_non_bracket'] = { get_bracket_imitator_range(tsj, 'right') },
    ['left_bracket'] = { sr, sc, sr, sc },
    ['right_bracket'] = { er, ec, er, ec },
  }

  if types[ts_type] then
    sr, sc, er, ec = unpack(types[ts_type])
  else
    sr, sc = er, ec
  end

  function imitator:_set_range(prev, next)
    local nsr, nsc, ner, nec = sr, sc, er, ec
    if prev then
      _, _, nsr, nsc = prev:tsnode():range()
    end

    if next then
      ner, nec = next:tsnode():range()
    end

    self._range = { nsr, nsc, ner, nec }
  end

  function imitator:prev_sibling()
    return nil
  end

  function imitator:next_sibling()
    return nil
  end

  function imitator:range()
    return unpack(self._range)
  end

  function imitator:type()
    return ts_type
  end

  function imitator:named()
    return false
  end

  function imitator:field()
    return nil
  end

  function imitator:text()
    return text
  end

  return setmetatable({
    _parent = tsj,
    _range = { sr, sc, sr, sc },
    _type = ts_type,
  }, imitator)
end

---Creating and insert framing nodes to children list of configured TreeSJ
---@param tsj TreeSJ
---@param preset table
function M.handle_framing_nodes(tsj, preset)
  if tsj:non_bracket() then
    local left_type, right_type = 'left_non_bracket', 'right_non_bracket'
    local left, right = '', ''

    if type(preset.non_bracket_node) == 'table' then
      left = preset.non_bracket_node.left
      right = preset.non_bracket_node.right
    end

    tsj:create_child({ text = left, type = left_type }, 1)
    tsj:create_child({ text = right, type = right_type }, #tsj:children() + 1)
  end
end

---Get whitespace between nodes
---@param tsj TreeSJ TreeSJ instance
---@return string
function M.get_whitespace(tsj)
  local function is_on_same_line(prev, curent)
    return prev and prev:range()[3] == curent:range()[1] or false
  end

  local function get_sibling_spacing(prev, current)
    return current:range()[2] - prev:range()[4]
  end

  local p = tsj:parent():preset('join')
  local s_count = p and (p.space_separator and 1 or 0) or 1
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

---Checking if tsj meets condition in list of string and functions
---Returned 'true' if type of tsj contains among strings or some of 'function(tsj)' returned 'true'
---@param tbl table List with 'string' and 'function'
---@param tjs TreeSJ TreeSJ instance
function M.check_match(tbl, tjs)
  local function is_func(item)
    return type(item) == 'function'
  end

  local contains = vim.tbl_contains(tbl, tjs:type())
  local cbs = vim.tbl_filter(is_func, tbl)

  if not contains and #cbs > 0 then
    return u.some(cbs, function(cb)
      return cb(tjs)
    end)
  else
    return contains
  end
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

---Collapse extra spacing: if elem ends with space and next elem starts with space
---@param lines string[]
---@return string[]
local function collapse_spacing(lines)
  for i, str in ipairs(lines) do
    str = str:gsub('^%s+', ' '):gsub('%s+$', ' ')
    local next = lines[i + 1]
    if next and vim.endswith(str, ' ') and vim.startswith(next, ' ') then
      lines[i] = string.gsub(str, ' $', '')
    end
  end
  return lines
end

---Add some text to start of base text. If the base is table, prepend text to first element of table
---@param target_text string|string[]
---@param text string
---@return string|string[]
local function prepend_text(target_text, text)
  if type(target_text) == 'table' then
    target_text = vim.list_extend({}, target_text, 1, #target_text)
    target_text[1] = table.concat(collapse_spacing({ text, target_text[1] }))
  else
    target_text = table.concat(collapse_spacing({ text, target_text }))
  end
  return target_text
end

---Set whitespaces before node
---@param child TreeSJ
local function set_whitespace(child)
  local spacing = M.get_whitespace(child)
  local text = prepend_text(child:text(), spacing)
  child:update_text(text)
end

---Append text to last item in list. If last item is a table, merge to last of this table.
---If `to_merge` is a table, merge the first element of `to_merge` to the last element of `lines`
---and push the rest elements to the end of `lines`.
---@param lines string|string[] List-like table
---@param to_merge string|table
local function merge_text_to_prev_line(lines, to_merge)
  local prev = lines[#lines]
  if not prev or not to_merge then
    return
  end

  local text = ''
  local is_tbl = type(to_merge) == 'table'

  if is_tbl then
    text = table.remove(to_merge, 1)
  else
    text = to_merge
  end

  local prev_text = type(prev) == 'table' and prev[#prev] or lines[#lines]
  if vim.endswith(prev_text, ' ') then
    text = vim.trim(text)
  end

  if vim.trim(text) ~= '' then
    if type(prev) == 'table' then
      prev[#prev] = prev_text .. text
    else
      lines[#lines] = prev_text .. text
    end
  end

  if is_tbl then
    lines[#lines + 1] = to_merge
  end
end

---Sets instruction separator (force_insert) if need
---@param child TreeSJ TreeSJ instance
local function handle_force_insert(child)
  local p = child:parent():preset('join')
  if not p or p.force_insert == '' then
    return
  end

  local next = child:next()
  local is_next_sep = next and next:text() == p.force_insert or false

  if is_next_sep or child:is_framing() then
    return
  end

  local has = vim.endswith(child:text(), p.force_insert)
  local need = not M.check_match(p.no_insert_if, child)

  if need and not has then
    child:update_text(child:text() .. p.force_insert)
  end
end

---Make result line for 'join'
---@param tsj TreeSJ TreeSJ instance
---@return string[]
function M._join(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() then
      handle_force_insert(child)
    end
    set_whitespace(child)
    table.insert(lines, child:text())
  end

  return collapse_spacing(lines)
end

---Set indent when 'split'
---@param child TreeSJ TreeSJ instance
local function set_indent(child)
  local indent = M.calc_indent(child)
  local sep = ' '

  if not vim.bo.expandtab then
    indent = indent / vim.fn.shiftwidth()
    sep = '\t'
  end

  local text = prepend_text(child:text(), (sep):rep(indent))
  child:update_text(text)
end

---Handling for configured node when mode is SPLIT
---@param child TreeSJ child of tsj
---@param lines table List-like table
local function process_configured(child, lines)
  if child:is_omit() and not child:is_first() then
    set_whitespace(child)
    merge_text_to_prev_line(lines, child:text())
  else
    set_indent(child)
    table.insert(lines, child:text())
  end
end

---Handling for node containing configured descendants
---@param child TreeSJ Child of tsj with 'has_node_to_format'
---@param lines table List-like table
local function process_configured_container(child, lines)
  local is_string = type(child:text()) == 'string'
  local is_table = type(child:text()) == 'table'

  if child:is_first() then
    table.insert(lines, child:text())
  elseif is_string then
    set_whitespace(child)
    merge_text_to_prev_line(lines, child:text())
  elseif is_table and not u.is_empty(lines) then
    set_whitespace(child)
    merge_text_to_prev_line(lines, child:text()[1])
    table.remove(child:text(), 1)

    if not u.is_empty(child:text()) then
      table.insert(lines, child:text())
    end
  end
end

---Remove empty strings except first and last
---@param lines string[]
---@return string[]
function M.remove_empty_middle_lines(lines)
  local first = table.remove(lines, 1)
  local last = table.remove(lines, #lines)
  local remover = function(str)
    if type(str) == 'string' then
      return vim.trim(str) ~= ''
    else
      return true
    end
  end

  return vim.tbl_flatten({ first, vim.tbl_filter(remover, lines), last })
end

---Make result lines for 'split'
---@param tsj TreeSJ TreeSJ instance
---@return table
function M._split(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() then
      process_configured(child, lines)
    elseif tsj:has_to_format() then
      process_configured_container(child, lines)
    else
      set_whitespace(child:text())
      table.insert(lines, child:text())
    end
  end

  return lines
end

return M
