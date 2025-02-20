-- 

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(id SERIAL, sale_amt INT, store_name VARCHAR(5));

INSERT INTO orders(sale_amt, store_name)
VALUES
(55, 'A'),
(50, 'A'),
(25, 'A'),
(25, 'A'),
(18, 'A'),
(65, 'B'),
(65, 'B'),
(50, 'B'),
(15, 'B'),
(18, 'C'),    
(16, 'C') ,  
(16, 'C')  ,  
(13, 'C'),
(13, 'C'),
(11, 'C');
SELECT * FROM orders;


-- 3rd highest, highest, 5th highest orders amt details

SELECT *,
    ROW_NUMBER() OVER(ORDER BY sale_amt DESC) as row_number,
    RANK() OVER(ORDER BY sale_amt DESC) as rank,
    DENSE_RANK() OVER(ORDER BY sale_amt DESC) as d_rank
FROM orders;


-- 3rd highest salary
-- 3rd highest amt order details

SELECT 
    id,
    sale_amt,
    store_name
FROM

(SELECT *,
    -- ROW_NUMBER() OVER(ORDER BY sale_amt DESC) as row_number,
    -- RANK() OVER(ORDER BY sale_amt DESC) as rank,
    DENSE_RANK() OVER(PARTITION BY store_name ORDER BY sale_amt DESC) as d_rank
FROM orders
) t1
WHERE d_rank = 3

    nth highest 
    27th highest 
    
GLOBAL RANKING
LOCAL RANKING
-- PARTITION BY 

-- For each store we want to see 3nd highest sale_amt order details

SELECT * FROM orders;



-- 

-- Amazon Interview Practice 21/02/2024


/* 1. You have two tables: Product and Supplier.
- Product Table Columns: Product_id, Product_Name, Supplier_id, Price
- Supplier Table Columns: Supplier_id, Supplier_Name, Country
*/



-- Write an SQL query to find the name of the product with the highest 
-- price in each country.

-- creating the product table 

-- creating supplier table 
DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(supplier_id int PRIMARY KEY,
					  supplier_name varchar(25),
					  country VARCHAR(25)
					  );
-- let's insert some values 

INSERT INTO suppliers
VALUES(501, 'alan', 'India'),
		(502, 'rex', 'US'),
		(503, 'dodo', 'India'),
		(504, 'rahul', 'US'),
		(505, 'zara', 'Canda'),
		(506, 'max', 'Canada')
;


DROP TABLE IF EXISTS products;
CREATE TABLE products(

						product_id int PRIMARY KEY,
						product_name VARCHAR(25),
						supplier_id int,
						price float,
						FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
						);

INSERT INTO products
VALUES	(201, 'iPhone 14', '501', 1299),
		(202, 'iPhone 8', '502', 999),
		(204, 'iPhone 13', '502', 1199),
		(203, 'iPhone 11', '503', 1199),
		(205, 'iPhone 12', '502', 1199),
		(206, 'iPhone 14', '501', 1399),
		(214, 'iPhone 15', '503', 1499),
		(207, 'iPhone 15', '505', 1499),
		(208, 'iPhone 15', '504', 1499),
		(209, 'iPhone 12', '502', 1299),
		(210, 'iPhone 13', '502', 1199),
		(211, 'iPhone 11', '501', 1099),
		(212, 'iPhone 14', '503', 1399),
		(213, 'iPhone 8', '502', 1099)
;

-- adding more products 

INSERT INTO products
VALUES	(222, 'Samsung Galaxy S21', '504', 1699),
		(223, 'Samsung Galaxy S20', '505', 1899),
		(224, 'Google Pixel 6', '501', 899),
		(225, 'Google Pixel 5', '502', 799),
		(226, 'OnePlus 9 Pro', '503', 1699),
		(227, 'OnePlus 9', '502', 1999),
		(228, 'Xiaomi Mi 11', '501', 899),
		(229, 'Xiaomi Mi 10', '504', 699),
		(230, 'Huawei P40 Pro', '505', 1099),
		(231, 'Huawei P30', '502', 1299),
		(232, 'Sony Xperia 1 III', '503', 1199),
		(233, 'Sony Xperia 5 III', '501', 999),
		(234, 'LG Velvet', '505', 1899),
		(235, 'LG G8 ThinQ', '504', 799),
		(236, 'Motorola Edge Plus', '502', 1099),
		(237, 'Motorola One 5G', '501', 799),
		(238, 'ASUS ROG Phone 5', '503', 1999),
		(239, 'ASUS ZenFone 8', '504', 999),
		(240, 'Nokia 8.3 5G', '502', 899),
		(241, 'Nokia 7.2', '501', 699),
		(242, 'BlackBerry Key2', '504', 1899),
		(243, 'BlackBerry Motion', '502', 799),
		(244, 'HTC U12 Plus', '501', 899),
		(245, 'HTC Desire 20 Pro', '505', 699),
		(246, 'Lenovo Legion Phone Duel', '503', 1499),
		(247, 'Lenovo K12 Note', '504', 1499),
		(248, 'ZTE Axon 30 Ultra', '501', 1299),
		(249, 'ZTE Blade 20', '502', 1599),
		(250, 'Oppo Find X3 Pro', '503', 1999);



SELECT * FROM suppliers;
SELECT * FROM products;


SELECT 
     supplier_id,
    supplier_name,
    product_id,
    price,
    country
FROM
    (
    SELECT 
        s.supplier_id,
        s.supplier_name,
        s.country,
        p.product_id,
        p.price,
        -- DENSE_RANK() OVER(ORDER BY p.price DESC) as g__rank,
        DENSE_RANK() OVER(PARTITION BY s.country ORDER BY p.price DESC) as d_l_rank
    FROM suppliers as s
    JOIN
    products as p
    ON s.supplier_id = p.supplier_id
    ) as t2
WHERE d_l_rank = 1



