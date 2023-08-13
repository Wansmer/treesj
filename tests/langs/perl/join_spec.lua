local tu = require('tests.utils')

local PATH = './tests/sample/index.pl'
local LANG = 'perl'
local MODE = 'join'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 7, 7 },
    expected = { 3, 4 },
    result = { 5, 6 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", "array" with "=>" syntax, preset default',
    cursor = { 16, 7 },
    expected = { 12, 13 },
    result = { 14, 15 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "array_ref", preset default',
    cursor = { 24, 7 },
    expected = { 20, 21 },
    result = { 22, 23 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "hash_ref", preset default',
    cursor = { 32, 7 },
    expected = { 28, 29 },
    result = { 30, 31 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "block", preset default',
    cursor = { 40, 7 },
    expected = { 36, 37 },
    result = { 38, 39 },
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
