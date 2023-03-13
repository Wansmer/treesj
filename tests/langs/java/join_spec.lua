local tu = require('tests.utils')

local PATH = './tests/sample/index.java'
local LANG = 'java'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array_initializer", preset default',
    cursor = { 10, 5 },
    expected = { 5, 6 },
    result = { 8, 9 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 24, 9 },
    expected = { 15, 19 },
    result = { 21, 25 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "constructor_body", preset default',
    cursor = { 37, 25 },
    expected = { 32, 33 },
    result = { 35, 36 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 46, 7 },
    expected = { 41, 42 },
    result = { 44, 45 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 55, 18 },
    expected = { 50, 51 },
    result = { 53, 54 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "annotation_argument_list", preset default',
    cursor = { 67, 14 },
    expected = { 61, 63 },
    result = { 65, 67 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enum_body", preset default',
    cursor = { 78, 6 },
    expected = { 72, 73 },
    result = { 75, 76 },
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
