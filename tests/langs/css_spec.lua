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
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "keyframe_block_list", preset default',
    cursor = { 13, 25 },
    expected = { 15, 20 },
    result = { 12, 17 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 25, 23 },
    expected = { 30, 48 },
    result = { 24, 42 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 6, 9 },
    expected = { 1, 2 },
    result = { 4, 5 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "keyframe_block_list", preset default',
    cursor = { 17, 4 },
    expected = { 12, 13 },
    result = { 15, 16 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 33, 4 },
    expected = { 24, 25 },
    result = { 30, 31 },
    settings = {},
  },
}

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value)
  end
end)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value)
  end
end)
