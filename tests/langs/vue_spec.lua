local tu = require('tests.utils')

local PATH = './tests/sample/index.vue'
local LANG = 'vue'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "start_tag", preset default',
    cursor = { 4, 18 },
    expected = { 6, 10 },
    result = { 3, 7 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 13, 17 },
    expected = { 15, 19 },
    result = { 12, 16 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 22, 59 },
    expected = { 24, 27 },
    result = { 21, 24 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "start_tag", preset default',
    cursor = { 8, 9 },
    expected = { 3, 4 },
    result = { 6, 7 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag", preset default',
    cursor = { 17, 8 },
    expected = { 12, 13 },
    result = { 15, 16 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "element", preset default',
    cursor = { 26, 6 },
    expected = { 21, 22 },
    result = { 24, 25 },
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
