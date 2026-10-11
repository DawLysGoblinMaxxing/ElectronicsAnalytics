WITH Monthly_Revenue AS (
SELECT
	YEAR(Order_Date) AS Year,
	MONTH(Order_Date) AS Month,
	s.ProductKey,
	Product_Name,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity) AS Gross_Profit_USD
FROM sales s
INNER JOIN products p 
	ON s.ProductKey = p.ProductKey
GROUP BY YEAR(Order_Date), MONTH(Order_Date), s.ProductKey, Product_Name
)

SELECT
	Year,
	Month,
	ProductKey,
	Product_Name,
	Total_Revenue_USD,
	Gross_Profit_USD,
	LAG(Total_Revenue_USD,1) OVER(PARTITION BY ProductKey ORDER BY Year, Month) AS Previous_Month_Revenue_USD,
	Total_Revenue_USD - LAG(Total_Revenue_USD,1) OVER(PARTITION BY ProductKey ORDER BY Year, Month) AS Revenue_Change_USD,
	(Total_Revenue_USD - LAG(Total_Revenue_USD,1) OVER(PARTITION BY ProductKey ORDER BY Year, Month)) / LAG(Total_Revenue_USD,1) OVER(PARTITION BY ProductKey ORDER BY Year, Month) * 100.0 AS Revenue_Change_Percent
FROM Monthly_Revenue
ORDER BY ProductKey, Year, Month;