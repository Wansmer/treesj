local tu = require('tests.utils')

local PATH = './tests/sample/index.rb'
local LANG = 'ruby'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 8, 4 },
    expected = { 1, 2 },
    result = { 4, 5 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "hash", preset default',
    cursor = { 18, 15 },
    expected = { 13, 14 },
    result = { 16, 17 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "method_parameters", preset default',
    cursor = { 28, 3 },
    expected = { 23, 24 },
    result = { 26, 27 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 37, 3 },
    expected = { 32, 33 },
    result = { 35, 36 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "string_array", preset default',
    cursor = { 46, 4 },
    expected = { 41, 42 },
    result = { 44, 45 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "body_statement", preset default',
    cursor = { 57, 4 },
    expected = { 51, 52 },
    result = { 54, 55 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "do_block to block", preset default',
    cursor = { 64, 8 },
    expected = { 60, 61 },
    result = { 63, 64 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "if to if_modifier", preset default',
    cursor = { 72, 1 },
    expected = { 68, 69 },
    result = { 71, 72 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "if to conditional", preset default',
    cursor = { 80, 1 },
    expected = { 76, 77 },
    result = { 79, 80 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "when", preset default',
    cursor = { 103, 1 },
    expected = { 97, 98 },
    result = { 102, 103 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "right" inside "operator_assignment", preset default',
    cursor = { 114, 2 },
    expected = { 108, 109 },
    result = { 113, 114 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "unless to unless_modifier", preset default',
    cursor = { 123, 1 },
    expected = { 119, 120 },
    result = { 122, 123 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "unless to conditional", preset default',
    cursor = { 131, 1 },
    expected = { 127, 128 },
    result = { 130, 131 },
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
