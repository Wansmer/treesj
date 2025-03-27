local tu = require('tests.utils')

local PATH = './tests/sample/index.ex'
local LANG = 'elixir'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 8, 4 },
    expected = { 1, 2 },
    result = { 4, 5 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "map", preset default',
    cursor = { 18, 15 },
    expected = { 13, 14 },
    result = { 16, 17 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 28, 3 },
    expected = { 23, 24 },
    result = { 26, 27 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 37, 3 },
    expected = { 32, 33 },
    result = { 35, 36 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 46, 2 },
    expected = { 41, 42 },
    result = { 44, 45 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "keywords", preset default',
    cursor = { 57, 6 },
    expected = { 52, 53 },
    result = { 55, 56 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "map" with "keywords" and "map_content", preset default',
    cursor = { 68, 8 },
    expected = { 64, 65 },
    result = { 67, 68 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list" with "keywords" and "map", preset default',
    cursor = { 79, 4 },
    expected = { 74, 75 },
    result = { 77, 78 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "map" nested "keywords" and "maps", preset default',
    cursor = { 90, 10 },
    expected = { 85, 86 },
    result = { 88, 89 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "call", preset default',
    cursor = { 102, 1 },
    expected = { 98, 99 },
    result = { 101, 102 },
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
