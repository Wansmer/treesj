local tu = require('tests.utils')

local PATH = './tests/sample/index.py'
local LANG = 'python'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "dictionary", preset default',
    cursor = { 5, 8 },
    expected = { 1, 2 },
    result = { 3, 4 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 15, 5 },
    expected = { 10, 11 },
    result = { 12, 13 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "set", preset default',
    cursor = { 25, 3 },
    expected = { 19, 20 },
    result = { 21, 22 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 36, 5 },
    expected = { 31, 32 },
    result = { 33, 34 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 44, 18 },
    expected = { 40, 41 },
    result = { 42, 43 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 57, 4 },
    expected = { 48, 49 },
    result = { 54, 55 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parenthesized_expression", preset default',
    cursor = { 67, 25 },
    expected = { 63, 64 },
    result = { 65, 66 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list_comprehension", preset default',
    cursor = { 75, 5 },
    expected = { 70, 71 },
    result = { 72, 73 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "set_comprehension", preset default',
    cursor = { 83, 3 },
    expected = { 78, 79 },
    result = { 80, 81 },
    settings = {},
  },
}

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value)
  end
end)
