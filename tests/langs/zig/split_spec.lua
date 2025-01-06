local tu = require('tests.utils')

local PATH = './tests/sample/index.zig'
local LANG = 'zig'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameter_list", preset default',
    cursor = { 2, 7 },
    expected = { 3, 8 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 11, 14 },
    expected = { 12, 17 },
    result = { 10, 15 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 20, 25 },
    expected = { 21, 28 },
    result = { 19, 26 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list", preset default',
    cursor = { 31, 24 },
    expected = { 32, 38 },
    result = { 30, 36 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "struct_declaration", preset default',
    cursor = { 41, 22 },
    expected = { 42, 47 },
    result = { 40, 45 },
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
