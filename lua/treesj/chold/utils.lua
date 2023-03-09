local u = require('treesj.utils')
local M = {}
local SPLIT = 'split'

---Return table with cursor position (index start zero)
---@return table
function M.get_cursor()
  local c = vim.api.nvim_win_get_cursor(0)
  return { row = c[1] - 1, col = c[2] }
end

---Checking if cursor position need be change
---@param chold CHold CHold instance
---@param tsj TreeSJ TreeSJ instance
---@return boolean
function M.is_not_need_change(chold, tsj)
  tsj = tsj:non_bracket() and tsj:root():child(1) or tsj:root()
  local rr = u.readable_range(tsj:range())
  return chold.pos.row == rr.row.start and chold.pos.col <= rr.col.start
end

---Checking if cursor position is after node
---@param chold CHold
---@param tsj TreeSJ
---@return boolean
function M.is_after_node(chold, tsj)
  local rr = u.readable_range(tsj:root():range())
  return chold.pos.row == rr.row.end_ and chold.pos.col >= rr.col.end_
end

local function observed_range(tsj)
  local cr = tsj:range()
  local prev = tsj:prev()
  if prev then
    local pr = prev:range()
    if cr[1] == pr[1] then
      cr[2] = pr[4]
    else
      cr[1] = pr[3]
      cr[2] = pr[4]
    end
  end
  return cr
end

---Checking if start position of cursor was place in current logic range of node
---@param chold CHold CHold instance
---@param tsj TreeSJ TreeSJ instance
---@return boolean
function M.in_node_range(chold, tsj)
  local result = false

  local cr = observed_range(tsj)

  if cr[1] <= chold.pos.row and chold.pos.row <= cr[3] then
    if chold.pos.row == cr[3] then
      result = chold.pos.col < cr[4]
    elseif chold.pos.row == cr[1] then
      result = chold.pos.col >= cr[2]
    else
      result = true
    end
  end

  return result
end

---Return position of cursor in current node. If this was before start column of node, returning negative value
---@param chold CHold CHold instance
---@param tsj TreeSJ TreeSJ instance
---@param mode string Current mode (split|join)
---@return integer
function M.pos_in_node(chold, tsj, mode)
  local rr = u.readable_range(tsj:range())
  local pos = chold.pos.col - rr.col.start
  local p = tsj:parent():preset(mode)
  local space_sep = p and p.space_separator or 0

  if mode == SPLIT then
    local indent = -u.calc_indent(tsj)
    pos = pos >= indent and pos or indent
  else
    local prev = tsj:prev()
    if prev then
      if
        chold.pos.row ~= tsj:range()[1] and tsj:range()[1] ~= prev:range()[3]
      then
        pos = chold.pos.col - prev:range()[4] - 1
      end
    end
    local sep = -space_sep
    pos = pos >= sep and pos or sep
  end

  return pos
end

---Calculate new position of cursor inside logic range of node
---@param chold CHold CHold instance
---@param tsj TreeSJ TreeSJ instance
---@param mode string Current mode (split|join)
---@return integer
function M.new_col_pos(chold, tsj, mode)
  local pos = M.pos_in_node(chold, tsj, mode)
  local is_need_prev_len = mode == SPLIT and tsj:is_omit()
  local prev_len_corr = is_need_prev_len and #tsj:prev():text() or 0
  local ws = mode == SPLIT and u.calc_indent(tsj) or #u.get_whitespace(tsj)
  return prev_len_corr + ws + pos
end

---Checking if row must be increase and increasing it if needed
---@param tsj TreeSJ TreeSJ instance
---@param chold CHold CHold instance
function M.increase_row(chold, tsj)
  local need_increase_row = not (tsj:is_omit() or tsj:is_first())

  if need_increase_row then
    local text = tsj:text()
    local term = 1

    if type(text) == 'table' then
      if M.in_node_range(chold, tsj) then
        local pos = M.new_col_pos(chold, tsj, 'split')
        local len = 0
        local line_count = 0
        while pos > len do
          line_count = line_count + 1
          len = len + #text[line_count]
        end
        term = line_count
      else
        term = #vim.tbl_flatten(text)
      end
    end
    chold:_update_pos({ row = chold._new_pos.row + term })
  end
end

return M
