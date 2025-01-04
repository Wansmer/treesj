local tu = require('tests.utils')

local PATH = './tests/sample/index.hs'
local LANG = 'haskell'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 2, 12 },
    expected = { 3, 8 },
    result = { 1, 6 },
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
