-- DB Creation
CREATE DATABASE ecommerce;

CREATE TABLE customers (customer_id SERIAL PRIMARY KEY, 
first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(100),
created_atTIMESTAMP DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE products (product_id SERIAL PRIMARY KEY,
product-name VARCHAR(100), price DECIMAL(10,2), stock_quantity INT);

CREATE TABLE orders (order_id SERIAL PRIMARY KEY, 
customer_id INT REFERENCES customers(customer_id),
prder_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
total_amount DECIMAL(10,2)
status VARCHAR(30));

--INSERT DATA
INSERT INTO customers(first_name, last_name, email)
VALUES
('John','Smith','john@gmail.com'),
('David','Brown','david@gmail.com'),
('Anna','Wilson','anna@gmail.com');

INSERT INTO products(product_name, price, stock_quantity)
VALUES
('Laptop', 1200, 50),
('Mouse', 25, 200),
('Keyboard', 75, 100);

INSER INTO orders(customer_id, total_amount, status)
VALUES
(1, 1200, 'Completed'),
(2, 25, 'Pending'),
(3, 75, 'Completed');

--Check the result
SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;

--USER CREATION
CREATE ROLE dbauser
WITH LOGIN PASSWORD 'HERE_IS_A_FAKE_PASSWORD_FOR_GIT';

CREATE ROLE readonly_user
WITH LOGIN PASSWORD 'HERE_IS_A_FAKE_PASSWORD_TOO';

GRANT ALL PRIVILEGES
ON DATABASE  ecommerce
TO dba_user;

GRANT ALL 
ON SCHEMA public
TO dba_user;

GRANT CONNECT ON DATABASE ecommerce TO readonly_user;
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON TABLES IN SCHEMA public TO readonly_user;

ALTER DEFAULT PRIVILEGES IN SCHEMA public;
GRANT SELECT ON TABLES TO readonly_user;


--TEST RIGHTS
SET ROLE readonly_user;
SELECT * FROM customers;
RESET ROLE;


--CHECK DB CONNECTION
SELECT * FROM pg_stat_activity;
SELECT pg_database.datname, pg_size_pretty
(pg_database_size(pg_database.datname))
FROM pg_database;




