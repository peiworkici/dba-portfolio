/************************Test data generation**************************/

--create test performance_orders

CREATE TABLE performance_orders (order_id BIGSERIAL PRIMARY KEY, customer_id INT, order_date TIMESTAMP,  amount DECIMAL(10,2), status VARCHAR(30));

--Insert data
INSERT INTO performance_orders
(customer_id, order_date, amount, status) 
SELECT 
(random() * 10000)::INT, NOW() - (random() * 365 *INTERVAL '1 day'), (random() * 1000)::NUMERIC(10,2),
	CASE
	   WHEN RANDOM() > 0.5 THEN 'Completed'
	   ELSE 'Pending'
	END
FROM generate_series(1,1000000);

--Confirmation the excution result
SELECT COUNT(*) 
FROM performance_orders;

/*********************Performance Analysis****************************/

--Seq Scan
EXPLAIN ANALYZE
SELECT * 
FROM performance_orders
WHERE customer_id=5000;

--INDEX CREATION
CREATE INDEX idx_performance_customer
ON performance_orders(customer_id);

--INDEX SCAN
EXPLAIN ANALYZE
SELECT *
FROM performance_orders
WHERE customer_id=5000;

--Multicolumn index creation
CREATE INDEX idx_customer_status
ON performance_orders(customer_id, status);

--TEST
EXPLAIN ANALYZE
SELECT *
FROM performance_orders
WHERE customers_id=5000
AND status= 'Completed';


--Analyze Table information
ANALYZE performance_orders;

--Table info
SELECT
	relname,
	n_live_tup,
	n_dead_tup,
FROM pg_stat_user_tables
WHERE relname = 'performance_orders';

--Index usage info
SELECT
	relname,
	idx_scan,
	idx_tup_read,
	idx_tup_fetch
FROM pg_stat_user_indexes
WHERE relname='performance_orders';





