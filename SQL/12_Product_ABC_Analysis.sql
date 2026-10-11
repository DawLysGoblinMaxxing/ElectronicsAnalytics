WITH Product_data AS (
SELECT
	p.ProductKey,
	Product_Name,
	Category,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, Product_Name, Category
),

Revenues AS (
SELECT
	ProductKey,
	Product_Name,
	Category,
	Total_Revenue_USD,
	Total_Revenue_USD / SUM(Total_Revenue_USD) OVER() * 100.0 AS Revenue_Share_Percent,
	SUM(Total_Revenue_USD) OVER(ORDER BY Total_Revenue_USD DESC, ProductKey) / SUM(Total_Revenue_USD) OVER() * 100.0 AS Cumulative_Revenue_Share_Percent
FROM Product_data
)

SELECT
	ProductKey,
	Product_Name,
	Category,
	Total_Revenue_USD,
	Revenue_Share_Percent,
	Cumulative_Revenue_Share_Percent,
	CASE
		WHEN Cumulative_Revenue_Share_Percent <= 80 
			THEN 'A'
		WHEN Cumulative_Revenue_Share_Percent <= 95 
			THEN 'B'
		ELSE 'C'
	END AS ABC_Class
FROM Revenues
ORDER BY Total_Revenue_USD DESC, ProductKey;