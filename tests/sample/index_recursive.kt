// RESULT OF JOIN (node "statements" with child with "shrink_node" option, preset default)
call_expression("arg1") { call1(1, 2); fun test(a: String, b: String) { val var1 = 1; val var2 = 2 } }
// RESULT OF SPLIT (node "statements" with child with "shrink_node" option, preset default)
call_expression("arg1") {
  call1(1, 2)
  fun test(a: String, b: String) {
    val var1 = 1
    val var2 = 2
  }
}
