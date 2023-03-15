local tu = require('tests.utils')

local PATH = './tests/sample/index.kt'
local LANG = 'kotlin'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "collection_literal", preset default',
    cursor = { 4, 27 },
    expected = { 5, 10 },
    result = { 3, 8 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "value_arguments", preset default',
    cursor = { 13, 5 },
    expected = { 14, 19 },
    result = { 12, 17 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statements", preset default',
    cursor = { 22, 25 },
    expected = { 23, 27 },
    result = { 21, 25 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "function_declaration (parameters)", preset default',
    cursor = { 30, 22 },
    expected = { 35, 42 },
    result = { 29, 36 },
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
