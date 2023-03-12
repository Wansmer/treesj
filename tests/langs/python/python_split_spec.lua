local tu = require('tests.utils')

local PATH = './tests/sample/index.py'
local LANG = 'python'

local data_for_split = {
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "dictionary", preset default',
    cursor = { 2, 15 },
    expected = { 3, 8 },
    result = { 1, 6 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 11, 19 },
    expected = { 12, 17 },
    result = { 10, 15 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "set", preset default',
    cursor = { 20, 4 },
    expected = { 21, 29 },
    result = { 19, 27 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 32, 10 },
    expected = { 33, 38 },
    result = { 31, 36 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 41, 17 },
    expected = { 42, 46 },
    result = { 40, 44 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 49, 18 },
    expected = { 54, 58 },
    result = { 48, 52 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "parenthesized_expression", preset default',
    cursor = { 64, 25 },
    expected = { 65, 68 },
    result = { 63, 66 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "list_comprehension", preset default',
    cursor = { 71, 12 },
    expected = { 72, 76 },
    result = { 70, 74 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "set_comprehension", preset default',
    cursor = { 79, 16 },
    expected = { 80, 85 },
    result = { 78, 83 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "dictionary_comprehension"',
    cursor = { 88, 0 },
    expected = { 90, 94 },
    result = { 87, 91 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "decorator"',
    cursor = { 97, 1 },
    expected = { 99, 103 },
    result = { 96, 100 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "raise_statement"',
    cursor = { 106, 0 },
    expected = { 108, 112 },
    result = { 105, 109 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "call"',
    cursor = { 115, 0 },
    expected = { 117, 120 },
    result = { 114, 117 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (argument_list)',
    cursor = { 123, 0 },
    expected = { 125, 129 },
    result = { 122, 126 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (list_comprehension)',
    cursor = { 132, 0 },
    expected = { 134, 138 },
    result = { 131, 135 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (set_comprehension)',
    cursor = { 141, 0 },
    expected = { 143, 147 },
    result = { 140, 144 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (dictionary_comprehension)',
    cursor = { 150, 0 },
    expected = { 152, 156 },
    result = { 149, 153 },
  },
  {
    path = PATH,
    mode = 'split',
    lang = LANG,
    desc = 'lang "%s", node "import_from_statement", preset default',
    cursor = { 159, 19 },
    expected = { 161, 166 },
    result = { 158, 163 },
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
