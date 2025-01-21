local tu = require('tests.utils')

local PATH = './tests/sample/index.jl'
local LANG = 'julia'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 2, 33 },
    expected = { 3, 8 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "vector_expression", preset default',
    cursor = { 11, 20 },
    expected = { 12, 17 },
    result = { 10, 15 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "matrix_expression", preset default',
    cursor = { 20, 25 },
    expected = { 21, 25 },
    result = { 19, 23 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple_expression", preset default',
    cursor = { 28, 11 },
    expected = { 29, 34 },
    result = { 27, 32 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list" in "function_definition", preset default',
    cursor = { 37, 24 },
    expected = { 42, 49 },
    result = { 36, 43 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "comprehension_expression", preset default',
    cursor = { 52, 24 },
    expected = { 53, 57 },
    result = { 51, 55 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "call_expression", preset default',
    cursor = { 60, 12 },
    expected = { 61, 64 },
    result = { 59, 62 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "using_statement", preset default',
    cursor = { 67, 24 },
    expected = { 68, 71 },
    result = { 66, 69 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "selected_import", preset default',
    cursor = { 74, 24 },
    expected = { 75, 79 },
    result = { 73, 77 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "open_tuple", preset default',
    cursor = { 82, 6 },
    expected = { 83, 88 },
    result = { 81, 86 },
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
