local tu = require('tests.utils')

local PATH = './tests/sample/index.c'
local LANG = 'c'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameter_list", preset default',
    cursor = { 2, 0 },
    expected = { 3, 8 },
    result = { 1, 6 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 11, 0 },
    expected = { 12, 17 },
    result = { 10, 15 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 20, 0 },
    expected = { 21, 28 },
    result = { 19, 26 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 31, 12 },
    expected = { 32, 35 },
    result = { 30, 33 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list", preset default',
    cursor = { 38, 0 },
    expected = { 39, 44 },
    result = { 37, 42 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameter_list", preset default',
    cursor = { 4, 0 },
    expected = { 1, 2 },
    result = { 3, 4 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 13, 0 },
    expected = { 10, 11 },
    result = { 12, 13 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 22, 0 },
    expected = { 19, 20 },
    result = { 21, 22 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 33, 12 },
    expected = { 30, 31 },
    result = { 32, 33 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list", preset default',
    cursor = { 40, 0 },
    expected = { 37, 38 },
    result = { 39, 40 },
    settings = {},
  },
}

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value)
  end
end)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value)
  end
end)
