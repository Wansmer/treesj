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

# RESULT OF JOIN (node "map_content", preset default)
map = %{:foo => "foo", :bar => "bar", [1, 2] => 2}

# RESULT OF SPLIT (node "map_content", preset default)
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

# RESULT OF JOIN (node "keywords", preset default)
map = %{foo: "bar", baz: [], abc: %{}, def: {}, hij: a(1) + 1}

# RESULT OF SPLIT (node "keywords", preset default)
map = %{
  foo: "bar",
  baz: [],
  abc: %{},
  def: {},
  hij: a(1) + 1
}

# RESULT OF JOIN (node "map" with "keywords" and "map_content", preset default)
map = %{"key" => "value", foo: "bar", baz: "bar"}

# RESULT OF SPLIT (node "map" with "keywords" and "map_content", preset default)
map = %{
  "key" => "value",
  foo: "bar",
  baz: "bar"
}

# RESULT OF JOIN (node "list" with "keywords" and "map", preset default)
list = [1, 2, %{"a" => "b", key: "value", foo: "bar"}, abc: "123", def: "456"]

# RESULT OF SPLIT (node "list" with "keywords" and "map", preset default)
list = [
  1,
  2,
  %{"a" => "b", key: "value", foo: "bar"},
  abc: "123", def: "456"
]

# RESULT OF JOIN (node "map" nested "keywords" and "maps"", preset default)
map = %{"map" => %{"key" => "value"}, foo: "bar", map: %{"key" => "value"}, baz: "bar"}

# RESULT OF SPLIT (node "map" nested "keywords" and "maps", preset default)
map = %{
  "map" => %{"key" => "value"},
  foo: "bar",
  map: %{"key" => "value"},
  baz: "bar"
}
