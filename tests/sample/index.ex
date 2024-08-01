# RESULT OF JOIN (node "list", preset default)
list = [1, 2, 3, [1, 2], [3, 4]]

# RESULT OF SPLIT (node "list", preset default)
list = [
  1,
  2,
  3,
  [1, 2],
  [3, 4]
]

# RESULT OF JOIN (node "map", preset default)
map = %{:foo => "foo", :bar => "bar", [1, 2] => 2}

# RESULT OF SPLIT (node "map", preset default)
map = %{
  :foo => "foo",
  :bar => "bar",
  [1, 2] => 2
}

# RESULT OF JOIN (node "arguments", preset default)
def test(a, b), do: :ok

# RESULT OF SPLIT (node "arguments", preset default)
def test(
  a,
  b
), do: :ok

# RESULT OF JOIN (node "arguments", preset default)
test(a, b)

# RESULT OF SPLIT (node "arguments", preset default)
test(
  a,
  b
)

# RESULT OF JOIN (node "tuple", preset default)
{a, b, 123, {c, d}}

# RESULT OF SPLIT (node "tuple", preset default)
{
  a,
  b,
  123,
  {c, d}
}
