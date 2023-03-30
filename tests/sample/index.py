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
# RESULT OF SPLIT (node "set", preset default)
some_set = {
    1,
    1,
    2,
    2,
    3,
    4,
}

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
# RESULT OF SPLIT (node "set_comprehension", preset default)
{
    x
    for x in 'abcddeef'
    if x not in 'abc'
}

# RESULT OF JOIN (node "dictionary_comprehension")
{k: v for k, v in items}

# RESULT OF SPLIT (node "dictionary_comprehension")
{
    k: v
    for k, v in items
}

# RESULT OF JOIN (node "decorator")
@app.delete("/{id}", status_code=204)

# RESULT OF SPLIT (node "decorator")
@app.delete(
    "/{id}",
    status_code=204
)

# RESULT OF JOIN (node "raise_statement")
raise HTTPException(status_code=404, detail=f"ID {id} does not exists")

# RESULT OF SPLIT (node "raise_statement")
raise HTTPException(
    status_code=404,
    detail=f"ID {id} does not exists"
)

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

# RESULT OF JOIN (node "assignment" (set_comprehension))
sc = {elem for elem in range(1, 4)}

# RESULT OF SPLIT (node "assignment" (set_comprehension))
sc = {
    elem
    for elem in range(1, 4)
}

# RESULT OF JOIN (node "assignment" (dictionary_comprehension))
dc = {k: v for k, v in items}

# RESULT OF SPLIT (node "assignment" (dictionary_comprehension))
dc = {
    k: v
    for k, v in items
}

# RESULT OF JOIN (node "import_from_statement", preset default)
from re import search, match, sub

# RESULT OF SPLIT (node "import_from_statement", preset default)
from re import (
    search,
    match,
    sub,
)

# RESULT OF JOIN (node "import_from_statement", preset default)
from re import search

# RESULT OF SPLIT (node "import_from_statement", preset default)
from re import (
    search,
)

 # RESULT OF JOIN (node "tuple_pattern to pattern_list", preset default)
t1, t2, t3 = (1, 2, 3,)

# RESULT OF SPLIT (node "tuple_pattern", preset default)
(
    t1,
    t2,
    t3,
) = (1, 2, 3,)

# RESULT OF JOIN (node "pattern_list", preset default)
d1, d2, d3 = { "one": 1, "two": 2, "three": 3 }.values()

# RESULT OF SPLIT (node "pattern_list", preset default)
(
    d1,
    d2,
    d3,
) = { "one": 1, "two": 2, "three": 3 }.values()

# code from https://learnxinyminutes.com/docs/python/
