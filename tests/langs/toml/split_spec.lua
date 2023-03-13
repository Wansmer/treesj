local tu = require('tests.utils')

local PATH = './tests/sample/index.toml'
local LANG = 'toml'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 2, 13 },
    expected = { 3, 11 },
    result = { 1, 9 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array" (mix type), preset default',
    cursor = { 14, 10 },
    expected = { 15, 19 },
    result = { 13, 17 },
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
