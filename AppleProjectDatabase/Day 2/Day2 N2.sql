-- SQL B9 Day2 N2


SELECT * FROM products;
SELECT * FROM stores;
SELECT * FROM sales;

INSERT INTO products(product_id, product_name, launched_price)
VALUES
    (31, 'iPhone 16', 1299);


DROP TABLE IF EXISTS sales;

-- DML Function
-- Feature engineering
-- CTAS
-- 
SELECT * FROM stores;

-- Add records into stores

INSERT INTO stores
VALUES
(56, 'Apple Store Pune', 'India', 'Pune');,



INSERT INTO stores(store_id, store_name)
VALUES
(57, 'Apple Store Gurgaon'),
(58, 'Apple Store 2');

UPDATE stores
SET country = 'India'
WHERE store_id = 57;

SELECT * FROM stores;


UPDATE stores
SET country = 'India',
    city = 'Gurgaon'
WHERE store_id = 58;

SELECT * FROM stores;

-- TRUNCATE vs DELETE
-- DML
-- DDL

TRUNCATE TABLE stores;





DROP TABLE IF EXISTS sales;
CREATE TABLE sales
    (
    sale_id INT PRIMARY KEY,
    store_id INT, --- fk
    product_id INT, --- fk
    sale_date DATE,
    quantity INT,
    CONSTRAINT FK_stores FOREIGN KEY (store_id) REFERENCES stores(store_id),
    CONSTRAINT fk_products FOREIGN KEY (product_id) REFERENCES products(product_id)
    );


ALTER TABLE sales
ADD COLUMN sale_price FLOAT;


ALTER TABLE sales
ADD COLUMN day_of_sale VARCHAR(10);


SELECT TO_CHAR(CURRENT_DATE, 'Day')


SELECT 
    *,
    LENGTH(TRIM(TO_CHAR(sale_date, 'day')))
FROM sales;


UPDATE sales
SET day_of_sale = TRIM(TO_CHAR(sale_date, 'day'));

UPDATE sales as s
SET sale_price = p.price * s.quantity
FROM products as p   
WHERE s.product_id = p.product_id 



-- total sales from india in last 5 years 

SELECT 
        EXTRACT(YEAR FROM s.sale_date) as years,
        EXTRACT(MONTH FROM s.sale_date) as month,
        SUM(s.sale_price) as revenue,
        COUNT(*)
FROM sales as s
JOIN
stores as st
ON s.store_id = st.store_id
WHERE st.country = 'India'
    AND
    s.sale_date >= CURRENT_DATE - INTERVAL '5 years'
GROUP BY 1, 2
ORDER BY 1, 3 DESC


-- Get me last 3 month sale, total qty, total orders, for each country


CREATE TABLE latest_3_years_reports
AS
SELECT 
        st.country,
        -- EXTRACT(YEAR FROM s.sale_date) as years,
        -- EXTRACT(MONTH FROM s.sale_date) as month,
        SUM(s.sale_price) as revenue,
        COUNT(*) as total_orders,
        SUM(s.quantity) as unit_sold
FROM sales as s
JOIN
stores as st
ON s.store_id = st.store_id
WHERE s.sale_date >= CURRENT_DATE - INTERVAL '3 years'
GROUP BY 1
ORDER BY 1, 4 DESC;



SELECT * 
FROM latest_3_years_reports


/*
Find top 5 product with highest profit 
Total Sales by Product: How many units of each product have been sold?
Sales by Store: How many units have been sold in each store?
Top-Selling Products: What are the top 5 best-selling products by quantity?
Top Revenue-Generating Stores: Which are the top 5 stores generating the highest revenue?

*/

-- Find top 5 product with highest profit 

-- products and sales
group by pid SUM(sale) - cogs* qty


SELECT
    product_name,
    SUM(sale_price) as revenue,
    SUM(profit) as profit,
    SUM(unit_sold) as unit_sold

FROM
    (SELECT 
        s.product_id,
        p.product_name,
        s.sale_price,
        s.sale_price -(p.cogs * s.quantity) as profit,
        s.quantity as unit_sold
    FROM sales as s
    RIGHT join
    products as p
    ON s.product_id = p.product_id
) as t1
GROUP BY product_name
ORDER BY revenue DESC
LIMIT 5

-- CASE STATEMENT


-- Classifying Products by Price Range: Classify products into different price ranges: 'Budget', 'Mid-Range', and 'Premium'
    
-- Sales Performance Evaluation: Evaluate the sales performance of each store based on total sales quantity: 'Low', 'High'. (if greater than average of sale call high else call low

-- Classifying Products by Price Range: Classify products into different price ranges: 'Budget', 'Mid-Range', and 'Premium'
    
-- budget < 500
-- mid- 500 and 1000
-- Premium > 1000


SELECT 
    prod_category,
    COUNT(*) as cnt_product
FROM 
(SELECT 
    *,
    CASE
        WHEN price < 500 THEN 'budget'
        WHEN price BETWEEN 500 AND 1000 THEN 'mid_range'
        ELSE 'premium'
    END as prod_category
FROM products
) t2
GROUP BY 1



32443.54545454

SELECT ROUND(32443.54545454, 2)

SELECT ABS(-5)

SELECT RANDOM()

SELECT CONCAT('john', ' ', 'smith')
    
SELECT LENGTH('Hello world')

SELECT LEFT('Hello world', 2)

-- Wildcard
SELECT * FROM products
WHERE product_name LIKE '__r%'


SELECT * FROM products
WHERE product_name LIKE 'i%x'

-- 
CREATE TABLE orders_summary
AS    
SELECT 
        s.sale_id,
        s.sale_date,
        p.product_id,
        p.product_name,
        s.quantity,
        s.sale_price,
        p.cogs,
        st.store_id,
        st.store_name,
        s.day_of_sale,
        st.country
FROM products as p
JOIN 
sales as s
    ON s.product_id = p.product_id
JOIN stores as st
ON s.store_id = st.store_id

EXPLAIN ANALYZE -- et 408.0 ms pt -- .45 ms
SELECT * FROM 
orders_summary
WHERE country = 'India'

-- 

CREATE INDEX country_index ON orders_summary(country);

EXPLAIN ANALYZE -- 724 ms
SELECT * FROM 
orders_summary
WHERE sale_date = '2017-10-02'


CREATE INDEX date_index ON orders_summary(sale_date);


-- VIEW 
DROP VIEW IF EXISTS orders_view;
CREATE VIEW orders_view
AS    
SELECT 
        s.sale_id,
        s.sale_date,
        p.product_id,
        -- p.product_name,
        s.quantity,
        s.sale_price,
        -- p.cogs,
        -- st.store_id,
        st.store_name,
        -- s.day_of_sale,
        st.country as countri
FROM products as p
JOIN 
sales as s
    ON s.product_id = p.product_id
JOIN stores as st
ON s.store_id = st.store_id
WHERE s.sale_date > CURRENT_DATE - INTERVAL '5 year'



SELECT 
    store_name,
    EXTRACT(YEAR FROM sale_date) as year,
    SUM(sale_price) as revenue
FROM orders_view
WHERE countri = 'UK'
GROUP BY 1, 2
ORDER BY 1, 3 DESC



-- Window Functions

CTAS, VIEWS, INDEX



-- Store Performance Analysis: How are stores ranked based on their performance?
    
Find the product with highest total profit from each country of 2020 (return country, product name, total unit sold, total profit
Find out top 5 store with the highest sale

    
SELECT 
    store_name,
    COUNT(*) as total_orders,
    RANK() OVER(ORDER BY COUNT(*) DESC) as rank,
    ROW_NUMBER() OVER(ORDER BY COUNT(*) DESC) as rn
FROM orders_summary
GROUP BY 1



    
