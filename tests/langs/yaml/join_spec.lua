local tu = require('tests.utils')

local PATH = './tests/sample/index.yml'
local LANG = 'yaml'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block_mapping", preset default',
    cursor = { 4, 8 },
    expected = { 0, 1 },
    result = { 2, 3 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block_sequence", preset default',
    cursor = { 10, 5 },
    expected = { 6, 7 },
    result = { 8, 9 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block_mapping" (mixed), preset default',
    cursor = { 16, 7 },
    expected = { 12, 13 },
    result = { 14, 15 },
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
