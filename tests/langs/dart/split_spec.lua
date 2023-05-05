local tu = require('tests.utils')

local PATH = './tests/sample/index.dart'
local LANG = 'dart'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list_literal", preset default',
    cursor = { 2, 15 },
    expected = { 3, 8 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list_literal" with const, preset default',
    cursor = { 11, 7 },
    expected = { 12, 16 },
    result = { 10, 14 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "set_or_map_literal", preset default',
    cursor = { 19, 27 },
    expected = { 20, 24 },
    result = { 18, 22 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 27, 26 },
    expected = { 28, 32 },
    result = { 26, 30 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 35, 18 },
    expected = { 36, 40 },
    result = { 34, 38 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameter_list", preset default',
    cursor = { 43, 9 },
    expected = { 44, 48 },
    result = { 42, 46 },
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
