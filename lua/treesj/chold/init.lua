local settings = require('treesj.settings').settings
local u = require('treesj.utils')
local cu = require('treesj.chold.utils')

local JOIN = 'join'
local SPLIT = 'split'

---Calculating new position for cursor considering current mode
---@class CHold
---@field pos table Start position of cursor (0-base index)
---@field _new_pos table Computed cursor position (1-base index)
local CHold = {}
CHold.__index = CHold

---Create new CHold instance
---@return CHold
function CHold.new()
  local pos = cu.get_cursor()
  return setmetatable({
    pos = pos,
    _new_pos = {
      col = pos.col,
      row = pos.row + 1,
    },
    _done = false,
  }, CHold)
end

---Update new position for cursor
---@param tsj TreeSJ TreeSJ instance
---@param mode string Current mode
function CHold:update(tsj, mode)
  if not self:is_done() then
    if settings.cursor_behavior == 'start' then
      self:_calc_for_start(tsj)
    elseif settings.cursor_behavior == 'end' then
      self:_calc_for_end(tsj, mode)
    elseif cu.is_not_need_change(self, tsj) then
      self:done()
    elseif cu.is_after_node(self, tsj) then
      self:_calc_when_after(tsj, mode)
    else
      if mode == JOIN then
        self:_calc_for_join(tsj)
      else
        self:_calc_for_split(tsj)
      end
    end
  end
end

---Complute new position for cursor
---@param tsj TreeSJ TreeSJ instance
---@param mode string Current mode (split|join)
function CHold:compute(tsj, mode)
  for child in tsj:iter_children() do
    self:update(child, mode)
  end
end

---Calculate '_new_pos' when settings.cursor_behavior is 'start'
---@param tsj TreeSJ TreeSJ instance
function CHold:_calc_for_start(tsj)
  local rr = u.readable_range(tsj:root():range())
  self:_update_pos({ row = rr.row.start + 1, col = rr.col.start })
  self:done()
end

---Calculate '_new_pos' when settings.cursor_behavior is 'end'
---@param tsj TreeSJ TreeSJ instance
function CHold:_calc_for_end(tsj, mode)
  if tsj:is_last() then
    local lines = tsj:root():get_lines()
    if mode == SPLIT then
      self:_update_pos({
        row = self._new_pos.row + #lines - 1,
        col = #lines[#lines] - 1,
      })
      self:done()
    else
      local rr = u.readable_range(tsj:root():range())
      self:_update_pos({
        col = rr.col.start + #lines[1] - 1,
        row = rr.row.start + 1,
      })
      self:done()
    end
  end
end

---Calculate '_new_pos' when cursor position is after node
---@param tsj TreeSJ TreeSJ instance
function CHold:_calc_when_after(tsj, mode)
  if tsj:is_last() then
    local rr = u.readable_range(tsj:root():range())
    local after = self.pos.col - rr.col.end_
    local lines = tsj:root():get_lines()
    if mode == SPLIT then
      self:_update_pos({
        row = self._new_pos.row + #lines - 1,
        col = #lines[#lines] + after,
      })
      self:done()
    else
      self:_update_pos({
        col = rr.col.start + #lines[1] + after,
        row = rr.row.start + 1,
      })
      self:done()
    end
  end
end

---Calculate '_new_pos' when settings.cursor_behavior is 'hold' and mode is 'join'
---@param tsj TreeSJ TreeSJ instance
function CHold:_calc_for_join(tsj)
  local rr = u.readable_range(tsj:root():child(1):range())

  if cu.in_node_range(self, tsj) then
    self:_update_pos({
      row = rr.row.start + 1,
      col = self._new_pos.col + cu.new_col_pos(self, tsj, JOIN),
    })
    self:done()
    return
  end

  local len = #tsj:text()
  local col = tsj:is_first() and rr.col.start + len or self._new_pos.col + len
  self:_update_pos({ col = col })
end

---Calculate '_new_pos' when settings.cursor_behavior is 'hold' and mode is 'split'
---@param tsj TreeSJ TreeSJ instance
function CHold:_calc_for_split(tsj)
  cu.increase_row(self, tsj)

  if cu.in_node_range(self, tsj) then
    local rr = u.readable_range(tsj:root():range())
    if not (self._new_pos.row - 1 == rr.row.start) then
      self:_update_pos({ col = cu.new_col_pos(self, tsj, SPLIT) })
      self:done()
    else
      self:done()
    end
  end
end

---Checking if new position for cursor is already calculated
---@return boolean
function CHold:is_done()
  return self._done
end

---Set 'done' option to true
function CHold:done()
  self._done = true
end

function CHold:_update_pos(pos)
  self._new_pos = vim.tbl_deep_extend('force', self._new_pos, pos)
end

function CHold:get_cursor()
  return { self._new_pos.row, self._new_pos.col }
end

return CHold
