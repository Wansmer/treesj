local tu = require('tests.utils')

local PATH = './tests/sample/index.TYPE_OF_FILE'
local LANG = 'NAME_OF_LANGUAGE'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 1, 0 },
    expected = { 0, 0 },
    result = { 0, 0 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 1, 0 },
    expected = { 0, 0 },
    result = { 0, 0 },
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
