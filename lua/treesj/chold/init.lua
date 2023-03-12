local settings = require('treesj.settings').settings
local search = require('treesj.search')
local tu = require('treesj.treesj.utils')
local u = require('treesj.utils')

local BEHAVIOR = settings.cursor_behavior
local special_types = {
  'left_non_bracket',
  'right_non_bracket',
  'left_bracket',
  'right_bracket',
}

local function prev_not_deleted(child)
  local tsn = child:tsnode()
  local prev_tsn = tsn:prev_sibling()
  while prev_tsn do
    local not_removed = u.some(child:parent():children(), function(el)
      return el:tsnode() == prev_tsn
    end)
    if not_removed then
      return prev_tsn
    end
    prev_tsn = prev_tsn:prev_sibling()
  end
  return nil
end

local function observed_range(child)
  local tsn = child:tsnode()
  local prev_tsn
  if
    child:prev()
    and child:prev():is_imitator()
    and vim.tbl_contains(special_types, child:prev():type())
  then
    prev_tsn = child:prev():tsnode()
  else
    prev_tsn = prev_not_deleted(child)
  end
  local sr, sc, er, ec = tsn:range()

  if prev_tsn then
    _, _, sr, sc = prev_tsn:range()
  end

  return { sr + 1, sc, er + 1, ec }
end

local function in_range(cursor, range, mode)
  local cr, cc = unpack(cursor)
  local sr, sc, er, ec = unpack(range)

  if mode == 'join' then
    if sr <= cr and cr <= er then
      if sr == cr then
        return cc >= sc
      elseif cr == er then
        return cc < ec
      else
        return true
      end
    end
    return false
  else
    return sc <= cc and cc < ec
  end
end

local function pos_in_node(cursor, child)
  local range = { child:tsnode():range() }
  local cursor_col = cursor[1] ~= range[1] + 1 and -1 or cursor[2]
  return cursor_col - range[2]
end

local function calc_new_pos(cursor, child, mode)
  local ws = mode == 'join' and #tu.get_whitespace(child)
    or tu.calc_indent(child)
  local pos = pos_in_node(cursor, child)
  pos = pos < -ws and -ws or pos
  return pos + ws
end

local function need_check(child)
  return not child:is_imitator()
    or (vim.tbl_contains(special_types, child:type()) and child:is_framing())
end

local function get_cursor_for_join(tsj, rowcol, cursor)
  local len = 0
  local row, col = unpack(rowcol)

  for child in tsj:iter_children() do
    local is_in_range = need_check(child)
      and in_range(cursor, observed_range(child), 'join')

    if is_in_range then
      local pos = calc_new_pos(cursor, child, 'join')
      col = col + len + pos
      break
    else
      len = len + #child:text()
    end
  end

  return row, col
end

local function get_cursor_for_split(tsj, rowcol, cursor)
  local row, col = unpack(rowcol)

  for child in tsj:iter_children() do
    local is_in_range = need_check(child)
      and in_range(cursor, observed_range(child), 'split')

    if not child:is_first() then
      local rows = is_in_range and 1
        or (type(child:text()) == 'string' and 1 or #child:text())
      col = 0
      row = child:is_omit() and row or row + rows
    end

    if is_in_range then
      local pos = calc_new_pos(cursor, child, 'split')
      local len = child:is_omit() and #child:prev():text() or 0
      col = pos + col + len
      break
    end
  end

  return row, col
end

local CHold = {}
CHold.__index = CHold

function CHold.new()
  local pos = vim.api.nvim_win_get_cursor(0)
  return setmetatable({
    row = pos[1],
    col = pos[2],
    original = pos,
  }, CHold)
end

function CHold:compute(tsj, mode)
  -- local range = { search.range(tsj:root():tsnode(), tsj:root():preset()) }
  local range = { search.range(tsj:tsnode(), tsj:preset()) }

  -- Use position for `start` behavior by default
  local row, col = range[1] + 1, range[2]

  if BEHAVIOR == 'hold' then
    local cursor = self:get_cursor()
    -- Checking if the cursor needs to be moved
    if cursor[1] == range[1] + 1 and cursor[2] < range[2] then
      return
    end

    -- Checking if the cursor is after a node
    if cursor[1] == range[3] + 1 and cursor[2] >= range[4] then
      local lines = tsj:get_lines()
      local shift = cursor[2] - range[4]
      local start = range[2]

      if mode == 'split' then
        start = 0
        row = row + #lines - 1
      end

      col = #lines[#lines] + shift + start
    else
      if mode == 'join' then
        row, col = get_cursor_for_join(tsj, { row, col }, cursor)
      else
        row, col = get_cursor_for_split(tsj, { row, col }, cursor)
      end
    end
  elseif BEHAVIOR == 'end' then
    local lines = tsj:get_lines()
    local text_len = #lines[#lines]
    row = mode == 'join' and range[1] + 1 or range[1] + #lines
    col = mode == 'join' and (range[2] + text_len - 1) or text_len - 1
  end

  self:update_pos({ row = row, col = col })
end

function CHold:get_cursor()
  return { self.row, self.col }
end

function CHold:update_pos(pos)
  self.row = pos.row >= 1 and pos.row or self.row
  self.col = pos.col >= 0 and pos.col or self.col
end

return CHold
