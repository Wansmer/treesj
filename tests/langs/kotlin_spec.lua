local tu = require('tests.utils')

local PATH = './tests/sample/index.kt'
local LANG = 'kotlin'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "collection_literal", preset default',
    cursor = { 4, 27 },
    expected = { 5, 10 },
    result = { 3, 8 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "value_arguments", preset default',
    cursor = { 13, 5 },
    expected = { 14, 19 },
    result = { 12, 17 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statements", preset default',
    cursor = { 22, 25 },
    expected = { 23, 27 },
    result = { 21, 25 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "collection_literal", preset default',
    cursor = { 6, 25 },
    expected = { 3, 4 },
    result = { 5, 6 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "value_arguments", preset default',
    cursor = { 17, 3 },
    expected = { 12, 13 },
    result = { 14, 15 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "statements", preset default',
    cursor = { 24, 24 },
    expected = { 21, 22 },
    result = { 23, 24 },
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
