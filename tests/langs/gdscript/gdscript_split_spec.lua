local tu = require('tests.utils')

local PATH = './tests/sample/index.gd'
local LANG = 'gdscript'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 2, 11 },
    expected = { 3, 8 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "dictionary", preset default',
    cursor = { 11, 11 },
    expected = { 12, 16 },
    result = { 10, 14 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enumerator_list" and "enum_definition", preset default',
    cursor = { 19, 11 },
    expected = { 20, 25 },
    result = { 18, 23 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters" and "function_definition", preset default',
    cursor = { 28, 11 },
    expected = { 31, 36 },
    result = { 27, 32 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments" and "call", preset default',
    cursor = { 40, 15 },
    expected = { 43, 48 },
    result = { 39, 44 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (array), preset default',
    cursor = { 52, 2 },
    expected = { 55, 60 },
    result = { 51, 56 },
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
