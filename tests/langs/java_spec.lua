local tu = require('tests.utils')

local PATH = './tests/sample/index.java'
local LANG = 'java'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array_initializer", preset default',
    cursor = { 6, 16 },
    expected = { 8, 13 },
    result = { 5, 10 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 16, 33 },
    expected = { 21, 30 },
    result = { 15, 24 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "constructor_body", preset default',
    cursor = { 33, 85 },
    expected = { 35, 39 },
    result = { 32, 36 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 42, 7 },
    expected = { 44, 47 },
    result = { 41, 44 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 51, 30 },
    expected = { 53, 57 },
    result = { 50, 54 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "annotation_argument_list", preset default',
    cursor = { 62, 24 },
    expected = { 65, 70 },
    result = { 61, 66 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enum_body", preset default',
    cursor = { 73, 26 },
    expected = { 75, 80 },
    result = { 72, 77 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array_initializer", preset default',
    cursor = { 10, 5 },
    expected = { 5, 6 },
    result = { 8, 9 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 24, 9 },
    expected = { 15, 19 },
    result = { 21, 25 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "constructor_body", preset default',
    cursor = { 37, 25 },
    expected = { 32, 33 },
    result = { 35, 36 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 46, 7 },
    expected = { 41, 42 },
    result = { 44, 45 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 55, 18 },
    expected = { 50, 51 },
    result = { 53, 54 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "annotation_argument_list", preset default',
    cursor = { 67, 14 },
    expected = { 61, 63 },
    result = { 65, 67 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enum_body", preset default',
    cursor = { 78, 6 },
    expected = { 72, 73 },
    result = { 75, 76 },
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
