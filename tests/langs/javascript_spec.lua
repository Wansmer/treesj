local tu = require('tests.utils')

local PATH = './tests/sample/index.js'
local LANG = 'javascript'

local recursive = {
  split = {
    recursive = true,
    recursive_ignore = {
      'arguments',
      'parameters',
      'formal_parameters',
    },
  },
}

local settings = {
  langs = {
    javascript = {
      object = {
        split = recursive.split,
      },
    },
  },
}

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 4, 16 },
    expected = { 6, 11 },
    result = { 3, 8 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 14, 17 },
    expected = { 16, 22 },
    result = { 13, 19 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 26, 15 },
    expected = { 30, 35 },
    result = { 25, 30 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 40, 8 },
    expected = { 42, 47 },
    result = { 39, 44 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset default',
    cursor = { 50, 24 },
    expected = { 52, 58 },
    result = { 49, 55 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "lexical_declaration" with target "object", preset default',
    cursor = { 61, 7 },
    expected = { 63, 67 },
    result = { 60, 64 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "variable_declaration" with target "object", preset default',
    cursor = { 70, 6 },
    expected = { 72, 76 },
    result = { 69, 73 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment_expression" with target "array", preset default',
    cursor = { 79, 0 },
    expected = { 81, 86 },
    result = { 78, 83 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "named_imports", preset default',
    cursor = { 89, 12 },
    expected = { 91, 96 },
    result = { 88, 93 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "export_clause", preset default',
    cursor = { 99, 12 },
    expected = { 101, 106 },
    result = { 98, 103 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 8, 4 },
    expected = { 3, 4 },
    result = { 6, 7 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 18, 3 },
    expected = { 13, 14 },
    result = { 16, 17 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 32, 2 },
    expected = { 25, 26 },
    result = { 30, 31 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 45, 3 },
    expected = { 39, 40 },
    result = { 42, 43 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset default',
    cursor = { 54, 5 },
    expected = { 49, 50 },
    result = { 52, 53 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "lexical_declaration" with target "object", preset default',
    cursor = { 64, 7 },
    expected = { 60, 61 },
    result = { 63, 64 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "variable_declaration" with target "object", preset default',
    cursor = { 73, 6 },
    expected = { 69, 70 },
    result = { 72, 73 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment_expression" with target "array", preset default',
    cursor = { 82, 0 },
    expected = { 78, 79 },
    result = { 81, 82 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "named_imports", preset default',
    cursor = { 93, 3 },
    expected = { 88, 89 },
    result = { 91, 92 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "export_clause", preset default',
    cursor = { 103, 12 },
    expected = { 98, 99 },
    result = { 101, 102 },
    settings = {},
  },
}

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value)
  end
end)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value)
  end
end)
