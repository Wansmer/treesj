local tu = require('tests.utils')
local PATH = './tests/chold/cursor.js'

local data = {
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "start", mode = "%s", pos inside block',
    cursor = { 4, 16 },
    expected = { 4, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "start", mode = "%s", pos before block',
    cursor = { 4, 0 },
    expected = { 4, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "start", mode = "%s", pos on first sym of block',
    cursor = { 4, 12 },
    expected = { 4, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "start", mode = "%s", pos on last sym of block',
    cursor = { 4, 78 },
    expected = { 4, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "start", mode = "%s", pos inside block',
    cursor = { 8, 4 },
    expected = { 7, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "start", mode = "%s", pos before block',
    cursor = { 7, 0 },
    expected = { 7, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "start", mode = "%s", pos on first sym of block',
    cursor = { 7, 12 },
    expected = { 7, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "start", mode = "%s", pos on last sym of block',
    cursor = { 11, 0 },
    expected = { 7, 12 },
    result = {},
    settings = { cursor_behavior = 'start' },
  },
}

describe('TreeSJ CHOLD:', function()
  for _, value in ipairs(data) do
    tu._test_chold(value)
  end
end)
