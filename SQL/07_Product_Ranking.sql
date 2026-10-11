SELECT
	p.ProductKey,
	Product_Name,
	Brand,
	Category,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity) AS Gross_Profit_USD,
	(SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity)) / SUM(Unit_Price_USD * quantity) * 100.0 AS Gross_Margin_Percent,
	DENSE_RANK() OVER(PARTITION BY Category ORDER BY SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity) DESC) AS Category_Profit_Rank
FROM sales s
INNER JOIN products p 
	ON s.ProductKey = p.ProductKey
GROUP BY p.ProductKey, Product_Name, Brand, Category
ORDER BY Category, Category_Profit_Rank;
