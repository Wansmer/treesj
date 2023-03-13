local tu = require('tests.utils')

local PATH = './tests/sample/index.pug'
local LANG = 'pug'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "attributes", preset default',
    cursor = { 2, 26 },
    expected = { 4, 8 },
    result = { 1, 5 },
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
