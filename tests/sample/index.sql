-- RESULT OF JOIN (node "column_definitions", preset default)
CREATE TABLE my_table (id BIGINT NOT NULL PRIMARY KEY, date DATE DEFAULT NULL ASC);
-- RESULT OF SPLIT (node "column_definitions", preset default)
CREATE TABLE my_table (
  id BIGINT NOT NULL PRIMARY KEY,
  date DATE DEFAULT NULL ASC
);

-- RESULT OF JOIN (node "list", preset default)
INSERT INTO persons (first_name, last_name) VALUES ('Janet', 'Smith'), ('Lee', 'Reynolds')
-- RESULT OF SPLIT (node "list", preset default)
INSERT INTO persons (
  first_name,
  last_name
) VALUES ('Janet', 'Smith'), ('Lee', 'Reynolds')

-- RESULT OF JOIN (node "select_expression", preset default)
SELECT fullname, email AS "E-mail", tel AS "Phone"
FROM persons;
-- RESULT OF SPLIT (node "select_expression", preset default)
SELECT fullname,
       email AS "E-mail",
       tel AS "Phone"
FROM persons;
