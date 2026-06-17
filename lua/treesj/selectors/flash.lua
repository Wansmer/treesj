local M = {}
local flash = require('flash')
local Pos = require('flash.search.pos')

local opts = { mode = 'treesj' }
function M.setup(config)
  opts = config
end

function M.selector(nodes)
  local currwin = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_get_current_buf()
  local line_count = vim.api.nvim_buf_line_count(buf)
  local state = flash.jump(vim.tbl_deep_extend('force', {
    matcher = function(win, _)
      if win ~= currwin then
        return {}
      end
      local ret = {}
      local done = {}
      -- https://github.com/folke/flash.nvim/blob/967117690bd677cb7b6a87f0bc0077d2c0be3a27/lua/flash/plugins/treesitter.lua#L52
      for i, node in ipairs(nodes) do
        local tsn = node.tsnode
        local range = { tsn:range() }
        local match = {
          win = win,
          node = node,
          pos = { range[1] + 1, range[2] },
          end_pos = { range[3] + 1, range[4] - 1 },
          index = i,
        }

        -- If the match is at the end of the buffer,
        -- then move it to the last character of the last line.
        if match.end_pos[1] > line_count then
          match.end_pos[1] = line_count
          match.end_pos[2] = #vim.api.nvim_buf_get_lines(
            buf,
            match.end_pos[1] - 1,
            match.end_pos[1],
            false
          )[1]
        elseif match.end_pos[2] == -1 then
          -- If the end points to the start of the next line, move it to the
          -- end of the previous line.
          -- Otherwise operations include the first character of the next line
          local line = vim.api.nvim_buf_get_lines(
            buf,
            match.end_pos[1] - 2,
            match.end_pos[1] - 1,
            false
          )[1]
          match.end_pos[1] = match.end_pos[1] - 1
          match.end_pos[2] = #line
        end
        local id =
          table.concat(vim.tbl_flatten({ match.pos, match.end_pos }), '.')
        if not done[id] then
          done[id] = true
          ret[#ret + 1] = match
        end
      end
      for m, match in ipairs(ret) do
        match.pos = Pos(match.pos)
        match.end_pos = Pos(match.end_pos)
        match.depth = #ret - m
      end
      return ret
    end,
    action = function(match, state)
      state.final_match = match
    end,
    search = {
      multi_window = false,
      wrap = true,
      incremental = false,
      max_length = 0,
    },
    label = {
      before = true,
      after = true,
    },
    highlight = {
      matches = false,
    },
    actions = {
      -- TODO: incremental preview/operations
    },
    jump = { autojump = true },
  }, opts or {}))
  local m = state.final_match
  if m then
    return m.node, m.index
  end
end

return M
