local tu = require('tests.utils')

local PATH = './tests/sample/index.R'
local LANG = 'R'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", cursor at arguments',
    cursor = { 2, 2 },
    expected = { 4, 9 },
    result = { 1, 6 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", cursor at subset',
    cursor = { 12, 5 },
    expected = { 14, 18 },
    result = { 11, 15 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters"',
    cursor = { 21, 0 },
    expected = { 25, 31 },
    result = { 20, 26 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "left_assignment"',
    cursor = { 34, 7 },
    expected = { 36, 43 },
    result = { 33, 40 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "super_assignment"',
    cursor = { 46, 1 },
    expected = { 48, 53 },
    result = { 45, 50 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "right_assignment"',
    cursor = { 56, 17 },
    expected = { 58, 64 },
    result = { 55, 61 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "super_right_assignment"',
    cursor = { 67, 23 },
    expected = { 69, 74 },
    result = { 66, 71 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "equals_assignment"',
    cursor = { 77, 0 },
    expected = { 79, 84 },
    result = { 76, 81 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "function_definition"',
    cursor = { 87, 10 },
    expected = { 93, 102 },
    result = { 86, 95 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "call"',
    cursor = { 105, 2 },
    expected = { 107, 110 },
    result = { 104, 107 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "binary_operator"',
    cursor = { 114, 0 },
    expected = { 116, 120 },
    result = { 112, 116 },
  },

  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "pipe"',
    cursor = { 124, 0 },
    expected = { 126, 130 },
    result = { 122, 126 },
  },
}

local treesj = require('treesj')
local opts = {}
treesj.setup(opts)

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value, treesj)
  end
end)
