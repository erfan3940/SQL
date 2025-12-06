-- Active: 1764614239757@@127.0.0.1@3306@hiring_people
-- Active: 1764614239757@@127.0.0.1@3306@hiring_people
CREATE TABLE employers (
    co_name VARCHAR(200),
    co_address VARCHAR(400),
    revenue NUMERIC(6,3),
    is_hiring BOOLEAN DEFAULT TRUE
);
INSERT INTO employers (co_name,co_address,revenue)
values ('didar','12th terme 23',1.256)

DROP TABLE employers;
ALTER TABLE employers
MODIFY COLUMN revenue NUMERIC(7,3);   ---ALTER COLUMN revenue SET DATE TYPE NUMERIC(7,3) for potgres


