local tu = require('tests.utils')

local PATH = './tests/sample/index.go'
local LANG = 'go'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" list, preset default',
    cursor = { 10, 3 },
    expected = { 3, 4 },
    result = { 6, 7 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" dict, preset default',
    cursor = { 19, 9 },
    expected = { 15, 16 },
    result = { 18, 19 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "block", preset default',
    cursor = { 29, 12 },
    expected = { 24, 25 },
    result = { 27, 28 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "parameter_list", preset default',
    cursor = { 40, 10 },
    expected = { 33, 36 },
    result = { 38, 41 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "argument_list", preset default',
    cursor = { 54, 3 },
    expected = { 47, 48 },
    result = { 50, 51 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "import_spec_list to import_spec", preset default',
    cursor = { 61, 8 },
    expected = { 57, 58 },
    result = { 60, 61 },
  },
}

local treesj = require('treesj')
local opts = {}
treesj.setup(opts)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value, treesj)
  end
end)
