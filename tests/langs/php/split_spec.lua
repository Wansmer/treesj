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
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 15, 4 },
    expected = { 17, 22 },
    result = { 14, 19 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 25, 13 },
    expected = { 29, 36 },
    result = { 24, 31 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 39, 27 },
    expected = { 41, 47 },
    result = { 38, 44 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "expression_statement" with target "array_creation_expression", preset default',
    cursor = { 50, 0 },
    expected = { 52, 57 },
    result = { 49, 54 },
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
