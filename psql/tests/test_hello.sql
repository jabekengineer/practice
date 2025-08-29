-- Test: Hello World - Basic Query Structure
-- This file tests the hello world concept

BEGIN;

-- Load the pgTAP extension
CREATE EXTENSION IF NOT EXISTS pgtap;

-- Plan the number of tests
SELECT plan(4);

-- Test 1: Basic hello world query returns expected greeting
SELECT is(
    (SELECT 'Hello, World!' as greeting),
    'Hello, World!',
    'Hello world query should return greeting'
);

-- Test 2: Basic SELECT query works
SELECT ok(
    (SELECT 'Hello, World!') IS NOT NULL,
    'Basic SELECT query should work'
);

-- Test 3: Arithmetic operations work
SELECT is(
    (SELECT 2 + 3 as result),
    5,
    'Basic arithmetic should work'
);

-- Test 4: String concatenation works
SELECT is(
    (SELECT 'Hello' || ' ' || 'World' as result),
    'Hello World',
    'String concatenation should work'
);

-- Finish the test suite
SELECT * FROM finish();
ROLLBACK;
