local tu = require('tests.utils')

local PATH = './tests/sample/index.go'
local LANG = 'go'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" list, preset default',
    cursor = { 4, 19 },
    expected = { 6, 13 },
    result = { 3, 10 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" dict, preset default',
    cursor = { 16, 2 },
    expected = { 18, 22 },
    result = { 15, 19 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "block", preset default',
    cursor = { 25, 12 },
    expected = { 27, 31 },
    result = { 24, 28 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "parameter_list", preset default',
    cursor = { 34, 27 },
    expected = { 38, 45 },
    result = { 33, 40 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "argument_list", preset default',
    cursor = { 48, 22 },
    expected = { 50, 55 },
    result = { 47, 52 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "import_spec to import_spec_list", preset default',
    cursor = { 58, 11 },
    expected = { 60, 63 },
    result = { 57, 60 },
  },
}

local treesj = require('treesj')
local opts = {}
treesj.setup(opts)

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value, treesj)
  end
end)
