// Based on https://github.com/Wansmer/treesj/issues/55#issuecomment-1407386248

// RESULT OF JOIN (node 'collection_literal', preset default)
val collection_literal = [1, 2, 3]
// RESULT OF SPLIT (node 'collection_literal', preset default)
val collection_literal = [
  1,
  2,
  3
]

// RESULT OF JOIN (node 'value_arguments', preset default)
val list = listOf(1, 2, 3)
// RESULT OF SPLIT (node 'value_arguments', preset default)
val list = listOf(
  1,
  2,
  3
)

// RESULT OF JOIN (node 'statements', preset default)
call_expression("arg1") { call1(1, 2); call2(1, 2) }
// RESULT OF SPLIT (node 'statements', preset default)
call_expression("arg1") {
  call1(1, 2)
  call2(1, 2)
}

// RESULT OF JOIN (node "function_declaration" (parameters), preset default)
fun test(a: String, b: String) {
  val var1 = 1
  val var2 = 2
}

// RESULT OF SPLIT (node "function_declaration" (parameters), preset default)
fun test(
  a: String,
  b: String
) {
  val var1 = 1
  val var2 = 2
}
