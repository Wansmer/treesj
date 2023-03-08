local tu = require('tests.utils')

local PATH = './tests/sample/index.php'
local LANG = 'php'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array_creation_expression", preset default',
    cursor = { 9, 2 },
    expected = { 4, 5 },
    result = { 7, 8 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 19, 2 },
    expected = { 14, 15 },
    result = { 17, 18 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 31, 2 },
    expected = { 24, 27 },
    result = { 29, 32 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 42, 27 },
    expected = { 38, 39 },
    result = { 41, 42 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "expression_statement" with target "array_creation_expression", preset default',
    cursor = { 53, 0 },
    expected = { 49, 50 },
    result = { 52, 53 },
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
