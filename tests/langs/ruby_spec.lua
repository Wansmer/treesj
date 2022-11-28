local tu = require('tests.utils')

local PATH = './tests/sample/index.rb'
local LANG = 'ruby'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 2, 17 },
    expected = { 4, 11 },
    result = { 1, 8 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "hash", preset default',
    cursor = { 14, 17 },
    expected = { 16, 21 },
    result = { 13, 18 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 8, 4 },
    expected = { 1, 2 },
    result = { 4, 5 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "hash", preset default',
    cursor = { 18, 15 },
    expected = { 13, 14 },
    result = { 16, 17 },
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
