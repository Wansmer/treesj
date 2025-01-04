local tu = require('tests.utils')

local PATH = './tests/sample/index.hs'
local LANG = 'haskell'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 5, 0 },
    expected = { 1, 2 },
    result = { 3, 4 },
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
