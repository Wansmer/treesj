local tu = require('tests.utils')

local PATH = './tests/sample/index.css'
local LANG = 'css'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 2, 20 },
    expected = { 4, 10 },
    result = { 1, 7 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "keyframe_block_list", preset default',
    cursor = { 13, 25 },
    expected = { 15, 20 },
    result = { 12, 17 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 25, 23 },
    expected = { 30, 48 },
    result = { 24, 42 },
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
