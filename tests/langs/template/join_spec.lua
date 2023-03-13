local tu = require('tests.utils')

local PATH = './tests/sample/index.TYPE_OF_FILE'
local LANG = 'NAME_OF_LANGUAGE'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 1, 0 },
    expected = { 0, 0 },
    result = { 0, 0 },
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
