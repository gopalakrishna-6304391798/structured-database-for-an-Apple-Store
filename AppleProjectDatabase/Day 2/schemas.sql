-- Day2 SQL B7 N1

-- SCHEMA of Appple Store Project

DROP TABLE IF EXISTS store;
CREATE TABLE store
                        (   store_id INT PRIMARY KEY,	
                            store_name VARCHAR(35) NOT NULL,	
                            country VARCHAR(25) NOT NULL,	
                            city VARCHAR(35)
                        );

-- CREATING TABLE for products

DROP TABLE IF EXISTS products;
CREATE TABLE products(
                        product_id INT PRIMARY KEY,	
                        product_name VARCHAR(35),
                        category VARCHAR(35),	
                        price FLOAT,
                        launched_price	FLOAT,
                        cogs FLOAT
                        );

DROP TABLE IF EXISTS sales;
-- creating sales table 
CREATE TABLE sales(
                    sale_id INT PRIMARY KEY, 	
                    store_id INT,	-- this is a primary key in store table
                    product_id INT, -- this is a primary key in p table	
                    saledate DATE,	
                    quantity INT,
                    CONSTRAINT fk_store FOREIGN KEY (store_id) REFERENCES store(store_id)
                    );                        


ALTER TABLE sales
ADD CONSTRAINT fk_products
FOREIGN KEY (product_id)
REFERENCES products(product_id);



-- END of SCHEMA