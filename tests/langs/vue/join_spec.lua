local tu = require('tests.utils')

local PATH = './tests/sample/index.vue'
local LANG = 'vue'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "start_tag", preset default',
    cursor = { 8, 9 },
    expected = { 3, 4 },
    result = { 6, 7 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 17, 8 },
    expected = { 12, 13 },
    result = { 15, 16 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 26, 6 },
    expected = { 21, 22 },
    result = { 24, 25 },
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
