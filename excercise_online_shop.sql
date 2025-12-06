-- Active: 1764614639709@@127.0.0.1@5432@online_shop@public@publicle@public
CREATE DATABASE online_shop;
CREATE TABLE sales_example (
    -- id INT PRIMARY KEY AUTO_INCREMENT, -- MYSQL
    id SERIAL PRIMARY KEY, -- POSTGRESQL
    date_created DATE DEFAULT (CURRENT_DATE),
    date_fulfilled DATE,
    pname VARCHAR(200) NOT NULL,
    cname VARCHAR(200) NOT NULL,
    volume INT NOT NULL CHECK (volume>=0),
    is_recurring BOOLEAN DEFAULT FALSE,
    is_distrupting BOOLEAN DEFAULT FALSE
);

INSERT INTO sales_example (pname,cname,volume,is_recurring,is_distrupting)
VALUES ('مداد','مینا',7000,TRUE,TRUE);
INSERT INTO products (pname,pprice,pcount,discription)
VALUES ('مبل',1500000,1,'فلزی ایستاده چوبی');
    ALTER Table products
    ADD COLUMN id INT PRIMARY KEY AUTO_INCREMENT FIRST;
    UPDATE sales_example
    SET pname = 'مداد شمعی',
        volume = 20
        WHERE id = 3;
    DELETE FROM sales_example
    WHERE id = 6;
    SELECT *  FROM sales_example
    WHERE date_created BETWEEN CURRENT_DATE AND '2025-12-03'
    ORDER BY volume ASC
    LIMIT 2;
    