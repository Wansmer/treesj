<?php
/* Test format */

// RESULT OF JOIN (node "array_creation_expression", preset default)
$array = ['test' => 15, '12' => 'Hello', 'World' => '!'];

// RESULT OF SPLIT (node "array_creation_expression", preset default)
$array = [
    'test' => 15,
    '12' => 'Hello',
    'World' => '!',
];

// RESULT OF JOIN (node "array_creation_expression", preset default)
$array = [1, 2, 3, 4, 5, [6, 7, 8, 9]];

// RESULT OF SPLIT (node "array_creation_expression", preset default)
$array = [
    1,
    2,
    3,
    4,
    5,
    [6, 7, 8, 9],
];

// RESULT OF JOIN (node "formal_parameters", preset default)
function test($a, $b, $c) {
    print_r([$a, $b, $c]);
}

// RESULT OF SPLIT (node "formal_parameters", preset default)
function test(
  $a,
  $b,
  $c
) {
    print_r([$a, $b, $c]);
}

// RESULT OF JOIN (node "arguments", preset default)
test(1, 2, 3);

// RESULT OF SPLIT (node "arguments", preset default)
test(
    1,
    2,
    3
);

// RESULT OF JOIN (node "compound_statement", preset default)
function state($a, $b, $c) { print_r($a); function sum($n1, $n2) { return $n1 + $n2; } $res = sum($b, $c); return $res; }

// RESULT OF SPLIT (node "statement_block", preset default)
function state($a, $b, $c) {
    print_r($a);
    function sum($n1, $n2) { return $n1 + $n2; }
    $res = sum($b, $c);
    return $res;
}

// RESULT OF JOIN (node "expression_statement" with target "array_creation_expression", preset default)
$array = ['test' => 15, '12' => 'Hello', 'World' => '!'];

// RESULT OF SPLIT (node "lexical_declaration" with target "object", preset default)
$array = [
    'test' => 15,
    '12' => 'Hello',
    'World' => '!',
];
