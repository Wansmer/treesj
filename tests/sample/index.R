# RESULT OF JOIN (node "arguments", cursor at arguments)
c(1, 2, 3)

# RESULT OF SPLIT (node "arguments", cursor at arguments)
c(
  1,
  2,
  3
)

# RESULT OF JOIN (node "arguments", cursor at subset)
mean(x[, 1], na.rm = TRUE)

# RESULT OF SPLIT (node "arguments", cursor at subset)
mean(
  x[, 1],
  na.rm = TRUE
)

# RESULT OF JOIN (node "parameters")
my_func <- function(xs = x[, 1], ys = y[, 2]) {
  sum(xs, ys)
}

# RESULT OF SPLIT (node "parameters")
my_func <- function(
  xs = x[, 1],
  ys = y[, 2]
) {
  sum(xs, ys)
}

# RESULT OF JOIN (node "left_assignment")
mylist <- list(r = "red", g = "green", b = "blue", c(1, 2, 3), matrix(1:9, nrow = 3))

# RESULT OF SPLIT (node "left_assignment")
mylist <- list(
  r = "red",
  g = "green",
  b = "blue",
  c(1, 2, 3),
  matrix(1:9, nrow = 3)
)

# RESULT OF JOIN (node "super_assignment")
sa <<- c(1, 2, 3)

# RESULT OF SPLIT (node "super_assignment")
sa <<- c(
  1,
  2,
  3
)

# RESULT OF JOIN (node "right_assignment")
c(1, 2, 3, 4) -> ra

# RESULT OF SPLIT (node "right_assignment")
c(
  1,
  2,
  3,
  4
) -> ra

# RESULT OF JOIN (node "super_right_assignment")
c("a", "b", "c") ->> sra

# RESULT OF SPLIT (node "super_right_assignment")
c(
  "a",
  "b",
  "c"
) ->> sra

# RESULT OF JOIN (node "equals_assignment")
ea = c(1, 2, 3)

# RESULT OF SPLIT (node "equals_assignment")
ea = c(
  1,
  2,
  3
)

# RESULT OF JOIN (node "function_definition")
max_by <- function(data, var, by) {
  data %>%
    group_by({{ by }}) %>%
    summarise(maximum = max({{ var }}, na.rm = TRUE))
}

# RESULT OF SPLIT (node "function_definition")
max_by <- function(
  data,
  var,
  by
) {
  data %>%
    group_by({{ by }}) %>%
    summarise(maximum = max({{ var }}, na.rm = TRUE))
}

# RESULT OF JOIN (node "call")
ggplot(aes(x = Sepal.Width, y = Sepal.Length))

# RESULT OF SPLIT (node "call")
ggplot(
  aes(x = Sepal.Width, y = Sepal.Length)
)

# RESULT OF JOIN (node "binary_operator")
b %>%
  sum(c(4, 5, 6))

# RESULT OF SPLIT (node "binary_operator")
b %>%
  sum(
    c(4, 5, 6)
  )

# RESULT OF JOIN (node "pipe")
b |>
  sum(c(4, 5, 6))

# RESULT OF SPLIT (node "pipe")
b |>
  sum(
    c(4, 5, 6)
  )
