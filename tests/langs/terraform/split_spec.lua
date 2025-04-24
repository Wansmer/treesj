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
    cursor = { 7, 6 },
    result = { 6, 7 },
    expected = { 3, 4 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 13, 33 },
    result = { 13, 18 },
    expected = { 16, 21 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_call", preset default',
    cursor = { 23, 11 },
    result = { 23, 28 },
    expected = { 26, 31 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_arguments", preset default',
    cursor = { 23, 18 },
    result = { 23, 28 },
    expected = { 26, 31 },
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
