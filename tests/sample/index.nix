{ foo, ... }:
{
  bar = [
    # RESULT OF JOIN (node "list_expression", preset default)
    [ 1 2 3 4 "a" "b" ]

    # RESULT OF SPLIT (node "list_expression", preset default)
    [
      1
      2
      3
      4
      "a"
      "b"
    ]

    # RESULT OF JOIN (node "binding_set", preset default)
    { a = 1; b = 2; c = "c"; }

    # RESULT OF SPLIT (node "binding_set", preset default)
    {
      a = 1;
      b = 2;
      c = "c";
    }

  ];

  # RESULT OF JOIN (node "formals", preset default)
  func1 =
    { foo, bar, blub, ... }:
    { };

  # RESULT OF SPLIT (node "formals", preset default)
  func2 =
    { foo
    , bar
    , blub
    , ...
    }:
    { };

  # RESULT OF JOIN (node "let_expression", preset default)
  bla =
    let x=1; y=2; in x + y;

  # RESULT OF SPLIT (node "let_expression", preset default)
  bla =
    let
      x=1;
      y=2;
    in
    x + y;

  # RESULT OF JOIN (node "let_expression" with "attrset_expression", preset default)
  bla =
    let x=1; y=2; in { a = 1; b = 2; c = "c"; };

  # RESULT OF SPLIT (node "let_expression" with "attrset_expression", preset default)
  bla =
    let
      x=1;
      y=2;
    in
    {
      a = 1;
      b = 2;
      c = "c";
    };
}
