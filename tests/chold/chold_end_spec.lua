local tu = require('tests.utils')
local PATH = './tests/chold/cursor.js'

local data = {
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "end", mode = "%s", pos inside block',
    cursor = { 4, 16 },
    expected = { 8, 0 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "end", mode = "%s", pos before block',
    cursor = { 4, 0 },
    expected = { 8, 0 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "end", mode = "%s", pos on first symbol of block',
    cursor = { 4, 12 },
    expected = { 8, 0 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "end", mode = "%s", pos on last symbol of block',
    cursor = { 4, 78 },
    expected = { 8, 0 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "end", mode = "%s", pos inside block',
    cursor = { 9, 4 },
    expected = { 7, 78 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "end", mode = "%s", pos before block',
    cursor = { 7, 0 },
    expected = { 7, 78 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "end", mode = "%s", pos on first symbol of block',
    cursor = { 7, 12 },
    expected = { 7, 78 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "end", mode = "%s", pos on last symbol of block',
    cursor = { 11, 0 },
    expected = { 7, 78 },
    result = {},
    settings = { cursor_behavior = 'end' },
  },
}

describe('TreeSJ CHOLD:', function()
  for _, value in ipairs(data) do
    tu._test_chold(value)
  end
end)
