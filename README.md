## Northwind Traders SQL Analytics

### Project Overview

This project demonstrates the use of advanced SQL techniques to analyze e-commerce data. The focus is on operational, sales, and logistics insights to help business teams make data-driven decisions.

The dataset used is a typical e-commerce schema including the following tables:

1. orders – Contains order-level information such as order date, shipped date, freight, customer, etc.
2. customers – Contains customer information including country and region.
3. products – Contains product details such as name, category, and unit price.
4. categories -
5. order_details – Contains the line items for each order including quantity, unit price, and discount.
6. shippers -

### Project Objectives

- Shipping Performance Analysis
- Evaluate shipping efficiency by country for the year 2014.
- Calculate average days between order and shipped dates.
- Identify countries with potential delays.
- Monthly Freight and Orders Analysis
- Analyze global monthly shipping performance from Jan 2014 – Apr 2015.
- Calculate total orders and total freight per month.
- Highlight months with high shipping volume.
- Product Pricing and Changes
- Customer Revenue Analysis
- Identify top customers by total revenue, order count, and average order value.
- Filter high-value customers for business insights.

### Key SQL Techniques Demonstrated

- Common Table Expressions (CTEs): Organize intermediate results and make queries more readable.
- Window Functions: Analyze trends over time, e.g., price changes per product.
- Aggregations & Grouping: Summarize data at monthly, country, or product level.
- Date Calculations: Calculate shipping times and monthly performance metrics.
- Conditional Filtering: Focus analysis on relevant records (e.g., high-order months, top customers).

### How to Run

- Ensure you have MySQL 8+ (or another SQL engine that supports CTEs) installed.
- Load the e-commerce dataset (orders, customers, products, order_details).
- Open the SQL scripts provided and execute them in your SQL client.
- Queries are modular and can be executed individually:
    - ShippingPerformance.sql → Country-level shipping analysis.
    - MonthlyFreight.sql → Monthly orders and freight analysis.
    - ProductPriceChanges.sql → Track price changes per product.

### Sample Queries
-- Monthly Freight Analysis
WITH cte_freight AS (
    SELECT 
        DATE_FORMAT(orderDate, '%Y-%m-01') AS year_month,
        COUNT(*) AS total_number_orders,
        CAST(ROUND(SUM(freight), 0) AS UNSIGNED) AS total_freight
    FROM orders
    WHERE orderDate >= '2014-01-01' AND orderDate < '2015-05-01'
    GROUP BY DATE_FORMAT(orderDate, '%Y-%m-01')
)
SELECT *
FROM cte_freight
WHERE total_number_orders > 25
ORDER BY total_freight DESC;

-- Country Shipping Performance (2014)
SELECT
    c.country,
    ROUND(AVG(DATEDIFF(o.shippedDate, o.orderDate)), 2) AS avg_shipping_days,
    COUNT(o.orderID) AS total_orders
FROM orders o
INNER JOIN customers c ON o.customerID = c.customerID
WHERE YEAR(o.orderDate) = 2014
GROUP BY c.country
HAVING total_orders > 10
ORDER BY avg_shipping_days DESC;

Business Value

- Helps the Logistics Team identify shipping bottlenecks by country and month.
- Enables the Product Team to track pricing trends and identify products with significant price changes.
- Supports the Sales Team in identifying top customers and revenue trends.
- Provides actionable insights for improving operational efficiency and increasing revenue.
