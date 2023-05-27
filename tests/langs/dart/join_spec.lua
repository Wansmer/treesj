local tu = require('tests.utils')

local PATH = './tests/sample/index.dart'
local LANG = 'dart'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list_literal", preset default',
    cursor = { 4, 13 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list_literal" with const, preset default',
    cursor = { 13, 13 },
    expected = { 10, 11 },
    result = { 12, 13 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "set_or_map_literal", preset default',
    cursor = { 21, 12 },
    expected = { 18, 19 },
    result = { 20, 21 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 30, 2 },
    expected = { 26, 27 },
    result = { 28, 29 },
  },
  -- {
  --   path = PATH,
  --   mode = 'join',
  --   lang = LANG,
  --   desc = 'lang "%s", node "arguments", preset default',
  --   cursor = { 37, 5 },
  --   expected = { 34, 35 },
  --   result = { 36, 37 },
  -- },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "formal_parameter_list", preset default',
    cursor = { 45, 5 },
    expected = { 42, 43 },
    result = { 44, 45 },
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
