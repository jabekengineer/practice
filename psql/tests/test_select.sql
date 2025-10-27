BEGIN;
SELECT plan(5);

SELECT columns_are(
    'select',
    'people',
    ARRAY['id','name','created_at']
);

SELECT results_eq(
    'SELECT lower(name)
    FROM "select".people
    ORDER BY name',
    ARRAY['jason','kimya','zach'],
    'the names in alpha order'
);

SELECT results_eq(
    'SELECT * from "select".people',
    'SELECT id,name,created_at from "select".people',
    'star expands to all column names'
);

SELECT isnt_empty(
    'SELECT NULL from "select".people',
    'selecting no columns but also no invalid columns returns empty relation'
);

SELECT is(
    (
        SELECT COUNT(*)::int
        FROM (
            SELECT NULL
            FROM "select".people
        )
    ),
    3,
    'selecting null make anonymous column with empty tuple rows'
);

SELECT * FROM finish();
ROLLBACK;