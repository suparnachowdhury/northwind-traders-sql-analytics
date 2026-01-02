/********************************
Question: Country-Level Shipping Performance Analysis
The Logistics Team wants to evaluate their performance for the year 2014 to identify countries
where shipping efficiency could be improved. They have asked you to provide a summary report with
the following information for each country:

-- The average number of days between the order date and the shipped date (rounded to two decimal places).
-- The total number of orders placed in 2014.
********************************/
   SELECT
        c.country,
        ROUND(AVG(DATEDIFF(o.shippedDate, o.orderDate)), 2) AS average_days_between_order_shipping,
        COUNT(o.orderID) AS total_number_orders
    FROM orders o 
    INNER JOIN customers c 
    ON o.customerID = c.customerID
    WHERE YEAR(o.orderDate) = 2014
    GROUP BY c.country;