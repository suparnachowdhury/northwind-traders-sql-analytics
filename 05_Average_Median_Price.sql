/********************************
-- Question 5
The Product Team wants to know for each currently offered product how their unit price
compares against their categories average and median unit price. In order to help them 
they asked you to provide them a list of products with:
1. their category name
2. their product name
3. their unit price
4. their category average unit price (formatted to have only 2 decimals)
5. their category median unit price (formatted to have only 2 decimals)
6. their position against the category average unit price as:
    * Below Average
    * Equal Average
    * Over Average
7. their position against the category median unit price as:
    * Below Median
    * Equal Median
    * Over Median

Filtered on the following conditions:
    * They are not discontinued

Finally order the results by category name then product name (both ascending).
***********************************/

-- Solution query
WITH price_list AS (
    SELECT
        c.categoryName,
        p.productName,
        p.unitPrice,

        ROUND(AVG(d.unitPrice), 2) AS avgUnitPrice,

        -- Median calculation in MySQL
        ROUND(
            AVG(d2.unitPrice),
            2
        ) AS medianUnitPrice

    FROM categories c
    JOIN products p
        ON c.categoryID = p.categoryID
    JOIN order_details d
        ON p.productID = d.productID
    JOIN (
        SELECT
            productID,
            unitPrice,
            ROW_NUMBER() OVER (PARTITION BY productID ORDER BY unitPrice) AS rn,
            COUNT(*) OVER (PARTITION BY productID) AS cnt
        FROM order_details
    ) d2
        ON d.productID = d2.productID
        AND d2.rn IN (FLOOR((d2.cnt + 1) / 2), FLOOR((d2.cnt + 2) / 2))

    WHERE p.discontinued = 0

    GROUP BY
        c.categoryName,
        p.productName,
        p.unitPrice
)

SELECT
    categoryName,
    productName,
    unitPrice,
    avgUnitPrice,
    medianUnitPrice,

    CASE
        WHEN unitPrice > avgUnitPrice THEN 'Over Average'
        WHEN unitPrice = avgUnitPrice THEN 'Equal Average'
        ELSE 'Below Average'
    END AS avgUnitPriceStatus,

    CASE
        WHEN unitPrice > medianUnitPrice THEN 'Over Median'
        WHEN unitPrice = medianUnitPrice THEN 'Equal Median'
        ELSE 'Below Median'
    END AS medianUnitPriceStatus

FROM price_list
ORDER BY
    categoryName,
    productName;
