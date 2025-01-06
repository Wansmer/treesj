local tu = require('tests.utils')

local PATH = './tests/sample/index.zig'
local LANG = 'zig'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameter_list", preset default',
    cursor = { 5, 1 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 14, 1 },
    expected = { 10, 11 },
    result = { 12, 13 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 23, 1 },
    expected = { 19, 20 },
    result = { 21, 22 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list", preset default',
    cursor = { 34, 1 },
    expected = { 30, 31 },
    result = { 32, 33 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "struct_declaration", preset default',
    cursor = { 44, 1 },
    expected = { 40, 41 },
    result = { 42, 43 },
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
