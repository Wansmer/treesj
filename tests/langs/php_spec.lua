local tu = require('tests.utils')

local PATH = './tests/sample/index.php'
local LANG = 'php'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array_creation_expression", preset default',
    cursor = { 5, 9 },
    expected = { 7, 12 },
    result = { 4, 9 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "array_creation_expression", preset default',
    cursor = { 9, 4 },
    expected = { 4, 5 },
    result = { 7, 8 },
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
