WITH revenues AS (
SELECT
	YEAR(Order_Date) AS Year,
	MONTH(Order_Date) AS Month,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	COUNT(DISTINCT Order_Number) AS Total_Orders,
	SUM(quantity) AS Total_Units
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
),

revenues_change AS (
SELECT
	Year,
	Month,
	Total_Revenue_USD,
	Total_Orders,
	Total_Units,
	Total_Revenue_USD - LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month) AS Revenue_Change_USD,
	(Total_Revenue_USD - LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month)) / NULLIF(LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month),0) * 100.0 AS Revenue_Change_Percent,
	(Total_Revenue_USD - LAG(Total_Revenue_USD) OVER(PARTITION BY Month ORDER BY Year)) / LAG(Total_Revenue_USD) OVER(PARTITION BY Month ORDER BY Year) * 100.0 AS YoY_Revenue_Change_Percent
FROM revenues
)

SELECT
	Year,
	Month,
	Total_Revenue_USD,
	Total_Orders,
	Total_Units,
	Revenue_Change_USD,
	Revenue_Change_Percent,
	YoY_Revenue_Change_Percent,
	CASE
		WHEN YoY_Revenue_Change_Percent > 0  
			THEN 'Growth'
		WHEN YoY_Revenue_Change_Percent = 0
			THEN 'Stable'
		ELSE 'Decline'
			END AS Revenue_Trend
FROM revenues_change
ORDER BY Year, Month