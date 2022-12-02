local tu = require('tests.utils')

local PATH = './tests/sample/index.pug'
local LANG = 'pug'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "attributes", preset default',
    cursor = { 2, 26 },
    expected = { 4, 8 },
    result = { 1, 5 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "attributes", preset default',
    cursor = { 6, 21 },
    expected = { 1, 2 },
    result = { 4, 5 },
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
