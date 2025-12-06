-- Active: 1764614639709@@127.0.0.1@5432@hiring_people@public
DROP TABLE company;
CREATE TABLE company (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESS
    c_name VARCHAR(500) NOT NULL
);
CREATE TABLE teams (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESS
    team_name VARCHAR(500) NOT NULL,
    building_id INT,
    Foreign Key (building_id) REFERENCES company ON DELETE SET NULL -- table to table references by one column
    -- building_id INT REFERENCES company ON DELETE SET NULL -- column to column references
);
CREATE TABLE projects (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESS
    project_name VARCHAR(500) NOT NULL,
    deadline DATE NOT NULL
);
CREATE TABLE employees (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESS
    f_name VARCHAR(250) NOT NULL,
    l_name VARCHAR(400) NOT NULL,
    email VARCHAR(500)  UNIQUE NOT NULL,
    team_id INT DEFAULT 0,
    Foreign Key (team_id) REFERENCES teams ON DELETE SET DEFAULT
);
CREATE TABLE interanet_accounts (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESS
    email VARCHAR(500),
    FOREIGN KEY (email) REFERENCES employees (email) ON DELETE CASCADE,
    password VARCHAR(200)
);
-- intermediate table for n:n
CREATE TABLE projects_employees(
    id SERIAL PRIMARY KEY,
    employee_id INT,
    project_id INT,
    FOREIGN KEY (employee_id) REFERENCES employees ON DELETE CASCADE,
    Foreign Key (project_id) REFERENCES projects ON DELETE CASCADE
    -- FOREIGN KEY (employee_id,project_id) REFERENCES employees ON DELETE SET NULL -- composite foreign key

);
INSERT INTO company (c_name)
VALUES ('توسعه'),('مدیریت'),('تولید');
INSERT INTO teams (team_name,building_id)
VALUES ('تیم تحقیقات',1),('تیم برنامه نویسان',3),('اساتید',2);
INSERT INTO employees (f_name,l_name,email,team_id)
VALUES ('عرفان','غلام نژاد','erfan@gmail.com',2),
('مینا','لک','mina@gmail.com',3);
INSERT INTO interanet_accounts(email,password)
VALUES ('erfan@gmail.com','123qwe'),
('mina@gmail.com','ytry4');
INSERT INTO projects (project_name,deadline)
VALUES ('sql','2024-01-01'),('منابع انسانی','2025-01-01');
INSERT INTO projects_employees (employee_id,project_id)
VALUES (1,1),(1,2),(2,2),(2,1);
DELETE FROM employees
WHERE id =1;
SELECT e.id AS employee_id,f_name,l_name,i.email,password,p.id AS project_id,p.project_name,team_id,deadline,t.team_name,c_name FROM employees AS e
LEFT JOIN interanet_accounts AS i ON i.email = e.email
LEFT JOIN projects_employees AS pe ON e.id = pe.employee_id
LEFT JOIN projects AS p ON p.id = pe.project_id
LEFT JOIN teams AS t ON t.id = e.team_id AND t.id = 1 
LEFT JOIN company AS c ON c.id = t.building_id ;
SELECT e.id AS employee_id,f_name,l_name,e.email,c_name FROM employees AS e
LEFT JOIN teams AS t ON t.id = e.team_id
LEFT JOIN company AS c ON c.id = t.building_id WHERE t.building_id = 3;

DELETE FROM employees
WHERE id = 1;
CREATE TABLE self_employees (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESS
    f_name VARCHAR(250) NOT NULL,
    l_name VARCHAR(400) NOT NULL,
    supervisor INT REFERENCES self_employees ON DELETE SET NULL
);
INSERT INTO self_employees(f_name,l_name,supervisor)
VALUES ('alex','shoper',2),('madam','kori',1),('siri','joker',2);
SELECT * FROM self_employees AS se1
INNER JOIN self_employees AS se2 ON se1.id= se2.supervisor
ORDER BY se1.id ASC;
CREATE Table m_to_m(
    user_id INT ,
    friend_id INT ,
    FOREIGN KEY (user_id) REFERENCES self_employees(id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES self_employees(id) ON DELETE CASCADE,
    CHECK (user_id != friend_id AND user_id < friend_id)
);
DROP TABLE m_to_m;
INSERT INTO m_to_m
VALUES(1,2),(1,3),(2,3);
SELECT user_id,f_name || ' ' || l_name as full_name,friend_id ,SUM(friend_id) OVER(PARTITION BY f_name ORDER BY friend_id) FROM self_employees AS se1
LEFT JOIN m_to_m AS m ON se1.id= m.user_id
WHERE f_name ILIKE '_l%'
ORDER BY se1.id ASC;
INSERT INTO self_employees(f_name,l_name,supervisor)
VALUES (TRIM (TRAILING ' ' FROM 'ali   '),'babaee',3);

SELECT LENGTH(f_name) FROM self_employees;
SELECT EXISTS ( -- more efficient way bcz execute on first encounter
    SELECT f_name FROM self_employees
    WHERE f_name LIKE '%x%' AND l_name IN ('shoper')
);

SELECT email FROM employees -- email of employees are in teams now
WHERE team_id IN (
    SELECT id FROM teams
);
SELECT team_id,
    case WHEN team_id = 2 THEN 'توسعه'
    WHEN team_id = 3 THEN 'مدیریت'
    END
FROM employees;

BEGIN; -- 1.dedicate new short term momory 2.reset by runing again and automatically commit whatever in memory
INSERT INTO self_employees(f_name,l_name,supervisor)
VALUES ('ali','dadkhah',2);
SAVEPOINT save_1;
INSERT INTO self_employees(f_name,l_name,supervisor)
VALUES ('ali2','dadkhah2',2);
ROLLBACK to save_1; -- delete last change
COMMIT; -- end transaction
EXPLAIN ANALYSE
SELECT l_name FROM employees
WHERE l_name ILIKE '%نژاد%';
CREATE INDEX family_name_idx ON employees (l_name);
DROP INDEX family_name_idx;
CREATE INDEX family_name_idx ON employees (id,f_name,l_name);
EXPLAIN ANALYSE
SELECT id,f_name FROM employees
WHERE l_name ILIKE '%نژاد%'AND id = 1;

