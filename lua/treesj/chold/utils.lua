local u = require('treesj.utils')
local M = {}

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
  local rr = u.readable_range(tsj:root())
  return chold.pos.row == rr.row.start and chold.pos.col <= rr.col.start
end

function M.is_after_node(chold, tsj)
  local rr = u.readable_range(tsj:root())
  return chold.pos.row == rr.row.end_ and chold.pos.col >= rr.col.end_
end

---Checking if start position of cursor was place in current logic range of node
---@param chold CHold CHold instance
---@param tsj TreeSJ TreeSJ instance
---@return boolean
function M.in_node_range(chold, tsj)
  local r = tsj:o_range()
  local cr = chold.pos.row
  local cc = chold.pos.col

  if cr >= r[1] and cr <= r[3] then
    if cr == r[3] then
      return cc < r[4]
    elseif cr == r[3] then
      return cc >= r[2]
    end
    return true
  end
  return false
end

---Return position of cursor in current node. If this was before start column of node, returning negative value
---@param chold CHold CHold instance
---@param tsj TreeSJ TreeSJ instance
---@param mode string Current mode (split|join)
---@return integer
function M.pos_in_node(chold, tsj, mode)
  local rr = u.readable_range(tsj)
  local pos = chold.pos.col - rr.col.start
  local p = tsj:parent():preset(mode)

  if mode == 'split' then
    local indent = -u.calc_indent(tsj)
    pos = pos >= indent and pos or indent
  else
    local sep = -p.space_separator
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
  local is_need_prev_len = mode == 'split' and tsj:is_omit()
  local prev_len_corr = is_need_prev_len and #tsj:prev():text() or 0
  local ws = mode == 'split' and u.calc_indent(tsj) or #u.get_whitespace(tsj)
  return pos + ws + prev_len_corr
end

---Checking if row must be increase and increasing it if needed
---@param tsj TreeSJ TreeSJ instance
---@param chold CHold CHold instance
function M.increase_row(chold, tsj)
  local need_increase_row = not tsj:is_omit() and not tsj:is_first()

  if need_increase_row then
    local text = tsj:text()
    local term = 1

    if type(text) == 'table' then
      if M.in_node_range(chold, tsj) then
        local pos = M.new_col_pos(chold, tsj, 'split')
        local len = 0
        local i = 0
        while pos > len do
          i = i + 1
          len = len + #text[i]
        end
        term = i
      else
        term = #vim.tbl_flatten(text)
      end
    end
    chold:_update_pos({ row = chold._new_pos.row + term })
  end
end

return M
