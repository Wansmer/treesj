local tu = require('tests.utils')

local PATH = './tests/sample/index.toml'
local LANG = 'toml'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 2, 13 },
    expected = { 3, 11 },
    result = { 1, 9 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array" (mix type), preset default',
    cursor = { 14, 10 },
    expected = { 15, 19 },
    result = { 13, 17 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 4, 11 },
    expected = { 1, 2 },
    result = { 3, 4 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array" (mix type), preset default',
    cursor = { 16, 10 },
    expected = { 13, 14 },
    result = { 15, 16 },
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
