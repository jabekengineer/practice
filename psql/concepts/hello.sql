-- SQL Concept: Hello World - Basic Query Structure
-- This demonstrates the simplest SQL queries and basic SELECT structure

-- =============================================================================
-- 1. Hello World - The simplest SQL query
-- =============================================================================

-- Return a literal string value
SELECT 'Hello, World!' as greeting;

-- =============================================================================
-- 2. Basic SELECT with multiple columns
-- =============================================================================

-- Return multiple literal values in one query
SELECT 
    'Hello, World!' as greeting,
    'Welcome to SQL!' as welcome_message,
    42 as answer_to_everything,
    CURRENT_TIMESTAMP as current_time;

-- =============================================================================
-- 3. Basic arithmetic and expressions
-- =============================================================================

-- SQL can do calculations
SELECT 
    2 + 3 as addition,
    10 * 5 as multiplication,
    'Hello' || ' ' || 'World' as concatenation;

-- =============================================================================
-- 4. Basic query structure pattern
-- =============================================================================

-- This shows the fundamental structure of SQL queries:
-- SELECT what_columns
-- FROM which_table  
-- WHERE conditions
-- ORDER BY sort_order

-- Example with a simple table creation and query
CREATE TEMPORARY TABLE example_data (
    id INTEGER,
    name TEXT,
    value INTEGER
);

INSERT INTO example_data VALUES 
    (1, 'First', 100),
    (2, 'Second', 200),
    (3, 'Third', 150);

-- Basic query following the standard pattern
SELECT 
    id,
    name,
    value
FROM example_data 
WHERE value > 100
ORDER BY value DESC;
