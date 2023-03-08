local tu = require('tests.utils')

local PATH = './tests/sample/index.json'
local LANG = 'json'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 6, 18 },
    expected = { 18, 19 },
    result = { 4, 5 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 10, 12 },
    expected = { 19, 20 },
    result = { 8, 9 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "pair with target object", preset default',
    cursor = { 5, 6 },
    expected = { 18, 19 },
    result = { 4, 5 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 9, 6 },
    expected = { 19, 20 },
    result = { 8, 9 },
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
