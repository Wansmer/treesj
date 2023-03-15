local tu = require('tests.utils')

local PATH = './tests/sample/index.kt'
local LANG = 'kotlin'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "collection_literal", preset default',
    cursor = { 6, 25 },
    expected = { 3, 4 },
    result = { 5, 6 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "value_arguments", preset default',
    cursor = { 17, 3 },
    expected = { 12, 13 },
    result = { 14, 15 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "statements", preset default',
    cursor = { 24, 24 },
    expected = { 21, 22 },
    result = { 23, 24 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "function_declaration" (parameters), preset default',
    cursor = { 38, 10 },
    expected = { 29, 33 },
    result = { 35, 39 },
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
