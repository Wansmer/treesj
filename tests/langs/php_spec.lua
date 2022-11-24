local tu = require('tests.utils')

local PATH = './tests/sample/index.php'
local LANG = 'php'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array_creation_expression", preset default',
    cursor = { 5, 9 },
    expected = { 7, 12 },
    result = { 4, 9 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 15, 4 },
    expected = { 17, 22 },
    result = { 14, 19 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 25, 13 },
    expected = { 29, 36 },
    result = { 24, 31 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 39, 27 },
    expected = { 41, 47 },
    result = { 38, 44 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "expression_statement" with target "array_creation_expression", preset default',
    cursor = { 50, 0 },
    expected = { 52, 57 },
    result = { 49, 54 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array_creation_expression", preset default',
    cursor = { 9, 2 },
    expected = { 4, 5 },
    result = { 7, 8 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 19, 2 },
    expected = { 14, 15 },
    result = { 17, 18 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 31, 2 },
    expected = { 24, 27 },
    result = { 29, 32 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 42, 27 },
    expected = { 38, 39 },
    result = { 41, 42 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "expression_statement" with target "array_creation_expression", preset default',
    cursor = { 53, 0 },
    expected = { 49, 50 },
    result = { 52, 53 },
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
