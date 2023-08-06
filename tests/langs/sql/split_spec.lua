local tu = require('tests.utils')

local PATH = './tests/sample/index.sql'
local LANG = 'sql'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "column_definitions", preset default',
    cursor = { 2, 25 },
    expected = { 3, 7 },
    result = { 1, 5 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 10, 25 },
    expected = { 11, 15 },
    result = { 9, 13 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "select_expression", preset default',
    cursor = { 18, 23 },
    expected = { 20, 24 },
    result = { 17, 21 },
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
