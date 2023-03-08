local tu = require('tests.utils')

local PATH = './tests/sample/index.pug'
local LANG = 'pug'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "attributes", preset default',
    cursor = { 6, 21 },
    expected = { 1, 2 },
    result = { 4, 5 },
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
