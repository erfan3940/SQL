-- Active: 1764614239757@@127.0.0.1@3306@online_shop
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    -- id SERIAL PRIMARY KEY, -- POSTGRESS
    f_name VARCHAR(250) NOT NULL,
    l_name VARCHAR(400) NOT NULL,
    email VARCHAR(500) NOT NULL,
    address_id INT NOT NULL,
    FOREIGN KEY (address_id) REFERENCES addresses (id) ON DELETE RESTRICT ON UPDATE CASCADE
);
CREATE TABLE addresses (
    id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    -- id SERIAL PRIMARY KEY, -- POSTGRESS
    street VARCHAR(200) NOT NULL,
    house_n VARCHAR(250) NOT NULL,
    city_id INT NOT NULL
);
CREATE TABLE cities (
    id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    -- id SERIAL PRIMARY KEY, -- POSTGRESS
    `name` VARCHAR(200) NOT NULL
);
DROP TABLE addresses;

INSERT INTO cities(name)
VALUES('تهران')
,('اصفهان');
INSERT INTO addresses(street,house_n,city_id)
VALUES('محمدی','23',1),('محمدیان','45',2),
('قیاسی','243',2);
INSERT INTO users(f_name,l_name,email,address_id)
VALUES('علی','درفشه','drf@gmail.com',1),('کیان','لک','rtrf@gmail.com',2);
SELECT u.id,f_name ,l_name,email,street,a.house_n,c.name AS city
FROM users AS u
INNER JOIN address AS a ON u.address_id = a.id
INNER JOIN cities AS c ON a.city_id = c.id;
SELECT a.id,f_name ,l_name,email,street,a.house_n
FROM addresses AS a
LEFT JOIN users AS u ON a.id = u.address_id;
LEFT JOIN cities as s ON s.id = a.city_id;
SELECT * FROM users
CROSS JOIN address;
SELECT f_name FROM users
WHERE id = 1
UNION
SELECT street FROM address
WHERE id = 2;

DELETE FROM addresses
WHERE id = 2;
