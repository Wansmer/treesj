local tu = require('tests.utils')

local PATH = './tests/sample/index.svelte'
local LANG = 'svelte'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 4, 10 },
    expected = { 6, 9 },
    result = { 3, 6 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 12, 10 },
    expected = { 14, 17 },
    result = { 11, 14 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 7, 11 },
    expected = { 3, 4 },
    result = { 6, 7 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 16, 6 },
    expected = { 11, 12 },
    result = { 14, 15 },
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
