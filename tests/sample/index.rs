// Code examples from:
// - https://github.com/Wansmer/treesj/issues/40
// - https://learnxinyminutes.com/docs/rust/

// RESULT OF JOIN (node "field_declaration_list", preset default)
struct SomeStruct { x: i32, y: i32 }
// RESULT OF SPLIT (node "field_declaration_list", preset default)
struct SomeStruct {
    x: i32,
    y: i32,
}

// RESULT OF JOIN (node "field_initializer_list", preset default)
let x = SomeStruct { x: 123, y: 234 };
// RESULT OF SPLIT (node "field_initializer_list", preset default)
let x = SomeStruct {
    x: 123,
    y: 234,
};

// RESULT OF JOIN (node "parameters", preset default)
fn f(x: i32, y: i32) -> i32 {}
// RESULT OF SPLIT (node "parameters", preset default)
fn f(
    x: i32,
    y: i32,
) -> i32 {}

// RESULT OF JOIN (node "arguments", preset default)
f(123, 234);
// RESULT OF SPLIT (node "arguments", preset default)
f(
    123,
    234,
);

// RESULT OF JOIN (node "array_expression", preset default)
let v = vec![ 1, 2, 3 ];
// RESULT OF SPLIT (node "array_expression", preset default)
let v = vec![
    1,
    2,
    3,
];

// RESULT OF JOIN (node "tuple_expression", preset default)
let x: (i32, &str, f64) = (1, "hello", 3.4);
// RESULT OF SPLIT (node "tuple_expression", preset default)
let x: (i32, &str, f64) = (
    1,
    "hello",
    3.4,
);

// RESULT OF JOIN (node "tuple_type", preset default)
let x: (i32, &str, f64) = (1, "hello", 3.4);
// RESULT OF SPLIT (node "tuple_type", preset default)
let x: (
    i32,
    &str,
    f64,
) = (1, "hello", 3.4);

// RESULT OF JOIN (node "block", preset default)
fn add2(x: i32, y: i32) -> i32 { let z = 3; x + y + z }
// RESULT OF SPLIT (node "block", preset default)
fn add2(x: i32, y: i32) -> i32 {
    let z = 3;
    x + y + z
}

// RESULT OF JOIN (node "enum_variant_list", preset default)
enum Direction { Left, Right, Up, Down }
// RESULT OF SPLIT (node "enum_variant_list", preset default)
enum Direction {
    Left,
    Right,
    Up,
    Down,
}

// RESULT OF JOIN (node "declaration_list", preset default)
trait Frobnicate<T> { fn frobnicate(self) -> Option<T>; }
// RESULT OF SPLIT (node "declaration_list", preset default)
trait Frobnicate<T> {
    fn frobnicate(self) -> Option<T>;
}

match bar {
    // RESULT OF JOIN (node "struct_pattern", preset default)
    FooBar { x: 0, y: OptionalI32::AnI32(0) } =>
        println!("The numbers are zero!"),
    FooBar { x: n, y: OptionalI32::AnI32(m) } if n == m =>
        println!("The numbers are the same"),
}
match bar {
    // RESULT OF SPLIT (node "struct_pattern", preset default)
    FooBar {
        x: 0,
        y: OptionalI32::AnI32(0),
    } =>
        println!("The numbers are zero!"),
    FooBar { x: n, y: OptionalI32::AnI32(m) } if n == m =>
        println!("The numbers are the same"),
}

// RESULT OF JOIN (node "use_list", preset default)
use path::to::{ This, Is, Use, List };
// RESULT OF SPLIT (node "use_list", preset default)
use path::to::{
    This,
    Is,
    Use,
    List,
};

match x {
    // RESULT OF JOIN (field "value" in match_arm, preset default)
    _ => 12
}

match x {
    // RESULT OF SPLIT (field "value" in match_arm, preset default)
    _ => {
        12
    }
}

match x {
    // RESULT OF JOIN (node "block" with 2 named children in match_arm, preset default)
    _ => { 12; 13 }
}

match x {
    // RESULT OF SPLIT (node "block" with 2 named children in match_arm, preset default)
    _ => {
        12;
        13
    }
}

// RESULT OF JOIN (field "body" inside closure_expression, preset default)
let a = b.map(|x| x * x);

// RESULT OF SPLIT (field "body" inside closure_expression, preset default)
let a = b.map(|x| {
    x * x
});

// RESULT OF JOIN (node "block" inside closure_expression with 2 named children, preset default)
let a = b.map(|x| { doSomething(); x * x } );

// RESULT OF SPLIT (node "block" inside closure_expression with 2 named children, preset default)
let a = b.map(|x| {
    doSomething();
    x * x
} );
