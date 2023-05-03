local tu = require('tests.utils')

local PATH = './tests/sample/index.sh'
local LANG = 'bash'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 4, 9 },
    expected = { 5, 10 },
    result = { 3, 8 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "compound_statement", preset default',
    cursor = { 13, 7 },
    expected = { 14, 18 },
    result = { 12, 16 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "do_group", preset default',
    cursor = { 21, 1 },
    expected = { 22, 25 },
    result = { 20, 23 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "if_statement", preset default',
    cursor = { 28, 1 },
    expected = { 29, 32 },
    result = { 27, 30 },
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
