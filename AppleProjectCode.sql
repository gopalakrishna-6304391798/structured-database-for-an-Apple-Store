create database sql_b9_apple_store_db;
drop table if exists stores;
create table stores
(
store_id int primary key,
storename varchar(50),
country varchar(50),
city varchar(50)

);

select * from stores
drop table if exists products
create table products
(
product_id int primary key,
product_name varchar(50),
category varchar(50),
price float,
launched_price float,
cogs float
);

select * from products;
alter table products
add constraint pk_products
primary key(product_id);

create table sales
(
sale_id int primary key,
store_id int ,
product_id int,
sale_date date, 
quantity int,
constraint fk_stores foreign key(store_id) references stores(store_id)
); 
-- DML function
-- alter
select * from sales
alter table sales
add constraint fk_products
foreign key (product_id)
references products(product_id);

alter table sales
add column sale_price float;

alter table sales
add column day_of_sale varchar(10);

select to_char(current_date,'day')

select *, to_char(sale_date, 'day') from sales;

select *,length(trim(to_char(sale_date,'day'))) from sales;
-- update
update sales set day_of_sale=trim(to_char(sale_date,'day'));

update sales as s
set sale_price=p.price*s.quantity
from products as p
where s.product_id =p.product_id;
-- total sales from india in last 5 years
 select extract(year from s.sale_date) as years,
        extract(month from s.sale_date) as month
		sum(s.sale_price) as revenue
from sales as s
 join stores as st
 on s.store_id=st.store_id
 where st.country='India'
 and s.sale_date>=current_date - interval '5 years' group by 1,2
-- Apple bussiness problem
--Find top 5 product with highest profit

select product_name,sum(sale_price) as revenue,
sum(profit) as profit from
(SELECT 
    s.product_id, 
    p.product_name, 
	sale_price,
    (s.sale_price - (p.cogs * s.quantity)) AS profit
FROM 
    sales AS s
JOIN 
    products AS p 
ON 
    s.product_id = p.product_id
)as t1
group by product_name
-- Total Sales by Product: How many units of each product have been sold?
select product_name,sum(sale_price) as revenue,
sum(profit) as profit,
sum(unit_sold) as unit_sold
from
(SELECT 
    s.product_id, 
    p.product_name, 
	s.sale_price,
    s.sale_price - (p.cogs * s.quantity) AS profit,
	s.quantity as unit_sold
FROM 
    sales AS s
JOIN 
    products AS p 
ON 
    s.product_id = p.product_id
)as t1
group by product_name

-- Top Revenue-Generating Stores: Which are the top 5 stores generating the highest revenue?
select product_name,sum(sale_price) as revenue,
sum(profit) as profit,
sum(unit_sold) as unit_sold
from
(SELECT 
    s.product_id, 
    p.product_name, 
	s.sale_price,
    s.sale_price - (p.cogs * s.quantity) AS profit,
	s.quantity as unit_sold
FROM 
    sales AS s
JOIN 
    products AS p 
ON 
    s.product_id = p.product_id
)as t1
group by product_name
order by revenue desc
limit 5
-- Classifying Products by Price Range: Classify products into different price ranges: 'Budget', 'Mid-Range', and 'Premium'
-- budget < 500
-- mid 500 and 1000
-- primium > 1000

select prod_category,
count(*) as cnt_product
from
(select *,
case 
when price < 500 then 'budget'
when price between 500 and 1000 then 'mid_range'
else 'premium'
end as prod_category
from products) t2
group by 1 

-- Store Performance Analysis: How are stores ranked based on their performance?
select * from stores
select * from products

-- Store Performance Analysis: How are stores ranked based on their performance?


CREATE TABLE orders_summary AS
SELECT 
    s.sale_id,
    s.sale_date,
    p.product_name,
    s.quantity,
    s.sale_price,
    st.store_id,
    store_name,
    s.day_of_sale,
    st.country
FROM 
    sales AS s
JOIN 
    products AS p ON s.product_id = p.product_id
JOIN 
    stores AS st ON s.store_id = st.store_id;










