\echo retrieve all rows and columns from people table in "select" schema
SELECT *
FROM "select".people;

\echo when writing program code you should explicitly name all columns
SELECT id,name,created_at
FROM "select".people;

\echo retrieve only the name column from people relation in "select" schema
-- splitting lines is cool too
SELECT name
FROM "select".people;

-- with select alone you either get none, some, or all columns. WHERE for rows
\echo SELECT 1/FROM to do size checks on your relation
SELECT NULL from "select".people;