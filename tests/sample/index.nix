{ foo, ... }:
{
  bar = [
    # RESULT OF JOIN (nix "list_expression", preset default)
    [ 1 2 3 4 "a" "b" ]

    # RESULT OF SPLIT (nix "list_expression", preset default)
    [
      1
      2
      3
      4
      "a"
      "b"
    ]

    # RESULT OF JOIN (nix "binding_set", preset default)
    { a = 1; b = 2; c = "c"; }

    # RESULT OF SPLIT (nix "binding_set", preset default)
    {
      a = 1;
      b = 2;
      c = "c";
    }

  ];

  # RESULT OF JOIN (nix "formals", preset default)
  func1 =
    { foo, bar, blub, ... }:
    { };

  # RESULT OF SPLIT (nix "formals", preset default)
  func2 =
    { foo
    , bar
    , blub
    , ...
    }:
    { };
}
