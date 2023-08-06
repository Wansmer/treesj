local tu = require('tests.utils')

local PATH = './tests/sample/index.lua'
local LANG = 'lua'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (list), preset default',
    cursor = { 4, 16 },
    expected = { 6, 11 },
    result = { 3, 8 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (dict), preset default',
    cursor = { 15, 18 },
    expected = { 17, 23 },
    result = { 14, 20 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (mixed type), preset default',
    cursor = { 26, 19 },
    expected = { 28, 35 },
    result = { 25, 32 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 38, 12 },
    expected = { 40, 44 },
    result = { 37, 41 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 47, 23 },
    expected = { 51, 56 },
    result = { 46, 51 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" in if_statement, preset default',
    cursor = { 61, 15 },
    expected = { 63, 68 },
    result = { 60, 65 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" in function_declaration, preset default',
    cursor = { 71, 15 },
    expected = { 73, 77 },
    result = { 70, 74 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" is empty, preset default',
    cursor = { 121, 14 },
    expected = { 123, 125 },
    result = { 120, 122 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" with empty table, preset default',
    cursor = { 135, 14 },
    expected = { 136, 140 },
    result = { 134, 138 },
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
