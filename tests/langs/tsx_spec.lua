local tu = require('tests.utils')

local PATH = './tests/sample/index.tsx'
local LANG = 'tsx'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "object_pattern", preset default',
    cursor = { 3, 19 },
    expected = { 4, 12 },
    result = { 2, 10 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 14, 17 },
    expected = { 15, 20 },
    result = { 13, 18 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "jsx_self_closing_element", preset default',
    cursor = { 24, 20 },
    expected = { 25, 31 },
    result = { 23, 29 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "jsx_opening_element", preset default',
    cursor = { 33, 16 },
    expected = { 34, 40 },
    result = { 32, 38 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "jsx_element", preset default',
    cursor = { 42, 83 },
    expected = { 43, 46 },
    result = { 41, 44 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "object_pattern", preset default',
    cursor = { 6, 8 },
    expected = { 2, 3 },
    result = { 4, 5 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 17, 4 },
    expected = { 13, 14 },
    result = { 15, 16 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "jsx_self_closing_element", preset default',
    cursor = { 27, 12 },
    expected = { 23, 24 },
    result = { 25, 26 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "jsx_opening_element", preset default',
    cursor = { 36, 14 },
    expected = { 32, 33 },
    result = { 34, 35 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "jsx_element", preset default',
    cursor = { 45, 9 },
    expected = { 41, 42 },
    result = { 43, 44 },
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
