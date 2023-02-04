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
    desc = 'lang "%s", node "template_parameter_list", preset default',
    cursor = { 20, 0 },
    expected = { 22, 27 },
    result = { 19, 24 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "template_argument_list", preset default',
    cursor = { 30, 0 },
    expected = { 31, 35 },
    result = { 29, 33 },
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
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 47, 0 },
    expected = { 48, 55 },
    result = { 46, 53 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 58, 12 },
    expected = { 59, 62 },
    result = { 57, 60 },
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
    desc = 'lang "%s", node "template_parameter_list", preset default',
    cursor = { 23, 0 },
    expected = { 19, 21 },
    result = { 22, 24 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "template_argument_list", preset default',
    cursor = { 32, 0 },
    expected = { 29, 30 },
    result = { 31, 32 },
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
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "initializer_list", preset default',
    cursor = { 49, 0 },
    expected = { 46, 47 },
    result = { 48, 49 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 60, 12 },
    expected = { 57, 58 },
    result = { 59, 60 },
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
