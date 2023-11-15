# Code examples from here: https://learnxinyminutes.com/docs/perl/

# RESULT OF JOIN (node "list_expression", preset default)
my @mixed = ("camel", 42, 1.23);
# RESULT OF SPLIT (node "list_expression", preset default)
my @mixed = (
  "camel",
  42,
  1.23
);

# RESULT OF JOIN (node "list_expression" with "=>" syntax, preset default)
my %fruit_color = (apple => "red", banana => "yellow");
# RESULT OF SPLIT (node "list_expression" with "=>" syntax, preset default)
my %fruit_color = (
  apple => "red",
  banana => "yellow"
);

# RESULT OF JOIN (node "list_expression", preset default)
my $fruits = ["apple", "banana"];
# RESULT OF SPLIT (node "list_expression", preset default)
my $fruits = [
  "apple",
  "banana"
];

# RESULT OF JOIN (node "list_expression", preset default)
my $colors = {apple => "red", banana => "yellow"};
# RESULT OF SPLIT (node "list_expression", preset default)
my $colors = {
  apple => "red",
  banana => "yellow"
};

# RESULT OF JOIN (node "block", preset default)
while (condition) { print "123"; }
# RESULT OF SPLIT (node "block", preset default)
while (condition) {
  print "123";
}

