local tu = require('tests.utils')

local PATH = './tests/sample/index.ts'
local LANG = 'typescript'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object_type", preset default',
    cursor = { 2, 21 },
    expected = { 4, 9 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object_pattern", preset default',
    cursor = { 12, 15 },
    expected = { 14, 18 },
    result = { 11, 15 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enum_body", preset default',
    cursor = { 21, 19 },
    expected = { 23, 27 },
    result = { 20, 24 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "type_parameters", preset default',
    cursor = { 30, 10 },
    expected = { 32, 36 },
    result = { 29, 33 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "type_arguments", preset default',
    cursor = { 39, 20 },
    expected = { 41, 45 },
    result = { 38, 42 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple_type", preset default',
    cursor = { 48, 25 },
    expected = { 50, 54 },
    result = { 47, 51 },
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object_type", preset default',
    cursor = { 6, 12 },
    expected = { 1, 2 },
    result = { 4, 5 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object_pattern", preset default',
    cursor = { 17, 3 },
    expected = { 11, 12 },
    result = { 14, 15 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "enum_body", preset default',
    cursor = { 25, 8 },
    expected = { 20, 21 },
    result = { 23, 24 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "type_parameters", preset default',
    cursor = { 34, 3 },
    expected = { 29, 30 },
    result = { 32, 33 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "type_arguments", preset default',
    cursor = { 43, 3 },
    expected = { 38, 39 },
    result = { 41, 42 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple_type", preset default',
    cursor = { 52, 9 },
    expected = { 47, 48 },
    result = { 50, 51 },
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

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value, treesj)
  end
end)
