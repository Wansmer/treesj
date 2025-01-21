# RESULT OF JOIN (node "argument_list", preset default)
filled_dict = Dict("one" => 1, "two" => 2, "three" => 3)
# RESULT OF SPLIT (node "argument_list", preset default)
filled_dict = Dict(
  "one" => 1,
  "two" => 2,
  "three" => 3,
)

# RESULT OF JOIN (node "vector_expression", preset default)
other_arr = [4, 5, 6]
# RESULT OF SPLIT (node "vector_expression", preset default)
other_arr = [
  4,
  5,
  6,
]

# RESULT OF JOIN (node "matrix_expression", preset default)
other_arr = [1 2 3; 4 5 6]
# RESULT OF SPLIT (node "matrix_expression", preset default)
other_arr = [
  1 2 3
  4 5 6
]

# RESULT OF JOIN (node "tuple_expression", preset default)
tup = (1, 2, 3)
# RESULT OF SPLIT (node "tuple_expression", preset default)
tup = (
  1,
  2,
  3,
)

# RESULT OF JOIN (node "argument_list" and "function_definition", preset default)
function create_adder(x, b)
  adder(y) = x + y
  return adder
end

# RESULT OF SPLIT (node "argument_list" and "function_definition", preset default)
function create_adder(
  x,
  b,
)
  adder(y) = x + y
  return adder
end

# RESULT OF JOIN (node "comprehension_expression", preset default)
comp_arr = [i^2 for i in 1:5]
# RESULT OF SPLIT (node "comprehension_expression", preset default)
comp_arr = [
  i^2
  for i in 1:5
]

# RESULT OF JOIN (node "argument_list" in "call_expression", preset default)
result = sum([1, 2, 3])
# RESULT OF SPLIT (node "argument_list" in "call_expression", preset default)
result = sum(
  [1, 2, 3],
)

# RESULT OF JOIN (node "using_statement", preset default)
using Statistics, Lasso, ProjectRoot
# RESULT OF SPLIT (node "using_statement", preset default)
using Statistics,
  Lasso,
  ProjectRoot

# RESULT OF JOIN (node "selected_import" and "using_statement", preset default)
using Statistics: mean, median, std
# RESULT OF SPLIT (node "selected_import" and "using_statement", preset default)
using Statistics:
  mean,
  median,
  std

# RESULT OF JOIN (node "open_tuple" and "assignment", preset default)
t1, t2, t3 = (1, 2, 3)
# RESULT OF SPLIT (node "tuple_expression" and "assignment", preset default)
(
  t1,
  t2,
  t3,
) = (1, 2, 3)
