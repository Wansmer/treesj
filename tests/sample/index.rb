# RESULT OF JOIN (node "array", preset default)
array = [ 1, 2, 3, [ 1, 2 ], :bar => 1 ]

# RESULT OF SPLIT (node "array", preset default)
array = [
  1,
  2,
  3,
  [ 1, 2 ],
  :bar => 1,
]

# RESULT OF JOIN (node "hash", preset default)
hash = { :foo => 'foo', :bar => 'bar', [ 1, 2 ] => 2 }

# RESULT OF SPLIT (node "hash", preset default)
hash = {
  :foo => 'foo',
  :bar => 'bar',
  [ 1, 2 ] => 2,
}
