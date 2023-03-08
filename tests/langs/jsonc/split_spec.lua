local tu = require('tests.utils')

local PATH = './tests/sample/index.jsonc'
local LANG = 'jsonc'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 17, 19 },
    expected = { 4, 8 },
    result = { 16, 20 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 18, 28 },
    expected = { 8, 12 },
    result = { 17, 21 },
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
