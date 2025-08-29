-- Minimal Schema for SQL Practice
-- Only includes what's needed for basic concept demonstrations

-- Create practice schema
CREATE SCHEMA IF NOT EXISTS practice;
SET search_path TO practice, public;

-- Simple example table for demonstrations
CREATE TABLE IF NOT EXISTS demo_data (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    value INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert minimal sample data
INSERT INTO demo_data (name, value) VALUES
('Example 1', 100),
('Example 2', 200),
('Example 3', 150)
ON CONFLICT DO NOTHING;
