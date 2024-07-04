local tu = require('tests.utils')

local PATH = './tests/sample/index.R'
local LANG = 'R'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", cursor at arguments',
    cursor = { 6, 2 },
    expected = { 1, 2 },
    result = { 4, 5 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", cursor at subset',
    cursor = { 16, 2 },
    expected = { 11, 12 },
    result = { 14, 15 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters"',
    cursor = { 26, 0 },
    expected = { 20, 23 },
    result = { 25, 28 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "left_assignment"',
    cursor = { 37, 7 },
    expected = { 33, 34 },
    result = { 36, 37 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "super_assignment"',
    cursor = { 49, 1 },
    expected = { 45, 46 },
    result = { 48, 49 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "right_assignment"',
    cursor = { 64, 5 },
    expected = { 55, 56 },
    result = { 58, 59 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "super_right_assignment"',
    cursor = { 74, 8 },
    expected = { 66, 67 },
    result = { 69, 70 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "equals_assignment"',
    cursor = { 80, 0 },
    expected = { 76, 77 },
    result = { 79, 80 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "function_definition"',
    cursor = { 94, 10 },
    expected = { 86, 91 },
    result = { 93, 98 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "call"',
    cursor = { 108, 2 },
    expected = { 104, 105 },
    result = { 107, 108 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "binary_operator"',
    cursor = { 118, 0 },
    expected = { 112, 114 },
    result = { 116, 118 },
  },

  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "pipe"',
    cursor = { 128, 0 },
    expected = { 122, 124 },
    result = { 126, 128 },
  },
}

local treesj = require('treesj')
local opts = {}
treesj.setup(opts)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value, treesj)
  end
end)
