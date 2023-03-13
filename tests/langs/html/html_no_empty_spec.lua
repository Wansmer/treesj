local tu = require('tests.utils')

local PATH = './tests/sample/index.html'
local LANG = 'html'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "element" is empty, preset witn format_empty_node = false',
    cursor = { 57, 15 },
    expected = { 56, 57 },
    result = { 56, 57 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "start_tag" is empty, preset witn format_empty_node = false',
    cursor = { 64, 6 },
    expected = { 63, 64 },
    result = { 63, 64 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag" is empty, preset witn format_empty_node = false',
    cursor = { 71, 9 },
    expected = { 70, 71 },
    result = { 70, 71 },
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "element" is empty, preset witn format_empty_node = false',
    cursor = { 61, 8 },
    expected = { 59, 61 },
    result = { 59, 61 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "start_tag" is empty, preset witn format_empty_node = false',
    cursor = { 68, 7 },
    expected = { 66, 68 },
    result = { 66, 68 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag" is empty, preset witn format_empty_node = false',
    cursor = { 74, 6 },
    expected = { 73, 75 },
    result = { 73, 75 },
  },
}

local treesj = require('treesj')
local opts = {
  langs = {
    html = {
      element = {
        both = {
          format_empty_node = false,
        },
      },
      start_tag = {
        both = {
          format_empty_node = false,
        },
      },
      self_closing_tag = {
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
