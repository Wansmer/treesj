local tu = require('tests.utils')

local PATH = './tests/sample/index.lua'
local LANG = 'lua'

local recursive = {
  split = {
    recursive = true,
    recursive_ignore = {
      'arguments',
      'parameters',
    },
  },
}

local settings = {
  langs = {
    lua = {
      block = {
        split = recursive.split,
      },
      table_constructor = {
        split = recursive.split,
      },
    },
  },
}

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "block" in function_declaration contains nested functions, preset with recursive',
    cursor = { 80, 15 },
    expected = { 82, 92 },
    result = { 79, 89 },
    settings = settings,
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" with nested "block", preset with recursive',
    cursor = { 95, 13 },
    expected = { 97, 104 },
    result = { 94, 101 },
    settings = settings,
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" with nested "table_constructor", preset with recursive',
    cursor = { 107, 13 },
    expected = { 109, 118 },
    result = { 106, 115 },
    settings = settings,
  },
}

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value)
  end
end)
