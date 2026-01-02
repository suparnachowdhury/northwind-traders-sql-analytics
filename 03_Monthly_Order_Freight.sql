/**************************
Question 3: Monthly Freight and Order Analysis (2014–2015)

The Logistics Team wants to identify the months with the highest operational activity from 
January 2014 to April 2015. 

They asked to generate a monthly report including:

1. Year/Month as a single field in date format (e.g., "2014-01-01" for January 2014)
2. Total number of orders placed that month
3. Total freight, rounded to a whole number
***************************/

WITH cte_freight AS (
    SELECT 
        DATE_FORMAT(orderDate, '%m-%Y') AS month_year, 
        COUNT(*) AS total_number_orders,
        CAST(ROUND(SUM(freight), 0) AS UNSIGNED) AS total_freight
    FROM orders
    WHERE orderDate >= '2014-01-01' 
      AND orderDate < '2015-05-01'
    GROUP BY DATE_FORMAT(orderDate, '%m-%Y')
)
SELECT *
FROM cte_freight
WHERE total_number_orders > 25
ORDER BY total_freight DESC;