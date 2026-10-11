SELECT
	s.StoreKey,
	Country,
	State,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(Unit_Cost_USD * quantity) AS Total_Cost_USD,
	SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity) AS Gross_Profit_USD,
	(SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity)) / SUM(Unit_Price_USD * quantity) * 100.0 AS Gross_Margin_Percent,
	SUM(quantity) AS Total_Units,
	COUNT(DISTINCT Order_Number) AS Total_Orders
FROM sales s
INNER JOIN products p 
	ON s.ProductKey = p.ProductKey
INNER JOIN stores st
	ON s.StoreKey = st.StoreKey
GROUP BY s.StoreKey, Country, State
ORDER BY Gross_Profit_USD DESC;