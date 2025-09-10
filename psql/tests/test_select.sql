BEGIN;
SELECT plan(2);

SELECT columns_are( 
    'select', 
    'people', 
    ARRAY['id','name','created_at']
);

SELECT results_eq(
    'SELECT lower(name) FROM "select".people ORDER BY name',
    ARRAY['jason','kimya','zach'],
    'the names in alpha order'
);

SELECT * FROM finish();
ROLLBACK;