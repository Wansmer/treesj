local tu = require('tests.utils')

local PATH = './tests/sample/index.rs'
local LANG = 'rust'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "field_declaration_list", preset default',
    cursor = { 6, 20 },
    expected = { 7, 11 },
    result = { 5, 9 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "field_initializer_list", preset default',
    cursor = { 14, 4 },
    expected = { 15, 19 },
    result = { 13, 17 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 22, 15 },
    expected = { 23, 27 },
    result = { 21, 25 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 30, 9 },
    expected = { 31, 35 },
    result = { 29, 33 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array_expression", preset default',
    cursor = { 38, 17 },
    expected = { 39, 44 },
    result = { 37, 42 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple_expression", preset default',
    cursor = { 47, 33 },
    expected = { 48, 53 },
    result = { 46, 51 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple_type", preset default',
    cursor = { 56, 15 },
    expected = { 57, 62 },
    result = { 55, 60 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 65, 31 },
    expected = { 66, 70 },
    result = { 64, 68 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enum_variant_list", preset default',
    cursor = { 73, 25 },
    expected = { 74, 80 },
    result = { 72, 78 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "declaration_list", preset default',
    cursor = { 83, 25 },
    expected = { 84, 87 },
    result = { 82, 85 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "struct_pattern", preset default',
    cursor = { 91, 30 },
    expected = { 97, 101 },
    result = { 90, 94 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "use_list", preset default',
    cursor = { 108, 19 },
    expected = { 109, 115 },
    result = { 107, 113 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "value" in match_arm, preset default',
    cursor = { 119, 9 },
    expected = { 123, 126 },
    result = { 118, 121 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" in match_arm, preset default',
    cursor = { 131, 11 },
    expected = { 135, 139 },
    result = { 130, 134 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", field "body" inside closure_expression, preset default',
    cursor = { 143, 18 },
    expected = { 145, 148 },
    result = { 142, 145 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" inside closure_expression with 2 named children, preset default',
    cursor = { 151, 20 },
    expected = { 153, 157 },
    result = { 150, 154 },
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
