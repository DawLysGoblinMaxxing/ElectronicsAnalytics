WITH monthly_stats AS (
SELECT
	Year(Order_Date) AS Year,
	MONTH(Order_Date) AS Month,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity) AS Gross_Profit_USD
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
GROUP BY Year(Order_Date), MONTH(Order_Date)
)

SELECT
	Year,
	Month,
	Total_Revenue_USD,
	Gross_Profit_USD,
    LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month) AS Previous_Month_Revenue_USD,
	Total_Revenue_USD - LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month) AS Revenue_Change_USD,
	(Total_Revenue_USD - LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month)) / LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month) * 100.0 AS Revenue_Change_Percent,
	AVG(Total_Revenue_USD) OVER(ORDER BY Year, Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Rolling_3_Month_Revenue_USD
FROM monthly_stats
ORDER BY Year,Month;