// RESULT OF JOIN (node "parameter_list", preset default)
fn foo(x: i32, y: i32, z: i32) void {}
// RESULT OF SPLIT (node "parameter_list", preset default)
fn foo(
    x: i32,
    y: i32,
    z: i32,
) void {}

// RESULT OF JOIN (node "argument_list", preset default)
var bar = foo(1, 2, 3);
// RESULT OF SPLIT (node "argument_list", preset default)
var bar = foo(
    1,
    2,
    3,
);

// RESULT OF JOIN (node "initializer_list", preset default)
var arr: [5]u32 = [5]u32{ 1, 2, 3, 4, 5 };
// RESULT OF SPLIT (node "initializer_list", preset default)
var arr: [5]u32 = [5]u32{
    1,
    2,
    3,
    4,
    5,
};

// RESULT OF JOIN (node "enumerator_list", preset default)
const Direction = enum { north, south, east, west };
// RESULT OF SPLIT (node "enumerator_list", preset default)
const Direction = enum {
    north,
    south,
    east,
    west,
};

// RESULT OF JOIN (node "struct_declaration", preset default)
const Point = struct { x: i32, y: i32 = 0, z: i32 };
// RESULT OF SPLIT (node "struct_declaration", preset default)
const Point = struct {
    x: i32,
    y: i32 = 0,
    z: i32,
};
