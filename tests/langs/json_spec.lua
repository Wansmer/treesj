local tu = require('tests.utils')

local PATH = './tests/sample/index.json'
local LANG = 'json'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 19, 28 },
    expected = { 4, 8 },
    result = { 18, 22 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 20, 28 },
    expected = { 8, 12 },
    result = { 19, 23 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "paif with target object", preset default',
    cursor = { 19, 6 },
    expected = { 4, 8 },
    result = { 18, 22 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "pair with target array", preset default',
    cursor = { 20, 6 },
    expected = { 8, 12 },
    result = { 19, 23 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 6, 18 },
    expected = { 18, 19 },
    result = { 4, 5 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 10, 12 },
    expected = { 19, 20 },
    result = { 8, 9 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "pair with target object", preset default',
    cursor = { 5, 6 },
    expected = { 18, 19 },
    result = { 4, 5 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 9, 6 },
    expected = { 19, 20 },
    result = { 8, 9 },
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
