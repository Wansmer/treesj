local tu = require('tests.utils')

local PATH = './tests/sample/index.svelte'
local LANG = 'svelte'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 7, 11 },
    expected = { 3, 4 },
    result = { 6, 7 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 16, 6 },
    expected = { 11, 12 },
    result = { 14, 15 },
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
