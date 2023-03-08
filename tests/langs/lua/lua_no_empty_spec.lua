local tu = require('tests.utils')

local PATH = './tests/sample/index.lua'
local LANG = 'lua'

local settings = {
  langs = {
    lua = {
      table_constructor = {
        both = {
          format_empty_node = false,
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
    desc = 'lang "%s", node "table_constructor" is empty, preset with format_empty_node = false',
    cursor = { 128, 14 },
    expected = { 127, 128 },
    result = { 127, 128 },
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "table_constructor" is empty, preset with format_empty_node = false',
    cursor = { 132, 0 },
    expected = { 130, 132 },
    result = { 130, 132 },
  },
}

local treesj = require('treesj')
local opts = {
  langs = {
    lua = {
      table_constructor = {
        both = {
          format_empty_node = false,
        },
      },
    },
  },
}
treesj.setup(opts)

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value, treesj)
  end
end)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value, treesj)
  end
end)
