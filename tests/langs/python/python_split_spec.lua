local tu = require('tests.utils')

local PATH = './tests/sample/index.py'
local LANG = 'python'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "dictionary", preset default',
    cursor = { 2, 15 },
    expected = { 3, 8 },
    result = { 1, 6 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 11, 19 },
    expected = { 12, 17 },
    result = { 10, 15 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "set", preset default',
    cursor = { 20, 4 },
    expected = { 21, 29 },
    result = { 19, 27 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 32, 10 },
    expected = { 33, 38 },
    result = { 31, 36 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 41, 17 },
    expected = { 42, 46 },
    result = { 40, 44 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 49, 18 },
    expected = { 54, 58 },
    result = { 48, 52 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parenthesized_expression", preset default',
    cursor = { 64, 25 },
    expected = { 65, 68 },
    result = { 63, 66 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list_comprehension", preset default',
    cursor = { 71, 12 },
    expected = { 72, 76 },
    result = { 70, 74 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "set_comprehension", preset default',
    cursor = { 79, 16 },
    expected = { 80, 85 },
    result = { 78, 83 },
    settings = {},
  },
}

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value)
  end
end)
