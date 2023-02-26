local tu = require('tests.utils')

local PATH = './tests/sample/index.yml'
local LANG = 'yaml'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "flow_mapping", preset default',
    cursor = { 1, 6 },
    expected = { 2, 5 },
    result = { 0, 3 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "flow_sequence", preset default',
    cursor = { 7, 8 },
    expected = { 8, 11 },
    result = { 6, 9 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "flow_mapping" (mixed), preset default',
    cursor = { 13, 8 },
    expected = { 14, 19 },
    result = { 12, 17 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block_mapping", preset default',
    cursor = { 4, 8 },
    expected = { 0, 1 },
    result = { 2, 3 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block_sequence", preset default',
    cursor = { 10, 5 },
    expected = { 6, 7 },
    result = { 8, 9 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block_mapping" (mixed), preset default',
    cursor = { 16, 7 },
    expected = { 12, 13 },
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
