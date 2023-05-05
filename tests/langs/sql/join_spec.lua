local tu = require('tests.utils')

local PATH = './tests/sample/index.sql'
local LANG = 'sql'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "column_definitions", preset default',
    cursor = { 4, 22 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 13, 4 },
    expected = { 9, 10 },
    result = { 11, 12 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "select_expression", preset default',
    cursor = { 21, 10 },
    expected = { 17, 19 },
    result = { 20, 22 },
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
