local tu = require('tests.utils')
local PATH_JS = './tests/chold/cursor.js'
local PATH_LUA = './tests/chold/cursor.lua'

local data = {
  {
    path = PATH_JS,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos inside block',
    cursor = { 4, 16 },
    expected = { 5, 4 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos before block',
    cursor = { 4, 0 },
    expected = { 4, 0 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on first sym of block',
    cursor = { 4, 12 },
    expected = { 4, 12 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on last sym of block',
    cursor = { 4, 78 },
    expected = { 8, 0 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on penultimate symbol of block',
    cursor = { 4, 77 },
    expected = { 8, 0 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos after block',
    cursor = { 4, 79 },
    expected = { 8, 1 },
    result = {},
  },
  {
    path = PATH_LUA,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos inside non-bracket block',
    cursor = { 2, 63 },
    expected = { 4, 7 },
    result = {},
  },
  {
    path = PATH_LUA,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on last element of non-bracket block',
    cursor = { 11, 27 },
    expected = { 13, 1 },
    result = {},
  },
  {
    path = PATH_LUA,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on space before first element of non-bracket block',
    cursor = { 11, 12 },
    expected = { 12, 1 },
    result = {},
  },
}

local treesj = require('treesj')
treesj.setup({ cursor_behavior = 'hold' })

describe('TreeSJ CHOLD:', function()
  for _, value in ipairs(data) do
    tu._test_chold(value, treesj)
  end
end)
