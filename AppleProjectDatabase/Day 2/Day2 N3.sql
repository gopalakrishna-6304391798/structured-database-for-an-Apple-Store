SELECT * FROM orders;
SELECT * FROM returns;
SELECT * FROM customers;



-- Get all the cx name and no orders, and returns they have done if they have done more than 1 return categorized the cx as returning else new

-- join orders -- RETURNS
-- join cx based cx id
-- cx id, cx name, count(order_id), cnt(return)
-- GROUP BY cx id and cx name

SELECT 
    customer_id,
    customer_name,
    total_orders,
    total_returns,
    CASE
        WHEN total_returns > 1 THEN 'Returning_cx'
        ELSE 'New'
    END as cx_category,
    (total_orders - total_returns)::numeric/total_orders::numeric * 100 as return_ratio  
FROM
(SELECT
    o.customer_id,
    c.customer_name,
    COUNT(o.order_id) as total_orders,
    COUNT(r.return_id) as total_returns
FROM orders as o
LEFT JOIN
returns as r
ON o.order_id = r.order_id
JOIN
customers as c
ON c.customer_id = o.customer_id
GROUP BY 1, 2
) t3


-- Customer Purchase Frequency: Categorize customers based on their purchase frequency: 'Occasional', 'Regular', and 'Frequent'. (If greater 5 than Occasional, If between 5 and 10 than Regular else Frequent


