local tu = require('tests.utils')

local PATH = './tests/sample/index.lua'
local LANG = 'lua'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (list), preset default',
    cursor = { 4, 16 },
    expected = { 6, 11 },
    result = { 3, 8 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (dict), preset default',
    cursor = { 15, 18 },
    expected = { 17, 23 },
    result = { 14, 20 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (mixed type), preset default',
    cursor = { 26, 19 },
    expected = { 28, 35 },
    result = { 25, 32 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 38, 12 },
    expected = { 40, 44 },
    result = { 37, 41 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 47, 23 },
    expected = { 51, 56 },
    result = { 46, 51 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" in if_statement, preset default',
    cursor = { 61, 15 },
    expected = { 63, 68 },
    result = { 60, 65 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" in function_declaration, preset default',
    cursor = { 71, 15 },
    expected = { 73, 77 },
    result = { 70, 74 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (list), preset default',
    cursor = { 8, 4 },
    expected = { 3, 4 },
    result = { 6, 7 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (dict), preset default',
    cursor = { 19, 4 },
    expected = { 14, 15 },
    result = { 17, 18 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" (mixed type), preset default',
    cursor = { 30, 5 },
    expected = { 25, 26 },
    result = { 28, 29 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "arguments", preset default',
    cursor = { 42, 7 },
    expected = { 37, 38 },
    result = { 37, 38 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 54, 4 },
    expected = { 46, 47 },
    result = { 51, 52 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block" in function_declaration contains nested functions, preset default',
    cursor = { 83, 15 },
    expected = { 79, 80 },
    result = { 82, 83 },
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
