-- Active: 1764614239757@@127.0.0.1@3306@hiring_people
-- Active: 1764614239757@@127.0.0.1@3306@hiring_people

--- DROP TABLE users,employers,conversation;
DROP TABLE users;
DROP TABLE conversation;
DROP TABLE employers;
CREATE TABLE employers (
    --- id INT PRIMARY KEY AUTO_INCREMENT, ---MYSQL
    id SERIAL PRIMARY KEY,
    co_name VARCHAR(250) NOT NULL,
    co_address VARCHAR(400) NOT NULL,
    revenue NUMERIC(6,3),
    is_hiring BOOLEAN DEFAULT TRUE
);
CREATE TYPE job_state AS ENUM ('employed','unemployed','self_employed');

CREATE TABLE users (
    id SERIAL PRIMARY KEY
    first_name VARCHAR(200) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    full_name VARCHAR(451) GENERATED ALWAYS AS (concat(first_name,' ',last_name)),
    yearly_salary INT CHECK (yearly_salary > 0),
    current_state job_state NOT NULL
);
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(200) NOT NULL,
    last_name VARCHAR(250) NOT NULL,
    full_name VARCHAR(451) GENERATED ALWAYS AS (CONCAT(first_name,' ',last_name)),
    yearly_salary INT CHECK (yearly_salary > 0),
    current_state ENUM('employed', 'unemployed', 'self_employed') NOT NULL
);
CREATE TABLE conversation (
    --- id INT PRIMARY KEY AUTO_INCREMENT, --- MYSQL
    id SERIAL PRIMARY KEY,
    user_id INT,
    company_id INT,
    message TEXT NOT NULL,
    date_sent TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

    CREATE TEMPORARY TABLE mix_family(
        complete_name VARCHAR(451) GENERATED ALWAYS AS (concat(first_name,' ',last_name))
    ) AS SELECT first_name,last_name FROM users ;
    Select * from mix_family;
