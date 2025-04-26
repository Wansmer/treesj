local tu = require('tests.utils')

local PATH = './tests/sample/index.tf'
local LANG = 'terraform'
local MODE = 'join'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    result = { 5, 6 },
    cursor = { 7, 5 },
    expected = { 2, 3 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 18, 10 },
    result = { 15, 16 },
    expected = { 12, 13 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_call", preset default',
    cursor = { 26, 11 },
    result = { 25, 26 },
    expected = { 22, 23 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_arguments", preset default',
    cursor = { 27, 8 },
    result = { 25, 26 },
    expected = { 22, 23 },
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
