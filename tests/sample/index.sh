#!/bin/bash

# RESULT OF JOIN (node "array", preset default)
plugins=(z git macos)
# RESULT OF SPLIT (node "array", preset default)
plugins=(
  z
  git
  macos
)

# RESULT OF JOIN (node "compound_statement", preset default)
bar() { echo "one"; echo "two"; }
# RESULT OF SPLIT (node "compound_statement", preset default)
bar() {
  echo "one"
  echo "two"
}

# RESULT OF JOIN (node "do_group", preset default)
for x in "1 2 3 4 5"; do echo $x; done
# RESULT OF SPLIT (node "do_group", preset default)
for x in "1 2 3 4 5"; do
  echo $x
done

# RESULT OF JOIN (node "if_statement", preset default)
if [[ "123" == "123" ]]; then echo "one"; fi
# RESULT OF JOIN (node "if_statement", preset default)
if [[ "123" == "123" ]]; then
  echo "one"
fi
