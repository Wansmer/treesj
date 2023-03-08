local tu = require('tests.utils')

local PATH = './tests/sample/index.java'
local LANG = 'java'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array_initializer", preset default',
    cursor = { 6, 16 },
    expected = { 8, 13 },
    result = { 5, 10 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameters", preset default',
    cursor = { 16, 33 },
    expected = { 21, 30 },
    result = { 15, 24 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "constructor_body", preset default',
    cursor = { 33, 85 },
    expected = { 35, 39 },
    result = { 32, 36 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 42, 7 },
    expected = { 44, 47 },
    result = { 41, 44 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 51, 30 },
    expected = { 53, 57 },
    result = { 50, 54 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "annotation_argument_list", preset default',
    cursor = { 62, 24 },
    expected = { 65, 70 },
    result = { 61, 66 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "enum_body", preset default',
    cursor = { 73, 26 },
    expected = { 75, 80 },
    result = { 72, 77 },
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
