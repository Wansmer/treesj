local tu = require('tests.utils')

local PATH = './tests/sample/index.jl'
local LANG = 'julia'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 4, 16 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "vector_expression", preset default',
    cursor = { 14, 3 },
    expected = { 10, 11 },
    result = { 12, 13 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "matrix_expression", preset default',
    cursor = { 23, 6 },
    expected = { 19, 20 },
    result = { 21, 22 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple_expression", preset default',
    cursor = { 30, 6 },
    expected = { 27, 28 },
    result = { 29, 30 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list" in "function_definition", preset default',
    cursor = { 43, 21 },
    expected = { 36, 41 },
    result = { 42, 47 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "comprehension_expression", preset default',
    cursor = { 55, 5 },
    expected = { 51, 52 },
    result = { 53, 54 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "call_expression", preset default',
    cursor = { 62, 12 },
    expected = { 59, 60 },
    result = { 61, 62 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "using_statement", preset default',
    cursor = { 71, 12 },
    expected = { 66, 67 },
    result = { 68, 69 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "selected_import", preset default',
    cursor = { 78, 3 },
    expected = { 73, 74 },
    result = { 75, 76 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple_expression" as left side of assignment, preset default',
    cursor = { 86, 4 },
    expected = { 81, 82 },
    result = { 83, 84 },
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
