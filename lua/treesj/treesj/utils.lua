local u = require('treesj.utils')

local M = {}

---Checking if tsn is TSNode instance. False if it imitator of tsn
---@param tsn userdata|table
---@return boolean
function M.is_tsnode(tsn)
  return type(tsn) == 'userdata'
end

---Calculation of the real index if a negative value was passed
---@param i number
---@param len number Length of the list for which the index is calculated
---@return number
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
  if tsj:has_preset() and not tsj:is_ignore('split') then
    local is_norm = tsj:root():preset('split').inner_indent == 'normal'
    local need_sw = not (tsj:is_omit() or tsj:parent():is_omit() or is_norm)

    local sw = need_sw and vim.fn.shiftwidth() or 0

    tsj._root_indent = tsj:get_prev_indent() + sw
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
  local text = data.text
  local ts_type = data.type and data.type or data.text
  local sr, sc, er, ec = u.range(tsj:tsnode())

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
    return false
  end

  function imitator:text()
    return text
  end

  return setmetatable({
    _parent = tsj,
    _range = { sr, sc, sr, sc },
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

-- TODO: It affecting on CHold
---Return observed range by tsnode
---@param tsnode userdata TSNode instance
---@return integer[]
function M.get_observed_range(tsnode)
  local rr = u.readable_range({ tsnode:range() })
  local prev = tsnode:prev_sibling()
  if prev then
    local prr = u.readable_range({ prev:range() })
    rr.col.start = prr.row.start == rr.row.start and prr.col.end_ or 0
  end
  return { rr.row.start, rr.col.start, rr.row.end_, rr.col.end_ }
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
  local spacing = u.get_whitespace(child)
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
  local need = not u.check_match(p.no_insert_if, child)

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
    if not child._remove then
      if tsj:has_preset() then
        handle_force_insert(child)
      end
      set_whitespace(child)
      table.insert(lines, child:text())
    end
  end

  return collapse_spacing(lines)
end

---Set indent when 'split'
---@param child TreeSJ TreeSJ instance
local function set_indent(child)
  local indent = u.calc_indent(child)
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
  if child:is_omit() then
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
      if not child._remove then
        process_configured(child, lines)
      end
    elseif tsj:has_to_format() then
      process_configured_container(child, lines)
    else
      set_whitespace(child:text())
      table.insert(lines, child:text())
    end
  end

  local p = tsj:preset('split')
  local format_lines = p and p.format_resulted_lines
  if type(format_lines) == 'function' then
    lines = tsj:preset('split').format_resulted_lines(lines)
  end

  return lines
end

return M
