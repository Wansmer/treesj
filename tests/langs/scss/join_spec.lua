local tu = require('tests.utils')

local PATH = './tests/sample/index.scss'
local LANG = 'scss'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 6, 9 },
    expected = { 1, 2 },
    result = { 4, 5 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "keyframe_block_list", preset default',
    cursor = { 17, 4 },
    expected = { 12, 13 },
    result = { 15, 16 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 33, 4 },
    expected = { 24, 25 },
    result = { 30, 31 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block" (nested), preset default',
    cursor = { 56, 9 },
    expected = { 51, 52 },
    result = { 54, 55 },
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
