local tu = require('tests.utils')

local PATH = './tests/sample/index.cpp'
local LANG = 'cpp'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameter_list", preset default',
    cursor = { 4, 0 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 13, 0 },
    expected = { 10, 11 },
    result = { 12, 13 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "template_parameter_list", preset default',
    cursor = { 23, 0 },
    expected = { 19, 21 },
    result = { 22, 24 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "template_argument_list", preset default',
    cursor = { 32, 0 },
    expected = { 29, 30 },
    result = { 31, 32 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list", preset default',
    cursor = { 40, 0 },
    expected = { 37, 38 },
    result = { 39, 40 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 49, 0 },
    expected = { 46, 47 },
    result = { 48, 49 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 60, 12 },
    expected = { 57, 58 },
    result = { 59, 60 },
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
