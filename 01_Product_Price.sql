/****************************
Question 1 – Product Price Dynamics

The Product Team wants to evaluate price changes over time for all products to identify trends and
potential pricing issues.
They asked to provide the following information for each product:
1. Product name
2. Current unit price
3. Previous unit price (based on the last order date)
4. Percentage increase or decrease between the previous and current price

*****************************/
WITH cte_price AS
(SELECT
    d.productID,
    p.productName,
    d.unitPrice AS current_unit_price,
    LAG(d.unitPrice) OVER (PARTITION BY p.productID ORDER BY o.orderDate) AS previous_unit_price
FROM 
    order_details d
INNER JOIN 
    products p ON p.productID = d.productID
INNER JOIN 
    orders o ON d.orderID = o.orderID
)
    
    SELECT
	productName,
	current_unit_price,
	previous_unit_price,
	ROUND(100*(current_unit_price - previous_unit_price)/previous_unit_price) AS percentage_increase
FROM cte_price 
WHERE current_unit_price != previous_unit_price
GROUP BY 
	productName,
	current_unit_price,
	previous_unit_price
ORDER BY
	percentage_increase DESC;