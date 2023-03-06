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

# Intentionally blank lines to retain the line-number references from the python test.
#
#
#
#
#
#
#
#
#
#

# RESULT OF JOIN (node "tuple", preset default)
tup = (1, 2, 3,)
# RESULT OF SPLIT (node "tuple", preset default)
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
(lambda x, y: x * x + y * y)(2, 1)
# RESULT OF SPLIT (node "parenthesized_expression", preset default)
(
    lambda x, y: x * x + y * y
)(2, 1)

# RESULT OF JOIN (node "list_comprehension", preset default)
[add_10(i) for i in [1, 2, 3]]
# RESULT OF SPLIT (node "list_comprehension", preset default)
[
    add_10(i)
    for i in [1, 2, 3]
]

# Intentionally blank lines to retain the line-number references from the python test.
#
#
#
#
#
#
#

# RESULT OF JOIN (node "dictionary_comprehension")
{k: v for k, v in items}

# RESULT OF SPLIT (node "dictionary_comprehension")
{
    k: v
    for k, v in items
}

# Intentionally blank lines to retain the line-number references from the python test.
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# RESULT OF JOIN (node "call")
session.delete(existing_id)

# RESULT OF SPLIT (node "call")
session.delete(
    existing_id
)

# RESULT OF JOIN (node "assignment" (argument_list))
existing_id = session.get(Table, id)

# RESULT OF SPLIT (node "assignment" (argument_list))
existing_id = session.get(
    Table,
    id
)

# RESULT OF JOIN (node "assignment" (list_comprehension))
lc = [item for item in range(1, 4)]

# RESULT OF SPLIT (node "assignment" (list_comprehension))
lc = [
    item
    for item in range(1, 4)
]

# Intentionally blank lines to retain the line-number references from the python test.
#
#
#
#
#
#
#
#
# RESULT OF JOIN (node "assignment" (dictionary_comprehension))
dc = {k: v for k, v in items}

# RESULT OF SPLIT (node "assignment" (dictionary_comprehension))
dc = {
    k: v
    for k, v in items
}


# code from https://learnxinyminutes.com/docs/python/
