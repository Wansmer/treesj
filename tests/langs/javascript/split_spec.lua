local tu = require('tests.utils')

local PATH = './tests/sample/index.js'
local LANG = 'javascript'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 4, 16 },
    expected = { 6, 11 },
    result = { 3, 8 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 14, 17 },
    expected = { 16, 22 },
    result = { 13, 19 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 26, 15 },
    expected = { 30, 35 },
    result = { 25, 30 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 40, 8 },
    expected = { 42, 47 },
    result = { 39, 44 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset default',
    cursor = { 50, 24 },
    expected = { 52, 58 },
    result = { 49, 55 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "lexical_declaration" with target "object", preset default',
    cursor = { 61, 7 },
    expected = { 63, 67 },
    result = { 60, 64 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "variable_declaration" with target "object", preset default',
    cursor = { 70, 6 },
    expected = { 72, 76 },
    result = { 69, 73 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment_expression" with target "array", preset default',
    cursor = { 79, 0 },
    expected = { 81, 86 },
    result = { 78, 83 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "named_imports", preset default',
    cursor = { 89, 12 },
    expected = { 91, 96 },
    result = { 88, 93 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "export_clause", preset default',
    cursor = { 99, 12 },
    expected = { 101, 106 },
    result = { 98, 103 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset default',
    cursor = { 109, 1 },
    expected = { 111, 116 },
    result = { 108, 113 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "call_expression", preset default',
    cursor = { 119, 26 },
    expected = { 121, 124 },
    result = { 118, 121 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "identifier", preset default',
    cursor = { 127, 28 },
    expected = { 129, 132 },
    result = { 126, 129 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "parenthesized_expression", preset default',
    cursor = { 135, 26 },
    expected = { 137, 140 },
    result = { 134, 137 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "object" in "parenthesized_expression", preset default',
    cursor = { 135, 26 },
    expected = { 137, 140 },
    result = { 134, 137 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "array", preset default',
    cursor = { 143, 23 },
    expected = { 145, 148 },
    result = { 142, 145 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "parenthesized_expression" with "sequence_expression", preset default',
    cursor = { 151, 29 },
    expected = { 153, 156 },
    result = { 150, 153 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" in "arrow_function" with "statement_block" with >1 named child, preset default',
    cursor = { 159, 50 },
    expected = { 161, 164 },
    result = { 158, 161 },
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
