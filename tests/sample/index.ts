// RESULT OF JOIN (node "object_type", preset default)
let person: { name: string; age: number; [type: string]: string; };

// RESULT OF SPLIT (node "object_type", preset default)
let person: {
  name: string;
  age: number;
  [type: string]: string;
};

// RESULT OF JOIN (node "object_pattern", preset default)
let treesj: ({ a, b }: Cursor) => number

// RESULT OF SPLIT (node "object_pattern", preset default)
let treesj: ({
  a,
  b,
}: Cursor) => number

// RESULT OF JOIN (node "enum_body", preset default)
enum Answer { No = 0, Yes = 1 }

// RESULT OF SPLIT (node "enum_body", preset default)
enum Answer {
  No = 0,
  Yes = 1,
}

// RESULT OF JOIN (node "type_parameters", preset default)
class A<B, C> {}

// RESULT OF SPLIT (node "type_parameters", preset default)
class A<
  B,
  C,
> {}

// RESULT OF JOIN (node "type_arguments", preset default)
class D extends A<X, Y> {}

// RESULT OF SPLIT (node "type_arguments", preset default)
class D extends A<
  X,
  Y,
> {}

// RESULT OF JOIN (node "tuple_type", preset default)
type lines = [ string?, ...something ]

// RESULT OF SPLIT (node "tuple_type", preset default)
type lines = [
  string?,
  ...something,
]
