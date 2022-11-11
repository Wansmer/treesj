/* Test format */

// RESULT OF JOIN (node "object", preset default)
const obj = { one: 'one', two: [ 1, 2 ], three: { one: 'one', two: [ 1, 2 ] } };

// RESULT OF SPLIT (node "object", preset default)
const obj = {
  one: 'one',
  two: [ 1, 2 ],
  three: { one: 'one', two: [ 1, 2 ] },
};

// RESULT OF JOIN (node "object")
const arr = [ [ 1, 2, 3 ], [ 3, 2, 1 ], [ 1, 2, 3 ], [ 3, 2, 1 ] ];

// RESULT OF SPLIT (node "object")
const arr = [
  [
    1,
    2,
    3,
  ],
  [
    3,
    2,
    1,
  ],
  [
    1,
    2,
    3,
  ],
  [
    3,
    2,
    1,
  ],
];
