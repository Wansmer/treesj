local tu = require('tests.utils')

local PATH = './tests/sample/index_recursive.js'
local LANG = 'javascript'

local recursive = {
  split = {
    recursive = true,
    recursive_ignore = {
      'arguments',
      'parameters',
      'formal_parameters',
    },
  },
}

local settings = {
  langs = {
    javascript = {
      object = {
        split = recursive.split,
      },
      statement_block = {
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
    desc = 'lang "%s", node "object", preset with recursive = true',
    cursor = { 2, 17 },
    expected = { 4, 16 },
    result = { 1, 13 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset with recursive = true',
    cursor = { 19, 15 },
    expected = { 21, 30 },
    result = { 18, 27 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "statement_block", preset with recursive = true',
    cursor = { 33, 1 },
    expected = { 35, 40 },
    result = { 32, 37 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "array", preset with recursive = true',
    cursor = { 43, 25 },
    expected = { 45, 48 },
    result = { 42, 45 },
  },
}

local treesj = require('treesj')
local opts = {
  langs = {
    javascript = {
      object = {
        split = recursive.split,
      },
      statement_block = {
        split = recursive.split,
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
