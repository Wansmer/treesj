local tu = require('tests.utils')

local PATH = './tests/sample/index.TYPE_OF_FILE'
local LANG = 'NAME_OF_LANGUAGE'
local MODE = 'split'

local data = {
  {
    path = PATH,
    mode = MODE,
    lang = LANG,
    desc = 'lang "%s", node "array", preset default',
    cursor = { 1, 0 },
    expected = { 0, 0 },
    result = { 0, 0 },
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
