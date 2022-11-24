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

---Checking if need to set instruction separator
---@param child TreeSJ TreeSJ instance
---@param p table Preset
local function is_instruction_sep_need(child, p)
  if not p then
    return false
  end

  if child:is_framing() or u.is_empty(p.force_insert) then
    return false
  end

  local text = child:text()
  if type(text) == 'table' then
    text = text[#text]
  end

  local has = vim.endswith(text, p.force_insert)
  local need = not vim.tbl_contains(p.no_insert_if, child:type())

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

  if child:next() and child:next():is_last() then
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
  local text = prepend_text(child:text(), (' '):rep(indent))
  child:_update_text(text)
end

---Append text to last item in list. If last item is a table, merge to last of this table.
---@param lines table List-like table
---@vararg string
local function merge_text_to_prev_line(lines, ...)
  local prev = lines[#lines]
  local text = table.concat({ ... })
  if type(prev) == 'table' then
    prev[#prev] = prev[#prev] .. text
  elseif type(prev) == 'string' then
    lines[#lines] = lines[#lines] .. text
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

---Make result lines for 'split'
---@param tsj TreeSJ TreeSJ instance
---@return string[]
function M._split(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() then
      local p = tsj:preset(SPLIT)

      set_last_sep_if_need(child, p)

      local text = child:text()
      if child:is_omit() then
        merge_text_to_prev_line(lines, text)
        if child:is_last() then
          local indent = u.calc_indent(child);
          lines[#lines] = (' '):rep(indent) .. vim.trim(lines[#lines])
        end
      else
        set_indent(child)
        table.insert(lines, child:text())
      end
    elseif tsj:has_to_format() then
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
    else
      set_whitespace(child:text())
      table.insert(lines, child:text())
    end
  end
  return lines
end

return M
