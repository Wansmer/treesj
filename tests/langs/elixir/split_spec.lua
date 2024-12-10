local tu = require('tests.utils')

local PATH = './tests/sample/index.ex'
local LANG = 'elixir'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 2, 13 },
    expected = { 4, 11 },
    result = { 1, 8 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "map", preset default',
    cursor = { 14, 17 },
    expected = { 16, 21 },
    result = { 13, 18 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 24, 11 },
    expected = { 26, 30 },
    result = { 23, 27 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 33, 7 },
    expected = { 35, 39 },
    result = { 32, 36 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 42, 5 },
    expected = { 44, 50 },
    result = { 41, 47 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "keywords", preset default',
    cursor = { 53, 9 },
    expected = { 55, 61 },
    result = { 52, 58 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "map" with "keywords" and "map_content", preset default',
    cursor = { 64, 8 },
    expected = { 66, 71 },
    result = { 63, 68 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list" with "keywords" and "map", preset default',
    cursor = { 74, 9 },
    expected = { 76, 82 },
    result = { 73, 79 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "map" nested "keywords" and "maps", preset default',
    cursor = { 85, 15 },
    expected = { 87, 93 },
    result = { 84, 90 },
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
