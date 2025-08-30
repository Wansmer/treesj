local tu = require('tests.utils')

local PATH = './tests/sample/index.typ'
local LANG = 'typst'
local MODE = 'join'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "content", preset default',
    cursor = { 5, 4 },
    expected = { 1, 2 },
    result = { 1, 2 },
  },
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "group", preset default',
    cursor = { 12, 4 },
    expected = { 8, 9 },
    result = { 10, 11 },
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
