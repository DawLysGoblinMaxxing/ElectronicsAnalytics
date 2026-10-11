SELECT 
	s.ProductKey,
	Product_Name,
	Brand,
	Category,
	Subcategory,
	SUM(quantity) AS Total_Units,
	SUM(unit_price_usd * quantity) AS Total_Revenue_USD,
	SUM(unit_cost_usd * quantity) AS Total_Cost_USD,
	SUM(unit_price_usd * quantity) - SUM(unit_cost_usd * quantity) AS Gross_Profit_USD,
	(SUM(unit_price_usd * quantity) - SUM(unit_cost_usd * quantity)) / SUM(unit_price_usd * quantity) * 100.0 AS Gross_Margin_Percent
FROM sales s
INNER JOIN products p
	ON p.productkey = s.productkey
GROUP BY s.ProductKey, Product_Name, Brand, Category, Subcategory
ORDER BY Gross_Profit_USD DESC;