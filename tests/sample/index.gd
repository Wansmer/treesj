# RESULT OF JOIN (node "array", preset default)
var arr = [1, 2, 3]
# RESULT OF SPLIT (node "array", preset default)
var arr = [
  1,
  2,
  3,
]

# RESULT OF JOIN (node "dictionary", preset default)
var dct = {"one": 1, "two": 2}
# RESULT OF SPLIT (node "dictionary", preset default)
var dct = {
  "one": 1,
  "two": 2,
}

# RESULT OF JOIN (node "enumerator_list" and "enum_definition", preset default)
enum Mode {IDLE, RUN, JUMP}
# RESULT OF SPLIT (node "enumerator_list" and "enum_definition", preset default)
enum Mode {
  IDLE,
  RUN,
  JUMP,
}

# RESULT OF JOIN (node "parameters" and "function_definition", preset default)
func greet(name, times):
  print(name, times)

# RESULT OF SPLIT (node "parameters" and "function_definition", preset default)
func greet(
  name,
  times
):
  print(name, times)

# RESULT OF JOIN (node "arguments" and "call", preset default)
func use():
  emit_signal("done", a, b)

# RESULT OF SPLIT (node "arguments" and "call", preset default)
func use():
  emit_signal(
    "done",
    a,
    b
  )

# RESULT OF JOIN (node "assignment" (array), preset default)
func reassign():
  values = [1, 2, 3]

# RESULT OF SPLIT (node "assignment" (array), preset default)
func reassign():
  values = [
    1,
    2,
    3,
  ]
