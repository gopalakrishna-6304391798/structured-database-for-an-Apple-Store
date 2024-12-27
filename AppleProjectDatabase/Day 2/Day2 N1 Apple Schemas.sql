-- SQL Day2 N1
-- Apple schemas


-- PRIMARY KEY
-- FOREIGN KEY
-- NOT NULL
-- CHECK
-- DEFAULT
-- UNIQUE


-- PK
-- It doesn't allow duplicate
-- it has to be not null or unique
-- it can be only in one table


CREATE DATABASE sql_b9_apple_store_db;

-- creating store table

DROP TABLE IF EXISTS stores;
CREATE TABLE stores
    (
        store_id INT PRIMARY KEY, 	
        store_name VARCHAR(55),	
        country	VARCHAR(25),
        city VARCHAR(55)
    );


DROP TABLE IF EXISTS products;
CREATE TABLE products
    (
        product_id	INT PRIMARY KEY,
        product_name	VARCHAR(55),
        category	VARCHAR(25),
        price	FLOAT,
        launched_price FLOAT,	
        cogs FLOAT
    )

SELECT * FROM products;

ALTER TABLE products
ADD CONSTRAINT pk_products
PRIMARY KEY (product_id);

DROP TABLE IF EXISTS sales;
CREATE TABLE sales
    (
    sale_id INT PRIMARY KEY,
    store_id INT, --- fk
    product_id INT, --- fk
    sale_date DATE,
    quantity INT,
    CONSTRAINT FK_stores FOREIGN KEY (store_id) REFERENCES stores(store_id)
    );


ALTER TABLE sales
ADD CONSTRAINT fk_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);



