local u = require('treesj.utils')
local lu = require('treesj.langs.utils')

local JOIN = 'join'
local SPLIT = 'split'

local M = {}

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

---Add or remove last separator in node
---@param children table List of children of root node
---@param preset table
function M.handle_last_separator(children, preset)
  local len = #children
  local penult = children[len - 1]

  if penult and preset.separator ~= '' then
    local sep = preset.separator
    local has = penult:type() == sep
    local need = preset.last_separator

    if penult and not (penult == children[1]) then
      if has and not need then
        table.remove(children, len - 1)
      elseif not has and need then
        local imitator =
          lu.imitate_tsn(penult, penult:parent(), 'end', preset.separator)
        table.insert(children, len, imitator)
      end
    end
  end

  return children
end

function M.add_framing_nodes(children, preset, tsj)
  local framing = preset.add_framing_nodes
  if preset.non_bracket_node or framing then
    if type(framing) == 'function' then
      framing = framing(tsj)
      if not framing then
        return children
      end
    end

    local left = framing and framing.left
    local right = framing and framing.right

    -- TODO: find right condition
    if framing and framing.mode == 'pack' then
      children = { tsj:tsnode() }
    end

    M.add_first_last_imitator(tsj:tsnode(), children, left, right)
  end
  return children
end

---Checking if tsn is TSNode instance. False if it imitator of tsn
---@param tsn userdata|table
---@return boolean
function M.is_tsnode(tsn)
  return type(tsn) == 'userdata'
end

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

---Add first and last imitator nodas to children list for non-bracket blocks
---@param node userdata TSNode instance
---@param children table
---@param left? string
---@param right? string
function M.add_first_last_imitator(node, children, left, right)
  local first, last = u.get_non_bracket_first_last(node)
  table.insert(children, 1, lu.imitate_tsn(first, node, 'first', left))
  table.insert(children, lu.imitate_tsn(last, node, 'last', right))
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

      if not child._remove then
        if is_instruction_sep_need(child, p) then
          child:update_text(child:text() .. p.force_insert)
        end

        set_whitespace(child)

        table.insert(lines, child:text())
      end
    else
      set_whitespace(child)
      table.insert(lines, child:text())
    end
  end

  lines = collapse_spacing(lines)

  if tsj:has_lifecycle('before_text_insert', 'join') then
    lines = tsj:preset('join').lifecycle.before_text_insert(lines, tsj)
  end

  return table.concat(lines)
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
      local cb = tsj:preset('split').foreach

      if cb then
        cb(child)
      end

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

  if tsj:has_lifecycle('before_text_insert', 'split') then
    lines = tsj:preset('split').lifecycle.before_text_insert(lines, tsj)
  end

  return lines
end

return M
