local tu = require('tests.utils')

local PATH = './tests/sample/index.json'
local LANG = 'json'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 19, 28 },
    expected = { 4, 8 },
    result = { 18, 22 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 20, 28 },
    expected = { 8, 12 },
    result = { 19, 23 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "paif with target object", preset default',
    cursor = { 19, 6 },
    expected = { 4, 8 },
    result = { 18, 22 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "pair with target array", preset default',
    cursor = { 20, 6 },
    expected = { 8, 12 },
    result = { 19, 23 },
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
