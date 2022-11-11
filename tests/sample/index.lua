--[[ test format ]]

-- RESULT OF JOIN (node "table_constructor" (list), preset default)
local list = { 'one', 'two', 'three', { 'four', 'five' } }

-- RESULT OF SPLIT (node "table_constructor" (list), preset default)
local list = {
  'one',
  'two',
  'three',
  { 'four', 'five' },
}

-- RESULT OF JOIN (node "table_constructor" (dict), preset default)
local dict = { one = 'one', two = 'two', three = 'three', four = { 'four', 'five' } }

-- RESULT OF SPLIT (node "table_constructor" (dict), preset default)
local dict = {
  one = 'one',
  two = 'two',
  three = 'three',
  four = { 'four', 'five' },
}

-- RESULT OF JOIN (node "table_constructor" (mixed type), preset default)
local mixed = { 'one', two = 'two', 'three', dict, four = { 'four', 'five' } }

-- RESULT OF SPLIT (node "table_constructor" (mixed type), preset default)
local mixed = {
  'one',
  two = 'two',
  'three',
  dict,
  four = { 'four', 'five' },
}

-- RESULT OF JOIN (node "arguments", preset default)
print('one', 'two')

-- RESULT OF SPLIT (node "arguments", preset default)
print(
  'one',
  'two'
)

-- RESULT OF JOIN (node "arguments", preset default)
local function test(a, b, c)
  print(a, b, c)
end

-- RESULT OF SPLIT (node "arguments", preset default)
local function test(
  a,
  b,
  c
)
  print(a, b, c)
end
