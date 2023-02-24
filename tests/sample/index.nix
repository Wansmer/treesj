{ foo, ... }:
{
  bar = [
    # RESULT OF JOIN (nix "list", preset default)
    [ 1 2 3 4 "a" "b" ]

    # RESULT OF SPLIT (nix "list", preset default)
    [
      1
      2
      3
      4
      "a"
      "b"
    ]

    # RESULT OF JOIN (nix "attrset_expression", preset default)
    { a = 1; b = 2; c = "c"; }

    # RESULT OF SPLIT (nix "attrset_expression", preset default)
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
