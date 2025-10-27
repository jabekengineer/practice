BEGIN;
SELECT PLAN(12);

-- filter on numeric equality
SELECT is(
    (
        SELECT COUNT(*)::int
        FROM (
            SELECT *
            FROM "where".numbers
            -- equality is one =
            WHERE "integer"=1
        )
    ),
    1,
    'filter with exact integer match'
);

-- filter on numeric range
SELECT is_empty(
    'SELECT percent
    FROM "where".numbers
    WHERE percent <= 50.00',
    'no percentages in bottom half'
);

-- verify boolean default
SELECT results_eq(
    'SELECT "boolean"
    FROM "where".numbers
    WHERE "boolean"=true
    FETCH FIRST 7 ROW ONLY',
    $$VALUES (true), ('t'), ('true'), (TRUE), ('yes'), ('on'), ('1')$$,
    'default boolean is true'
);

SELECT results_eq(
    'SELECT dollars::numeric
    FROM "where".numbers
    WHERE NOT "boolean"',
    $$VALUES (1337.00)$$,
    'can use boolean column directly in equality and you can cast columns'
);

-- numeric range
SELECT is(
    (
        SELECT COUNT(*)::int
        FROM (
            SELECT *
            FROM "where".numbers
            WHERE dollars::numeric > 0
                AND dollars::numeric < 1250000
        )
    ),
    2,
    'two tuples with dollars'
);

-- pattern likeness
\echo cast or lower case your where column
SELECT is(
    (
        SELECT COUNT(*)::int
        FROM
        (
        SELECT "text"
        FROM "where".text
        WHERE lower("text") LIKE '%jason_____%'
        )
    ),
    2,
    'pattern likeness'
);

-- text equality
SELECT results_eq(
    'SELECT char::text
    FROM "where".text
    WHERE char = ''jasonsebek''',
    $$ VALUES ('jasonsebek') $$,
    'exact text match with double-single quotes and text conversion'
);

-- text length
SELECT cmp_ok(
    (
        SELECT GREATEST(t, c)::int
        FROM
        (
            SELECT
                MAX(LENGTH(text)) AS t,
                MAX(LENGTH(char)) AS c
            FROM "where".text
        )
    ),
    '>',
    10,
    'there is something longer than string jasonsebek in relation'
);

-- serial truly autoincrements
INSERT INTO "where".keys DEFAULT VALUES;
INSERT INTO "where".keys DEFAULT VALUES;
WITH ordered AS (
    SELECT serial
    FROM "where".keys
    ORDER by serial DESC
    LIMIT 2
),
labeled AS (
    SELECT
        MAX(serial) AS latest,
        MIN(serial) AS second_latest
    FROM ordered
)
SELECT cmp_ok(
    (SELECT latest - second_latest FROM labeled),
    '=',
    1,
    'serial column auto increments by 1 between consecutive inserts'
);

-- serial and serial_eq behave the same
INSERT INTO "where".keys DEFAULT VALUES;
SELECT is_empty(
    'SELECT *
    FROM "where".keys
    WHERE "serial" != serial_eq',
    'incrementing serial and integer sequence should be equivalent'
);

-- date <, >
INSERT INTO "where".dates DEFAULT VALUES;
SELECT cmp_ok(
    (
        SELECT COUNT(*)::int
        FROM
        (
            SELECT *
            FROM "where".dates
            WHERE date < NOW()
        )
    ),
    '=',
    1,
    'now is later than then'
);

-- interval
INSERT INTO "where".dates (interval)
VALUES
(INTERVAL '10 seconds');
SELECT cmp_ok(
    (
        SELECT interval
        FROM "where".dates
        WHERE interval IS NOT NULL
        ORDER BY interval DESC
        LIMIT 1
    ),
    '>',
    INTERVAL '9 seconds',
    'Interval comparison'
);


SELECT * FROM finish();
ROLLBACK;