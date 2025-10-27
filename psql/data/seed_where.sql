DROP SCHEMA IF EXISTS "where" CASCADE;
-- dropping schema drops sequences too
CREATE SCHEMA "where";

CREATE TABLE "where".numbers(
    boolean BOOLEAN DEFAULT true,
    integer INTEGER,
    percent NUMERIC(5, 2),
    dollars MONEY
);

INSERT INTO "where".numbers (integer, percent, dollars)
VALUES
(1, '99.99', '1234567.89');

INSERT INTO "where".numbers (boolean)
VALUES
('t'), ('true'), (TRUE), ('yes'), ('on'), ('1');

INSERT INTO "where".numbers (boolean, dollars)
VALUES
('off', 1337.00);


CREATE TABLE "where".text(
    text TEXT DEFAULT 'fdkajfhdakjafhjasondhfkajhkfjdz',
    char VARCHAR(10)
);
INSERT INTO "where".text (text)
VALUES
('jAsOnSeBeK!');

INSERT INTO "where".text (char)
VALUES
('jasonsebek');

-- schema qualify sequence so it is not in default `public` namespace.
CREATE SEQUENCE "where".key_seq AS integer;
CREATE TABLE "where".keys(
    serial      SERIAL,
    serial_eq   integer NOT NULL DEFAULT nextval('where.key_seq'),
    uuid        UUID UNIQUE DEFAULT gen_random_uuid()
);
ALTER SEQUENCE "where".key_seq OWNED BY "where".keys.serial_eq;

CREATE TABLE "where".dates(
    date DATE DEFAULT NOW(),
    time TIME DEFAULT NOW(),
    timestamp TIMESTAMP DEFAULT NOW(),
    timestamptz TIMESTAMPTZ DEFAULT NOW(),
    interval INTERVAL
);