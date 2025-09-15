// code examples from https://learnxinyminutes.com/docs/go/ and stackoverflow

// RESULT OF JOIN (block "literal_value" list, preset default)
a5 := [...]int{ 3, 1, 5, 10, 100 }

// RESULT OF SPLIT (block "literal_value" list, preset default)
a5 := [...]int{
	3,
	1,
	5,
	10,
	100,
}

// RESULT OF JOIN (block "literal_value" dict, preset default)
joe := person{ name: "Doe, John", age:  32 }

// RESULT OF SPLIT (block "literal_value" dict, preset default)
joe := person{
	name: "Doe, John",
	age:  32,
}

// RESULT OF JOIN (block "block", preset default)
func main() { fmt.Println("Hello world!"); beyondHello() }

// RESULT OF SPLIT (block "block", preset default)
func main() {
	fmt.Println("Hello world!");
	beyondHello()
}

// RESULT OF JOIN (block "parameter_list", preset default)
func learnMultiple(x, y int, z, some) (sum, prod int, x, y) {
	return x + y, x * y
}

// RESULT OF SPLIT (block "parameter_list", preset default)
func learnMultiple(
	x, y int,
	z,
	some,
) (sum, prod int, x, y) {
	return x + y, x * y
}

// RESULT OF JOIN (block "argument_list", preset default)
learnErrorHandling(1, 2, 3)

// RESULT OF SPLIT (block "argument_list", preset default)
learnErrorHandling(
	1,
	2,
	3,
)

// RESULT OF JOIN (block "import_spec_list to import_spec", preset default)
import "fmt"

// RESULT OF SPLIT (block "import_spec to import_spec_list", preset default)
import (
	"fmt"
)
