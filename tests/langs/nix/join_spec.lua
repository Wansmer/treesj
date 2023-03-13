local tu = require('tests.utils')

local PATH = './tests/sample/index.nix'
local LANG = 'nix'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list_expression", preset default',
    cursor = { 10, 5 },
    expected = { 4, 5 },
    result = { 7, 8 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "binding_set", preset default',
    cursor = { 23, 7 },
    expected = { 17, 18 },
    result = { 20, 21 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formals", preset default',
    cursor = { 37, 3 },
    expected = { 30, 31 },
    result = { 35, 36 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "let_expression", preset default',
    cursor = { 49, 6 },
    expected = { 44, 45 },
    result = { 48, 49 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "let_expression" with "attrset_expression", preset default',
    cursor = { 61, 6 },
    expected = { 56, 57 },
    result = { 60, 61 },
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
