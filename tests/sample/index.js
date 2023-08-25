/* Test format */

// RESULT OF JOIN (node "object", preset default)
const obj = { one: 'one', two: [ 1, 2 ], three: { one: 'one', two: [ 1, 2 ] } };

// RESULT OF SPLIT (node "object", preset default)
const obj = {
  one: 'one',
  two: [ 1, 2 ],
  three: { one: 'one', two: [ 1, 2 ] },
};

// RESULT OF JOIN (node "array", preset default)
const arr = [ 0, 1, 2, 3, [ 1, 2, 3, [ 0, 1, 2 ] ] ];

// RESULT OF SPLIT (node "array", preset default)
const arr = [
  0,
  1,
  2,
  3,
  [ 1, 2, 3, [ 0, 1, 2 ] ],
];

// RESULT OF JOIN (node "formal_parameters", preset default)
function test(a, b, c) {
  console.log(a, b, c);
}

// RESULT OF SPLIT (node "formal_parameters", preset default)
function test(
  a,
  b,
  c
) {
  console.log(a, b, c);
}

// RESULT OF JOIN (node "arguments", preset default)
test(1, 2, 3)

// RESULT OF SPLIT (node "arguments", preset default)
test(
  1,
  2,
  3
)

// RESULT OF JOIN (node "statement_block", preset default)
function state(a, b, c) { console.log(a); function sum(n1, n2) { return n1 + n2; } const res = sum(b, c); return res; }

// RESULT OF SPLIT (node "statement_block", preset default)
function state(a, b, c) {
  console.log(a);
  function sum(n1, n2) { return n1 + n2; }
  const res = sum(b, c);
  return res;
}

// RESULT OF JOIN (node "lexical_declaration" with target "object", preset default)
const lex = { one: 'one', two: function(x) { console.log(x); } }

// RESULT OF SPLIT (node "lexical_declaration" with target "object", preset default)
const lex = {
  one: 'one',
  two: function(x) { console.log(x); },
}

// RESULT OF JOIN (node "variable_declaration" with target "object", preset default)
var lex = { one: 'one', two: function(x) { console.log(x); } }

// RESULT OF SPLIT (node "variable_declaration" with target "object", preset default)
var lex = {
  one: 'one',
  two: function(x) { console.log(x); },
}

// RESULT OF JOIN (node "assignment_expression" with target "array", preset default)
lex = [ 1, 2, 3 ];

// RESULT OF SPLIT (node "assignment_expression" with target "array", preset default)
lex = [
  1,
  2,
  3,
];

// RESULT OF JOIN (node "formal_parameters", preset default)
import { module as m, sub, reducer } from 'module';

// RESULT OF JOIN (node "formal_parameters", preset default)
import {
  module as m,
  sub,
  reducer,
} from 'module';

// RESULT OF JOIN (node "export_clause", preset default)
export { module as m, sub, reducer };

// RESULT OF JOIN (node "export_clause", preset default)
export {
  module as m,
  sub,
  reducer,
};

// RESULT OF JOIN (node "statement_block", preset default)
if (b <= a) { 1 + 2; add(2, 1) + sum(2, 1); return (console.log(1), 1) >= 1; }

// RESULT OF SPLIT (node "statement_block", preset default)
if (b <= a) {
  1 + 2;
  add(2, 1) + sum(2, 1);
  return (console.log(1), 1) >= 1;
}

// RESULT OF JOIN (field "body" in "arrow_function" with "call_expression", preset default)
const myFunc = (param) => console.log([ 1, 2, 3 ]);

// RESULT OF SPLIT (field "body" in "arrow_function" with "call_expression", preset default)
const myFunc = (param) => {
  return console.log([ 1, 2, 3 ])
};

// RESULT OF JOIN (field "body" in "arrow_function" with "identifier", preset default)
const myFunc = (param) => param;

// RESULT OF SPLIT (field "body" in "arrow_function" with "identifier", preset default)
const myFunc = (param) => {
  return param
};

// RESULT OF JOIN (field "body" in "arrow_function" with "parenthesized_expression", preset default)
const myFunc = (param) => ({ one: 'one' });

// RESULT OF SPLIT (field "body" in "arrow_function" with "parenthesized_expression", preset default)
const myFunc = (param) => {
  return { one: 'one' }
};

// RESULT OF JOIN (field "body" in "arrow_function" with "array", preset default)
const myFunc = (param) => [ 1, 2, 3 ];

// RESULT OF SPLIT (field "body" in "arrow_function" with "array", preset default)
const myFunc = (param) => {
  return [ 1, 2, 3 ]
};

// RESULT OF JOIN (field "body" in "arrow_function" with "parenthesized_expression" with 'sequence_expression', preset default)
const myFunc = (param) => (1, 2);

// RESULT OF SPLIT (field "body" in "arrow_function" with "parenthesized_expression" with 'sequence_expression', preset default)
const myFunc = (param) => {
  return (1, 2)
};

// RESULT OF JOIN (field "body" in "arrow_function" with "statement_block" with >1 named child, preset default)
const myFunc = (param) => { doSomething(); andThisDoTo(); };

// RESULT OF SPLIT (field "body" in "arrow_function" with "parenthesized_expression" with 'sequence_expression', preset default)
const myFunc = (param) => {
  doSomething();
  andThisDoTo();
};

// RESULT OF JOIN (field "body" in "arrow_function" with "statement_block" without return, preset default)
export async function pretendDelay() {
  const delay = Math.floor(Math.random() * 1000); // Between 0 and 1 seconds
  return new Promise((resolve) => setTimeout(resolve, delay));
}

// RESULT OF SPLIT (field "body" in "arrow_function" with "statement_block" without return, preset default)
export async function pretendDelay() {
  const delay = Math.floor(Math.random() * 1000); // Between 0 and 1 seconds
  return new Promise((resolve) => {
    setTimeout(resolve, delay);
  });
}
