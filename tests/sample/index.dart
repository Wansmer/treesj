// RESULT OF JOIN (node "list_literal", preset default)
const list = [ "1", "2", "3" ];
// RESULT OF SPLIT (node "list_literal", preset default)
const list = [
  "1",
  "2",
  "3",
];

// RESULT OF JOIN (node "list_literal" with const, preset default)
var list2 = const [ "a", "b" ];
// RESULT OF SPLIT (node "list_literal" with const, preset default)
var list2 = const [
  "a",
  "b",
];

// RESULT OF JOIN (node "set_or_map_literal", preset default)
const map = { "key": "value", "key2": "value2" };
// RESULT OF SPLIT (node "set_or_map_literal", preset default)
const map = {
  "key": "value",
  "key2": "value2",
};

// RESULT OF JOIN (node "block", preset default)
func() { print(map["key"]); print(list[0]); }
// RESULT OF SPLIT (node "block", preset default)
func() {
  print(map["key"]);
  print(list[0]);
}

// RESULT OF JOIN (node "arguments", preset default)
print(map["key"], list[0]);
// RESULT OF SPLIT (node "arguments", preset default)
print(
  map["key"],
  list[0]
);

// RESULT OF JOIN (node "formal_parameter_list", preset default)
func2(one, two) { print(one, two); }
// RESULT OF JOIN (node "formal_parameter_list", preset default)
func2(
  one,
  two
) { print(one, two); }
