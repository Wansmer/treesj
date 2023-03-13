local tu = require('tests.utils')

local PATH = './tests/sample/index.yml'
local LANG = 'yaml'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "flow_mapping", preset default',
    cursor = { 1, 6 },
    expected = { 2, 5 },
    result = { 0, 3 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "flow_sequence", preset default',
    cursor = { 7, 8 },
    expected = { 8, 11 },
    result = { 6, 9 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "flow_mapping" (mixed), preset default',
    cursor = { 13, 8 },
    expected = { 14, 19 },
    result = { 12, 17 },
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
