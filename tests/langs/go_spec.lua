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
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" dict, preset default',
    cursor = { 16, 2 },
    expected = { 18, 22 },
    result = { 15, 19 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "block", preset default',
    cursor = { 25, 12 },
    expected = { 27, 31 },
    result = { 24, 28 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "parameter_list", preset default',
    cursor = { 34, 27 },
    expected = { 38, 45 },
    result = { 33, 40 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "argument_list", preset default',
    cursor = { 48, 22 },
    expected = { 50, 55 },
    result = { 47, 52 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", block "import_spec to import_spec_list", preset default',
    cursor = { 58, 11 },
    expected = { 60, 63 },
    result = { 57, 60 },
    settings = {},
  },
}

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" list, preset default',
    cursor = { 10, 3 },
    expected = { 3, 4 },
    result = { 6, 7 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "literal_value" dict, preset default',
    cursor = { 19, 9 },
    expected = { 15, 16 },
    result = { 18, 19 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "block", preset default',
    cursor = { 29, 12 },
    expected = { 24, 25 },
    result = { 27, 28 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "parameter_list", preset default',
    cursor = { 40, 10 },
    expected = { 33, 36 },
    result = { 38, 41 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "argument_list", preset default',
    cursor = { 54, 3 },
    expected = { 47, 48 },
    result = { 50, 51 },
    settings = {},
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", block "import_spec_list to import_spec", preset default',
    cursor = { 61, 8 },
    expected = { 57, 58 },
    result = { 60, 61 },
    settings = {},
  },
}

describe('TreeSJ SPLIT:', function()
  for _, value in ipairs(data_for_split) do
    tu._test_format(value)
  end
end)

describe('TreeSJ JOIN:', function()
  for _, value in ipairs(data_for_join) do
    tu._test_format(value)
  end
end)
