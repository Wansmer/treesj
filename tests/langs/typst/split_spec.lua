local tu = require('tests.utils')

local PATH = './tests/sample/index.typ'
local LANG = 'typst'
local MODE = 'split'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "content", preset default',
    cursor = { 2, 11 },
    expected = { 3, 6 },
    result = { 1, 4 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "group", preset default',
    cursor = { 9, 20 },
    expected = { 10, 15 },
    result = { 8, 13 },
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
