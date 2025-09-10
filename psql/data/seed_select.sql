CREATE SCHEMA IF NOT EXISTS "select";
DROP TABLE IF EXISTS "select".people;

CREATE TABLE IF NOT EXISTS "select".people (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO "select".people (name) 
VALUES
    ('Jason'),
    ('Kimya'),
    ('Zach');

