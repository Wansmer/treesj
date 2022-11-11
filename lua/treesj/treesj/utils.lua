local u = require('treesj.utils')

local JOIN = 'join'
local SPLIT = 'split'

local M = {}

---Return observed range by tsnode
---@param tsnode userdata TSNode instance
---@return integer[]
function M.get_observed_range(tsnode)
  local sr, sc, er, ec = tsnode:range()
  local prev = tsnode:prev_sibling()
  if prev then
    local pr = { prev:range() }
    local is_on_one_line = sr == pr[1]
    if is_on_one_line then
      sc = pr[4]
    else
      sc = 0
    end
  end
  return { sr, sc, er, ec }
end

---Set whitespaces before node
---@param child TreeSJ
local function _set_whitespace(child)
  local spacing = u.get_whitespace(child)
  child:_update_text(spacing .. child:text())
end

---Chicking if node text need instruction separator and set it.
---Use only for 'join'
---@param child TreeSJ TreeSJ instance
---@param p table|nil Preset for parent node
local function _set_instruction_sep_if_need(child, p)
  if not p then
    return
  end

  local process = not (child:is_framing() and p.force_insert ~= '')
  if process then
    local text = child:text()
    local has = vim.endswith(text, p.force_insert)
    local need = not vim.tbl_contains(p.no_insert_if, child:type())
    if need and not has then
      child:_update_text(text .. p.force_insert)
    end
  end
end

---Add or remove last separator
---@param child TreeSJ TreeSJ instance
---@param p table|nil Preset for parent
local function _set_last_sep_if_need(child, p)
  if not p then
    return
  end

  if child:next() and child:next():is_last() then
    local text = child:text()
    if type(text) ~= 'string' then
      local has = vim.endswith(text[#text], p.separator)
      local need = p.last_separator
      if has and not need then
        text[#text] = text[#text]:sub(1, #text[#text] - #p.separator)
      elseif need and not has then
        text[#text] = text[#text] .. p.separator
      end
      child:_update_text(text)
    else
      local has = vim.endswith(text, p.separator)
      local need = p.last_separator

      if has and not need then
        child:_update_text(text:sub(1, #text - #p.separator))
      elseif need and not has then
        child:_update_text(text .. p.separator)
      end
    end
  end
end

---Set indent when 'split'
---@param child TreeSJ TreeSJ instance
local function _set_indent(child)
  local indent = u.calc_indent(child)
  local text = child:text()

  if type(text) == 'table' then
    text[1] = (' '):rep(indent) .. text[1]
  else
    text = (' '):rep(indent) .. text
  end

  child:_update_text(text)
end

---Make result line for 'join'
---@param tsj TreeSJ TreeSJ instance
---@return string
function M._join(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() and child:text() ~= '' then
      local p = tsj:preset(JOIN)

      _set_instruction_sep_if_need(child, p)
      _set_last_sep_if_need(child, p)
      _set_whitespace(child)

      table.insert(lines, child:text())
    elseif child:text() ~= '' then
      _set_whitespace(child)
      table.insert(lines, child:text())
    end
  end

  return table.concat(lines)
end

---Append text to last item in list. If last item is a table, merge to last of this table.
---@param lines table List-like table
---@vararg string
local function _merge_text_to_prev(lines, ...)
  local prev = lines[#lines]
  local text = table.concat({ ... })
  if type(prev) == 'table' then
    prev[#prev] = prev[#prev] .. text
  elseif type(prev) == 'string' then
    lines[#lines] = lines[#lines] .. text
  end
end

---Make result lines for 'split'
---@param tsj TreeSJ TreeSJ instance
---@return string[]
function M._split(tsj)
  local lines = {}

  for child in tsj:iter_children() do
    if tsj:has_preset() then
      local p = tsj:preset(SPLIT)

      _set_indent(child)
      _set_last_sep_if_need(child, p)

      local text = child:text()
      if child:is_omit() then
        _merge_text_to_prev(lines, text)
      else
        table.insert(lines, text)
      end
    elseif tsj:has_to_format() then
      local text = child:text()
      local spacing = u.get_whitespace(child)

      if child:is_first() and type(text) == 'string' then
        table.insert(lines, text)
      elseif type(text) == 'string' then
        _merge_text_to_prev(lines, spacing, text)
      else
        if lines[#lines] then
          _merge_text_to_prev(lines, spacing, text[1])
          table.remove(text, 1)
        end
        table.insert(lines, text)
      end
    else
      _set_whitespace(child:text())
      table.insert(lines, child:text())
    end
  end
  return lines
end

return M
