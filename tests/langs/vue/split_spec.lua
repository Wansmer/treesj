local tu = require('tests.utils')

local PATH = './tests/sample/index.vue'
local LANG = 'vue'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "start_tag", preset default',
    cursor = { 4, 18 },
    expected = { 6, 10 },
    result = { 3, 7 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 13, 17 },
    expected = { 15, 19 },
    result = { 12, 16 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 22, 59 },
    expected = { 24, 27 },
    result = { 21, 24 },
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
