local tu = require('tests.utils')

local PATH = './tests/sample/index.html'
local LANG = 'html'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "start_tag" with last_indent = "inner"',
    cursor = { 78, 10 },
    expected = { 79, 82 },
    result = { 77, 80 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag" with last_indent = "inner"',
    cursor = { 85, 29 },
    expected = { 86, 89 },
    result = { 84, 87 },
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "start_tag" with last_indent = "inner"',
    cursor = { 81, 19 },
    expected = { 77, 78 },
    result = { 79, 80 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "self_closing_tag" with last_indent = "inner"',
    cursor = { 88, 19 },
    expected = { 84, 85 },
    result = { 86, 87 },
  },
}

local treesj = require('treesj')
local opts = {
  langs = {
    html = {
      start_tag = {
        split = {
          omit = { 'tag_name', '>' },
          last_indent = 'inner',
        },
      },
      self_closing_tag = {
        split = {
          omit = { 'tag_name', '/>' },
          last_indent = 'inner',
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
