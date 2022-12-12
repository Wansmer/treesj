# RESULT OF JOIN (node "dictionary", preset default)
filled_dict = {"one": 1, "two": 2, "three": 3}
# RESULT OF SPLIT (node "dictionary", preset default)
filled_dict = {
    "one": 1,
    "two": 2,
    "three": 3,
}

# RESULT OF JOIN (node "list", preset default)
other_li = [4, 5, 6]
# RESULT OF SPLIT (node "list", preset default)
other_li = [
    4,
    5,
    6,
]

# RESULT OF JOIN (node "set", preset default)
some_set = {1, 1, 2, 2, 3, 4}
# RESULT OF JOIN (node "set", preset default)
some_set = {
    1,
    1,
    2,
    2,
    3,
    4,
}

# RESULT OF JOIN (node "tuple", preset default)
tup = (1, 2, 3)
# RESULT OF JOIN (node "tuple", preset default)
tup = (
    1,
    2,
    3,
)

# RESULT OF JOIN (node "argument_list", preset default)
print("Hello, World", end="!")
# RESULT OF SPLIT (node "argument_list", preset default)
print(
    "Hello, World",
    end="!"
)

# RESULT OF JOIN (node "parameters", preset default)
def create_adder(x, b):
    def adder(y):
        return x + y
    return adder

# RESULT OF SPLIT (node "parameters", preset default)
def create_adder(
    x,
    b
):
    def adder(y):
        return x + y
    return adder

# RESULT OF JOIN (node "parenthesized_expression", preset default)
(lambda x, y: x ** 2 + y ** 2)(2, 1)
# RESULT OF SPLIT (node "parenthesized_expression", preset default)
(
    lambda x, y: x ** 2 + y ** 2
)(2, 1)

# RESULT OF JOIN (node "list_comprehension", preset default)
[add_10(i) for i in [1, 2, 3]]
# RESULT OF SPLIT (node "list_comprehension", preset default)
[
    add_10(i)
    for i in [1, 2, 3]
]

# RESULT OF JOIN (node "set_comprehension", preset default)
{x for x in 'abcddeef' if x not in 'abc'}
# RESULT OF JOIN (node "set_comprehension", preset default)
{
    x
    for x in 'abcddeef'
    if x not in 'abc'
}
