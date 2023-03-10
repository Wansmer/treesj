local tu = require('tests.utils')
local PATH_JS = './tests/chold/cursor.js'
local PATH_LUA = './tests/chold/cursor.lua'

local data = {
  {
    path = PATH_JS,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos inside block',
    cursor = { 8, 4 },
    expected = { 7, 16 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos before block',
    cursor = { 7, 3 },
    expected = { 7, 3 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on first sym of block',
    cursor = { 7, 12 },
    expected = { 7, 12 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on last sym of block',
    cursor = { 11, 0 },
    expected = { 7, 78 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos on penultimate symbol of block',
    cursor = { 10, 38 },
    expected = { 7, 77 },
    result = {},
  },
  {
    path = PATH_JS,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos after block',
    cursor = { 11, 1 },
    expected = { 7, 79 },
    result = {},
  },
  {
    path = PATH_LUA,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s", pos inside non-bracket block',
    cursor = { 7, 5 },
    expected = { 5, 61 },
    result = {},
  },
  {
    path = PATH_LUA,
    mode = 'join',
    -- TODO: redescribe, it is not last elem, it is after
    desc = 'cursor_behavior = "hold", mode = "%s", pos on last element of non-bracket block',
    cursor = { 16, 1 },
    expected = { 14, 27 },
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
