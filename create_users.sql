-- Active: 1764614239757@@127.0.0.1@3306@hiring_people
-- Active: 1764614639709@@127.0.0.1@5432@hiring_people0.0.1@5432@hiring_people0.0.1@5432@hiring_people
CREATE DATABASE hiring_people;
-- postgres format 
CREATE TYPE  job_state AS ENUM ('employed','unemployed','self_employed');
CREATE TABLE users (
    full_name VARCHAR(200),
    yearly_salary INT CHECK (yearly_salary > 0),
    current_state  ENUM ('employed','unemployed','self_employed'));

INSERT INTO users (first_name,last_name,yearly_salary,current_state)
VALUES ('حسین','اکبری',200000,'employed');
ALTER TABLE users
MODIFY COLUMN current_state ENUM ('employed','unemployed','self_employed') not NULL,
MODIFY COLUMN full_name VARCHAR(200) not NULL;
--- postgres format
ALTER TABLE users
ALTER COLUMN current_state SET not NULL,
ALTER COLUMN full_name SET not NULL;
INSERT INTO users (full_name,yearly_salary,current_state)
VALUES ('hosein',200000,'employed');
INSERT INTO users (full_name,current_state)
VALUES ('modina','unemployed');

ALTER TABLE users
ADD CONSTRAINT positive_salary CHECK (yearly_salary>0);