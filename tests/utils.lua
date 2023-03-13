local M = {}

local a = vim.api

local function open_ang_get_buf(path)
  vim.cmd(':e ' .. path)
  return a.nvim_get_current_buf()
end

function M._test_format(v, treesj)
  local desc = v.desc:format(v.lang)

  it(desc, function()
    local bufnf = open_ang_get_buf(v.path)
    local expected =
      a.nvim_buf_get_lines(bufnf, v.expected[1], v.expected[2], true)
    a.nvim_win_set_cursor(0, v.cursor)
    treesj[v.mode]()
    local result = a.nvim_buf_get_lines(bufnf, v.result[1], v.result[2], true)
    a.nvim_buf_delete(bufnf, { force = true })
    assert.are.same(expected, result)
  end)
end

function M._test_chold(v, treesj)
  -- local treesj = require('treesj')
  -- treesj.setup(v.settings)
  local desc = v.desc:format(v.mode)

  it(desc, function()
    local bufnf = open_ang_get_buf(v.path)
    a.nvim_win_set_cursor(0, v.cursor)
    treesj[v.mode]()
    local result = a.nvim_win_get_cursor(0)
    a.nvim_buf_delete(bufnf, { force = true })
    assert.are.same(v.expected, result)
  end)
end

return M
