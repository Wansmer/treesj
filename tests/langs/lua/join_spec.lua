local tu = require('tests.utils')

local PATH = './tests/sample/index.lua'
local LANG = 'lua'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (list), preset default',
    cursor = { 8, 4 },
    expected = { 3, 4 },
    result = { 6, 7 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (dict), preset default',
    cursor = { 19, 4 },
    expected = { 14, 15 },
    result = { 17, 18 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (mixed type), preset default',
    cursor = { 30, 5 },
    expected = { 25, 26 },
    result = { 28, 29 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 42, 7 },
    expected = { 37, 38 },
    result = { 37, 38 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 54, 4 },
    expected = { 46, 47 },
    result = { 51, 52 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block" in function_declaration contains nested functions, preset default',
    cursor = { 83, 15 },
    expected = { 79, 80 },
    result = { 82, 83 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" is empty, preset default',
    cursor = { 125, 0 },
    expected = { 120, 121 },
    result = { 123, 124 },
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
