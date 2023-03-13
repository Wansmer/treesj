local tu = require('tests.utils')

local PATH = './tests/sample/index.cpp'
local LANG = 'cpp'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameter_list", preset default',
    cursor = { 2, 0 },
    expected = { 3, 8 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 11, 0 },
    expected = { 12, 17 },
    result = { 10, 15 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "template_parameter_list", preset default',
    cursor = { 20, 0 },
    expected = { 22, 27 },
    result = { 19, 24 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "template_argument_list", preset default',
    cursor = { 30, 0 },
    expected = { 31, 35 },
    result = { 29, 33 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list", preset default',
    cursor = { 38, 0 },
    expected = { 39, 44 },
    result = { 37, 42 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 47, 0 },
    expected = { 48, 55 },
    result = { 46, 53 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 58, 12 },
    expected = { 59, 62 },
    result = { 57, 60 },
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
