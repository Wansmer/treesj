local tu = require('tests.utils')

local PATH = './tests/sample/index.pl'
local LANG = 'perl'
local MODE = 'split'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "list_expression", preset default',
    cursor = { 4, 20 },
    expected = { 5, 10 },
    result = { 3, 8 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", "list_expression" with "=>" syntax, preset default',
    cursor = { 13, 22 },
    expected = { 14, 18 },
    result = { 12, 16 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "list_expression", preset default',
    cursor = { 21, 22 },
    expected = { 22, 26 },
    result = { 20, 24 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "list_expression", preset default',
    cursor = { 29, 24 },
    expected = { 30, 34 },
    result = { 28, 32 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 37, 24 },
    expected = { 38, 41 },
    result = { 36, 39 },
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
