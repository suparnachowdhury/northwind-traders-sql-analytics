/********************************
-- Question 4
The Pricing Team wants to know how each category performs according to their price range. 
In order to help them they asked to provide them a list of categories with:

1. their category name
2. their price range as:
    'Below $20'
    'Between $20 and $50'
    'Over $50'
3. their total amount (formatted to be integer)
4. their number of orders

Finally order the results by category name then price range (both ascending order).
***********************************/

SELECT
	c.categoryName,
	CASE 
		WHEN p.unitPrice < 20 THEN 'Below $20'
		WHEN p.unitPrice >= 20 AND p.unitPrice <= 50 THEN 'Between $20 and $50'
		WHEN p.unitPrice > 50 THEN 'Over $50'
		END AS priceRange,
	ROUND(SUM(d.unitPrice * d.quantity)) AS totalAmount,
	COUNT(DISTINCT d.orderID) AS totalOrders
FROM categories AS c
INNER JOIN products AS p
ON c.categoryID =  p.categoryID
INNER JOIN order_details AS d
ON d.productID =  p.productID
GROUP BY 
	c.categoryName,
	priceRange
ORDER BY 
	c.categoryName,
	priceRange;
