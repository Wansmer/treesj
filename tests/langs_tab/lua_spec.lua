local tu = require('tests.utils')

local PATH = './tests/sample/index_tab.lua'
local LANG = 'lua'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" (with noexpandtab), preset default',
    cursor = { 2, 14 },
    expected = { 4, 7 },
    result = { 1, 4 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (with noexpandtab), preset default',
    cursor = { 10, 15 },
    expected = { 12, 19 },
    result = { 9, 16 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block" (with noexpandtab), preset default',
    cursor = { 5, 14 },
    expected = { 1, 2 },
    result = { 4, 5 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (with noexpandtab), preset default',
    cursor = { 13, 15 },
    expected = { 9, 10 },
    result = { 12, 13 },
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
