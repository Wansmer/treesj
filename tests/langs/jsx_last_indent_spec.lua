local tu = require('tests.utils')

local PATH = './tests/sample/index.jsx'
local LANG = 'jsx'

local settings = {
  langs = {
    javascript = {
      jsx_self_closing_element = {
        split = {
          omit = { 'identifier', 'nested_identifier', '/', '>' },
          last_indent = 'inner',
        },
      },
    },
  },
}

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "jsx_self_closing_element", preset with last_indent = "inner"',
    cursor = { 48, 32 },
    expected = { 49, 54 },
    result = { 47, 52 },
    settings = settings,
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "jsx_self_closing_element", preset with last_indent = "inner"',
    cursor = { 52, 25 },
    expected = { 47, 48 },
    result = { 49, 50 },
    settings = settings,
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
