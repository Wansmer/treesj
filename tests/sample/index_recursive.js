// RESULT OF JOIN (node "block", preset with recursive = true)
const object = { one: 'one', two: 'two', three: function(x) { console.log(x); }, four: [ 1, 2, 3 ] };

// RESULT OF SPLIT (node "block", preset with recursive = true)
const object = {
  one: 'one',
  two: 'two',
  three: function(x) {
    console.log(x);
  },
  four: [
    1,
    2,
    3,
  ],
};

// RESULT OF JOIN (node "statement_block", preset with recursive = true)
function trycatch(test) { try { console.log('try'); } catch (e) { console.log(e); } finally { console.log('Done!'); } }

// RESULT OF SPLIT (node "statement_block", preset with recursive = true)
function trycatch(test) {
  try {
    console.log('try');
  } catch (e) {
    console.log(e);
  } finally {
    console.log('Done!');
  }
}

// RESULT OF JOIN (node "statement_block", preset preset with recursive = true)
if (b <= a) { 1 + 2; add(2, 1) + sum(2, 1); return (console.log(1), 1) >= 1; }

// RESULT OF SPLIT (node "statement_block", preset preset with recursive = true)
if (b <= a) {
  1 + 2;
  add(2, 1) + sum(2, 1);
  return (console.log(1), 1) >= 1;
}

// RESULT OF JOIN (node "array", preset preset with recursive = true)
cell.siblings = [ ...new Set([ ...cell.siblings, ...currentPlaceSiblings ]) ];

// RESULT OF SPLIT (node "array", preset preset with recursive = true)
cell.siblings = [
  ...new Set([ ...cell.siblings, ...currentPlaceSiblings ]),
];

// RESULT OF JOIN (field "body" in "arrow_function" with "parenthesized_expression", preset with recursive = true)
const myFunc = (param) => ({ one: 'one' });

// RESULT OF SPLIT (field "body" in "arrow_function" with "parenthesized_expression", preset with recursive = true)
const myFunc = (param) => {
  return {
    one: 'one',
  }
};

// RESULT OF JOIN (field "body" in "arrow_function" with "array", preset with recursive = true)
const myFunc = (param) => [ 1, 2, 3 ];

// RESULT OF SPLIT (field "body" in "arrow_function" with "array", preset with recursive = true)
const myFunc = (param) => {
  return [
    1,
    2,
    3,
  ]
};
