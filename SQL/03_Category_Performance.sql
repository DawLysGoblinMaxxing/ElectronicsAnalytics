SELECT
	Category,
	SUM(unit_price_usd * quantity) AS Total_Revenue_USD,
	SUM(unit_cost_usd * quantity) AS Total_Cost_USD,
	SUM(unit_price_usd * quantity) - SUM(unit_cost_usd * quantity) AS Gross_Profit_USD,
	(SUM(unit_price_usd * quantity) - SUM(unit_cost_usd * quantity)) / SUM(unit_price_usd * quantity) * 100.0 AS Gross_Margin_Percent,
	COUNT(DISTINCT Order_Number) AS Total_Orders,
	SUM(quantity) AS Total_Units,
	SUM(unit_price_usd * quantity) / (
	SELECT 
		SUM(unit_price_usd * quantity) 
	FROM sales s 
	INNER JOIN products p 
		ON p.productkey = s.productkey
	) * 100.0 AS Revenue_Share_Percent
	

FROM sales s
INNER JOIN products p
	ON p.productkey = s.productkey
GROUP BY Category
ORDER BY Total_Revenue_USD DESC;