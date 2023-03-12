local tu = require('tests.utils')

local PATH = './tests/sample/index.py'
local LANG = 'python'

local data_for_join = {
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "dictionary", preset default',
    cursor = { 5, 8 },
    expected = { 1, 2 },
    result = { 3, 4 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list", preset default',
    cursor = { 15, 5 },
    expected = { 10, 11 },
    result = { 12, 13 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "set", preset default',
    cursor = { 25, 3 },
    expected = { 19, 20 },
    result = { 21, 22 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "tuple", preset default',
    cursor = { 36, 5 },
    expected = { 31, 32 },
    result = { 33, 34 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "argument_list", preset default',
    cursor = { 44, 18 },
    expected = { 40, 41 },
    result = { 42, 43 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parameters", preset default',
    cursor = { 57, 4 },
    expected = { 48, 49 },
    result = { 54, 55 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "parenthesized_expression", preset default',
    cursor = { 67, 25 },
    expected = { 63, 64 },
    result = { 65, 66 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "list_comprehension", preset default',
    cursor = { 75, 5 },
    expected = { 70, 71 },
    result = { 72, 73 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "set_comprehension", preset default',
    cursor = { 83, 3 },
    expected = { 78, 79 },
    result = { 80, 81 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "dictionary_comprehension"',
    cursor = { 91, 0 },
    expected = { 87, 88 },
    result = { 90, 91 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "decorator"',
    cursor = { 100, 0 },
    expected = { 96, 97 },
    result = { 99, 100 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "raise_statement"',
    cursor = { 109, 0 },
    expected = { 105, 106 },
    result = { 108, 109 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "call"',
    cursor = { 118, 0 },
    expected = { 114, 115 },
    result = { 117, 118 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (argument_list)',
    cursor = { 126, 0 },
    expected = { 122, 123 },
    result = { 125, 126 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (list_comprehension)',
    cursor = { 135, 0 },
    expected = { 131, 132 },
    result = { 134, 135 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (set_comprehension)',
    cursor = { 144, 0 },
    expected = { 140, 141 },
    result = { 143, 144 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "assignment" (dictionary_comprehension)',
    cursor = { 153, 0 },
    expected = { 149, 150 },
    result = { 152, 153 },
  },
  {
    path = PATH,
    mode = 'join',
    lang = LANG,
    desc = 'lang "%s", node "import_from_statement", preset default',
    cursor = { 165, 5 },
    expected = { 158, 159 },
    result = { 161, 162 },
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
