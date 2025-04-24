locals {
  # RESULT OF JOIN (node "tuple", preset default)
  tuple1 = ["hello", ["nested"], "world"]

  # RESULT OF SPLIT (node "tuple", preset default)
  tuple2 = [
    "hello",
    ["nested"],
    "world",
  ]

  # RESULT OF JOIN (node "object", preset default)
  object1 = {field = true, other_field = 42, yet_another_one = "thank you"}

  # RESULT OF SPLIT (node "object", preset default)
  object2 = {
    field = true
    other_field = 42
    yet_another_one = "thank you"
  }

  # RESULT OF JOIN (node "function_call", preset default)
  fn1 = hello(null, {foo = "bar!"}, 0.5)

  # RESULT OF SPLIT (node "function_call", preset default)
  fn2 = hello(
    null,
    {foo = "bar!"},
    0.5,
  )
}
