local tu = require('tests.utils')

local PATH = './tests/sample/index.sh'
local LANG = 'bash'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 6, 9 },
    expected = { 3, 4 },
    result = { 5, 6 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 15, 7 },
    expected = { 12, 13 },
    result = { 14, 15 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "do_group", preset default',
    cursor = { 23, 1 },
    expected = { 20, 21 },
    result = { 22, 23 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "if_statement", preset default',
    cursor = { 30, 1 },
    expected = { 27, 28 },
    result = { 29, 30 },
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
