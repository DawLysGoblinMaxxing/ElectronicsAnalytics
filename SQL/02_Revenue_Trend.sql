SELECT
	YEAR(Order_Date) AS Year,
	MONTH(Order_Date) AS Month,
	SUM(unit_price_usd * quantity) AS Total_Revenue_USD,
	SUM(unit_cost_usd * quantity) AS Total_Cost_USD,
	SUM(unit_price_usd * quantity) - SUM(unit_cost_usd * quantity) AS Gross_Profit_USD,
	(SUM(unit_price_usd * quantity) - SUM(unit_cost_usd * quantity)) / SUM(unit_price_usd * quantity) * 100.0 AS Gross_Margin_Percent,
	COUNT(DISTINCT Order_Number) AS Total_Orders,
	SUM(quantity) AS Total_Units
FROM sales s
INNER JOIN products p
	ON p.productkey = s.productkey
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date) , MONTH(order_date);