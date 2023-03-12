local tu = require('tests.utils')

local PATH = './tests/sample/index.js'
local LANG = 'javascript'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 8, 4 },
    expected = { 3, 4 },
    result = { 6, 7 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 18, 3 },
    expected = { 13, 14 },
    result = { 16, 17 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 32, 2 },
    expected = { 25, 26 },
    result = { 30, 31 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 45, 3 },
    expected = { 39, 40 },
    result = { 42, 43 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset default',
    cursor = { 54, 5 },
    expected = { 49, 50 },
    result = { 52, 53 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "lexical_declaration" with target "object", preset default',
    cursor = { 64, 7 },
    expected = { 60, 61 },
    result = { 63, 64 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "variable_declaration" with target "object", preset default',
    cursor = { 73, 6 },
    expected = { 69, 70 },
    result = { 72, 73 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment_expression" with target "array", preset default',
    cursor = { 82, 0 },
    expected = { 78, 79 },
    result = { 81, 82 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "named_imports", preset default',
    cursor = { 93, 3 },
    expected = { 88, 89 },
    result = { 91, 92 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "export_clause", preset default',
    cursor = { 103, 12 },
    expected = { 98, 99 },
    result = { 101, 102 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "statement_block" (if with return), preset default',
    cursor = { 112, 1 },
    expected = { 108, 109 },
    result = { 111, 112 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "call_expression", preset default',
    cursor = { 123, 19 },
    expected = { 118, 119 },
    result = { 121, 122 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "identifier", preset default',
    cursor = { 131, 13 },
    expected = { 126, 127 },
    result = { 129, 130 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "parenthesized_expression", preset default',
    cursor = { 138, 26 },
    expected = { 134, 135 },
    result = { 137, 138 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "array", preset default',
    cursor = { 148, 0 },
    expected = { 142, 143 },
    result = { 145, 146 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "parenthesized_expression" with "sequence_expression", preset default',
    cursor = { 155, 12 },
    expected = { 150, 151 },
    result = { 153, 154 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "statement_block" with >1 named child, preset default',
    cursor = { 164, 15 },
    expected = { 158, 159 },
    result = { 161, 162 },
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
