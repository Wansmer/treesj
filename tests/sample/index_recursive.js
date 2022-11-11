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
