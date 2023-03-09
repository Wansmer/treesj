local tu = require('tests.utils')
local PATH = './tests/chold/cursor.js'

local settings = {
  cursor_behavior = 'hold',
  langs = {
    javascript = {
      object = {
        split = {
          recursive = true,
        },
      },
      array = {
        split = {
          recursive = true,
        },
      },
    },
  },
}

local data = {
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos inside object',
    cursor = { 4, 77 },
    expected = { 16, 3 },
    result = {},
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos in nested object',
    cursor = { 4, 75 },
    expected = { 9, 3 },
    result = {},
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos after first array',
    cursor = { 14, 25 },
    expected = { 19, 3 },
    result = {},
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos after second array',
    cursor = { 14, 38 },
    expected = { 24, 3 },
    result = {},
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos after third array',
    cursor = { 14, 51 },
    expected = { 29, 3 },
    result = {},
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos on penult sym',
    cursor = { 14, 64 },
    expected = { 34, 3 },
    result = {},
  },
  {
    path = PATH,
    mode = 'split',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos on destructing array',
    cursor = { 41, 33 },
    expected = { 42, 9 },
    result = {},
  },
  {
    path = PATH,
    mode = 'join',
    desc = 'cursor_behavior = "hold", mode = "%s" + resursive, pos on last sep',
    cursor = { 37, 3 },
    expected = { 17, 64 },
    result = {},
  },
}

local treesj = require('treesj')
treesj.setup(settings)

describe('TreeSJ CHOLD:', function()
  for _, value in ipairs(data) do
    tu._test_chold(value, treesj)
  end
end)
