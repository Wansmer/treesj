local tu = require('tests.utils')

local PATH = './tests/sample/index.rb'
local LANG = 'ruby'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 2, 17 },
    expected = { 4, 11 },
    result = { 1, 8 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "hash", preset default',
    cursor = { 14, 17 },
    expected = { 16, 21 },
    result = { 13, 18 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "method_parameters", preset default',
    cursor = { 24, 11 },
    expected = { 26, 30 },
    result = { 23, 27 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 33, 7 },
    expected = { 35, 39 },
    result = { 32, 36 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "string_array", preset default',
    cursor = { 42, 7 },
    expected = { 44, 49 },
    result = { 41, 46 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "body_statement", preset default',
    cursor = { 52, 33 },
    expected = { 54, 58 },
    result = { 51, 55 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block to do_block", preset default',
    cursor = { 61, 8 },
    expected = { 63, 66 },
    result = { 60, 63 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "if_modifier to if", preset default',
    cursor = { 69, 5 },
    expected = { 71, 74 },
    result = { 68, 71 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "conditional to if", preset default',
    cursor = { 77, 4 },
    expected = { 79, 84 },
    result = { 76, 81 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "when", preset default',
    cursor = { 98, 4 },
    expected = { 102, 105 },
    result = { 97, 100 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "right" inside "operator_assignment", preset default',
    cursor = { 109, 10 },
    expected = { 113, 116 },
    result = { 108, 111 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "unless_modifier to unless", preset default',
    cursor = { 120, 5 },
    expected = { 122, 125 },
    result = { 119, 122 },
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
