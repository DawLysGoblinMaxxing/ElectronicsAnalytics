SELECT
	SUM(p.unit_price_usd * s.quantity) AS Total_Revenue_USD,
	SUM(p.unit_cost_usd * s.quantity) AS Total_Cost_USD,
	SUM(p.unit_price_usd * s.quantity) - SUM(p.unit_cost_usd * s.quantity) AS Gross_Profit_USD,
	(SUM(p.unit_price_usd * s.quantity) - SUM(p.unit_cost_usd * s.quantity)) / SUM(p.unit_price_usd * s.quantity) * 100.0 AS Gross_Margin_Percent,
	COUNT(DISTINCT s.Order_Number) AS Total_Orders,
	SUM(s.quantity) AS Total_Units,
	SUM(p.unit_price_usd * s.quantity) / COUNT(DISTINCT s.Order_Number) AS Average_Order_Value_USD
FROM sales s
INNER JOIN products p 
		ON s.ProductKey = p.ProductKey