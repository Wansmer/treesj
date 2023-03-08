local tu = require('tests.utils')

local PATH = './tests/sample/index.rs'
local LANG = 'rust'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "field_declaration_list", preset default',
    cursor = { 9, 10 },
    expected = { 5, 6 },
    result = { 7, 8 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "field_initializer_list", preset default',
    cursor = { 16, 19 },
    expected = { 13, 14 },
    result = { 15, 16 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 26, 1 },
    expected = { 21, 22 },
    result = { 23, 24 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 33, 7 },
    expected = { 29, 30 },
    result = { 31, 32 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array_expression", preset default',
    cursor = { 42, 4 },
    expected = { 37, 38 },
    result = { 39, 40 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple_expression", preset default',
    cursor = { 51, 6 },
    expected = { 46, 47 },
    result = { 48, 49 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple_type", preset default',
    cursor = { 60, 7 },
    expected = { 55, 56 },
    result = { 57, 58 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 68, 3 },
    expected = { 64, 65 },
    result = { 66, 67 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enum_variant_list", preset default',
    cursor = { 77, 6 },
    expected = { 72, 73 },
    result = { 74, 75 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "declaration_list", preset default',
    cursor = { 86, 25 },
    expected = { 82, 83 },
    result = { 84, 85 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "struct_pattern", preset default',
    cursor = { 100, 27 },
    expected = { 90, 91 },
    result = { 97, 98 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "use_list", preset default',
    cursor = { 112, 4 },
    expected = { 107, 108 },
    result = { 109, 110 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "value" in match_arm, preset default',
    cursor = { 124, 4 },
    expected = { 118, 119 },
    result = { 123, 124 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block" with 2 named children in match_arm, preset default',
    cursor = { 136, 4 },
    expected = { 130, 131 },
    result = { 135, 136 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", field "body" inside closure_expression, preset default',
    cursor = { 146, 15 },
    expected = { 142, 143 },
    result = { 145, 146 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block" inside closure_expression with 2 named children, preset default',
    cursor = { 156, 5 },
    expected = { 150, 151 },
    result = { 153, 154 },
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
