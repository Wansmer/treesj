local tu = require('tests.utils')

local PATH = './tests/sample/index.nix'
local LANG = 'nix'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list_expression", preset default',
    cursor = { 5, 12 },
    expected = { 7, 15 },
    result = { 4, 12 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "binding_set", preset default',
    cursor = { 18, 12 },
    expected = { 20, 25 },
    result = { 17, 22 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formals", preset default',
    cursor = { 31, 10 },
    expected = { 35, 41 },
    result = { 30, 36 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "let_expression", preset default',
    cursor = { 45, 7 },
    expected = { 49, 54  },
    result = { 44, 49 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list_expression", preset default',
    cursor = { 10, 5 },
    expected = { 4, 5 },
    result = { 7, 8 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "binding_set", preset default',
    cursor = { 23, 7 },
    expected = { 17, 18 },
    result = { 20, 21 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formals", preset default',
    cursor = { 37, 3 },
    expected = { 30, 31 },
    result = { 35, 36 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "let_expression", preset default',
    cursor = { 50, 9 },
    expected = { 44, 46  },
    result = { 49, 51 },
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
