local tu = require('tests.utils')

local PATH = './tests/sample/index_recursive.kt'
local LANG = 'kotlin'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statements" with child with "shrink_node" option, preset default',
    cursor = { 2, 24 },
    expected = { 3, 10 },
    result = { 1, 8 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "statements" with child with "shrink_node" option, preset default',
    cursor = { 4, 24 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
}

local treesj = require('treesj')
local opts = {
  langs = {
    kotlin = {
      statements = {
        split = {
          recursive = true,
          recursive_ignore = { 'value_arguments' },
        },
      },
    },
  },
}
treesj.setup(opts)

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value, treesj)
  end
end)
