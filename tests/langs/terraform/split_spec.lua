local tu = require('tests.utils')

local PATH = './tests/sample/index.tf'
local LANG = 'terraform'
local MODE = 'split'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 3, 12},
    result = { 2, 7 },
    expected = { 5, 10},
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 13, 33 },
    result = { 12, 17 },
    expected = { 15, 20 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_call", preset default',
    cursor = { 23, 11 },
    result = { 22, 27 },
    expected = { 25, 30 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_arguments", preset default',
    cursor = { 23, 18 },
    result = { 22, 27 },
    expected = { 25, 30 },
  },
}

local treesj = require('treesj')
local opts = {}
treesj.setup(opts)

describe('TreeSJ ' .. MODE:upper() .. ':', function()
  for _, value in ipairs(data) do
    tu._test_format(value, treesj)
  end
end)
