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

-- RESULT OF JOIN (node "block" in if_statement), preset default
if true then print(123) local a = b print(a) end

-- RESULT OF SPLIT (node "block" in if_statement), preset default
if true then
  print(123)
  local a = b
  print(a)
end

-- RESULT OF JOIN (node "block" in function_declaration), preset default
function foo () local test = { one = 'one', two = 'two' } return test end

-- RESULT OF SPLIT (node "block" in function_declaration), preset default
function foo ()
  local test = { one = 'one', two = 'two' }
  return test
end

-- RESULT OF JOIN (node "block" in function_declaration contains nested function)
local function foo() local test = function() print(123) local function ins() return 'bar' end return 'foo' end return test() end

-- RESULT OF JOIN (node "block" in function_declaration contains nested functions)
local function foo()
  local test = function()
    print(123)
    local function ins()
      return 'bar'
    end
    return 'foo'
  end
  return test()
end
