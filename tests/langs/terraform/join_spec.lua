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
    cursor = { 3, 14 },
    result = { 3, 8 },
    expected = { 6, 11 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "object", preset default',
    cursor = { 18, 10 },
    result = { 16, 17 },
    expected = { 13, 14 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_call", preset default',
    cursor = { 26, 11 },
    result = { 26, 27 },
    expected = { 23, 24 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "function_arguments", preset default',
    cursor = { 27, 8 },
    result = { 26, 27 },
    expected = { 23, 24 },
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
