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
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "binding_set", preset default',
    cursor = { 18, 12 },
    expected = { 20, 25 },
    result = { 17, 22 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formals", preset default',
    cursor = { 31, 10 },
    expected = { 35, 41 },
    result = { 30, 36 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "let_expression", preset default',
    cursor = { 45, 6 },
    expected = { 48, 53 },
    result = { 44, 49 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "let_expression" with "attrset_expression", preset default',
    cursor = { 57, 6 },
    expected = { 60, 69 },
    result = { 56, 65 },
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
