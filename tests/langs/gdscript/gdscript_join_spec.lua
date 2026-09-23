local tu = require('tests.utils')

local PATH = './tests/sample/index.gd'
local LANG = 'gdscript'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 5, 2 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "dictionary", preset default',
    cursor = { 14, 2 },
    expected = { 10, 11 },
    result = { 12, 13 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list" and "enum_definition", preset default',
    cursor = { 22, 2 },
    expected = { 18, 19 },
    result = { 20, 21 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters" and "function_definition", preset default',
    cursor = { 33, 2 },
    expected = { 27, 29 },
    result = { 31, 33 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments" and "call", preset default',
    cursor = { 45, 4 },
    expected = { 39, 40 },
    result = { 43, 44 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (array), preset default',
    cursor = { 57, 4 },
    expected = { 51, 52 },
    result = { 55, 56 },
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
