local u = require('treesj.utils')

local JOIN = 'join'
local SPLIT = 'split'

local M = {}

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

---Makes first/last imitator node for TreeSJ. Using only for non-bracket blocks.
---@param tsn userdata|nil
---@param parent userdata
---@param pos string last|first
---@param text? string
local function imitate_tsn(tsn, parent, pos, text)
  text = text or ''

  local imitator = {}
  imitator.__index = imitator
  local sr, sc, er, ec
  if tsn then
    sr, sc, er, ec = tsn:range()
  elseif pos == 'first' then
    sr, sc = parent:range()
    er, ec = sr, sc
  elseif pos == 'last' then
    _, _, er, ec = parent:range()
    sr, sc = er, ec
  end

  function imitator:range()
    if pos == 'first' then
      return er, ec, er, ec
    else
      return sr, sc, sr, sc
    end
  end

  function imitator:type()
    return 'imitator'
  end

  function imitator:text()
    return text
  end

  return imitator
end

---Add first and last imitator nodas to children list for non-bracket blocks
---@param node userdata TSNode instance
---@param children table
---@param left? string
---@param right? string
function M.add_first_last_imitator(node, children, left, right)
  local p = u.get_preset(node)
  if p and u.get_nested_key_value(p, 'non_bracket_node') then
    local first, last = u.get_non_bracket_first_last(node)
    table.insert(children, 1, imitate_tsn(first, node, 'first', left))
    table.insert(children, imitate_tsn(last, node, 'last', right))
  end
end

---Add some text to start of base text. If the base is table, prepend text to first element of table
---@param target_text string|string[]
---@param text string
---@return string|string[]
local function prepend_text(target_text, text)
  if type(target_text) == 'table' then
    target_text = vim.list_extend({}, target_text, 1, #target_text)
    target_text[1] = text .. target_text[1]
  else
    target_text = text .. target_text
  end
  return target_text
end

---Set whitespaces before node
---@param child TreeSJ
local function set_whitespace(child)
  local spacing = u.get_whitespace(child)
  local text = prepend_text(child:text(), spacing)
  child:_update_text(text)
end

-- TODO: rewrite
---Checking if need to set instruction separator
---@param child TreeSJ TreeSJ instance
---@param p table Preset
local function is_instruction_sep_need(child, p)
  if not p then
    return false
  end

  local next = child:next()
  local is_next_sep = next and next:text() == p.force_insert or false

  if child:is_framing() or u.is_empty(p.force_insert) or is_next_sep then
    return false
  end

  local has = vim.endswith(child:text(), p.force_insert)
  local need = not u.check_match(p.no_insert_if, child)

  return need and not has
end

---Checking if the text need and not has or has and not need last separator
---@param text string Current text of child
---@param p table Preset
---@return boolean, boolean
local function is_has_and_need(text, p)
  return vim.endswith(text, p.separator), p.last_separator
end

---Add or remove last separator
---@param child TreeSJ TreeSJ instance
---@param p table|nil Preset for parent
local function set_last_sep_if_need(child, p)
  if not p then
    return
  end

  if not child:is_first() and child:next() and child:next():is_last() then
    local content = child:text()
    local text = type(content) == 'table' and content[#content] or content

    local has, need = is_has_and_need(text, p)

    if has and not need then
      text = text:sub(1, #text - #p.separator)
    elseif need and not has then
      text = text .. p.separator
    end

    if type(content) == 'table' then
      content[#content] = text
    else
      content = text
    end

    child:_update_text(content)
  end
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
  child:_update_text(text)
end

---Append text to last item in list. If last item is a table, merge to last of this table.
---@param lines string|string[] List-like table
---@vararg string|table
local function merge_text_to_prev_line(lines, ...)
  local prev = lines[#lines]
  local text = table.concat({ ... })

  if vim.trim(text) == '' or not prev then
    return
  end

  local prev_text = type(prev) == 'table' and prev[#prev] or lines[#lines]
  if vim.endswith(prev_text, ' ') then
    text = vim.trim(text)
  end

  if type(prev) == 'table' then
    prev[#prev] = prev_text .. text
  else
    lines[#lines] = prev_text .. text
  end
end

---Make result line for 'join'
---@param tsj TreeSJ TreeSJ instance
---@return string
function M._join(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() then
      local p = tsj:preset(JOIN)

      local cb = p.foreach
      if cb then
        cb(child)
      end

      if is_instruction_sep_need(child, p) then
        child:_update_text(child:text() .. p.force_insert)
      end

      set_last_sep_if_need(child, p)
      set_whitespace(child)

      table.insert(lines, child:text())
    else
      set_whitespace(child)
      table.insert(lines, child:text())
    end
  end

  return table.concat(lines)
end

---Handling for configured node when mode is SPLIT
---@param tsj TreeSJ TreeSJ instance
---@param child TreeSJ child of tsj
---@param lines table List-like table
local function process_configured(tsj, child, lines)
  local p = tsj:preset(SPLIT)

  set_last_sep_if_need(child, p)

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

---Make result lines for 'split'
---@param tsj TreeSJ TreeSJ instance
---@return table
function M._split(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() then
      local cb = tsj:preset('split').foreach
      if cb then
        cb(child)
      end

      if not child._remove then
        process_configured(tsj, child, lines)
      end
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
