// RESULT OF JOIN (node "parameter_list", preset default)
void foo(int x, int y, int z);
// RESULT OF SPLIT (node "parameter_list", preset default)
void foo(
  int x,
  int y,
  int z
);

// RESULT OF JOIN (node "argument_list", preset default)
foo(1, 2, 3);
// RESULT OF SPLIT (node "argument_list", preset default)
foo(
  1,
  2,
  3
);

// RESULT OF JOIN (node "initializer_list", preset default)
int arr[] = { 1, 2, 3, 4, 5 };
// RESULT OF SPLIT (node "initializer_list", preset default)
int arr[] = {
  1,
  2,
  3,
  4,
  5,
};

// RESULT OF JOIN (node "compound_statement")
void bar() { return; }
// RESULT OF SPLIT (node "compound_statement")
void bar() {
  return;
}

// RESULT OF JOIN (node "enumerator_list", preset default)
enum Color { Red, Green, Blue };
// RESULT OF SPLIT (node "enumerator_list", preset default)
enum Color {
  Red,
  Green,
  Blue,
};
