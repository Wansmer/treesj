-- RESULT OF JOIN (node "block" in function_declaration), preset default
function foo () local test = { one = 'one', two = 'two' } return test end

-- RESULT OF SPLIT (node "block" in function_declaration), preset default
function foo ()
  local test = { one = 'one', two = 'two' }
  return test
end

-- RESULT OF JOIN (node "block" in if_statement), preset default
if true then return false end

-- RESULT OF SPLIT (node "block" in if_statement), preset default
if true then
  return false
end
