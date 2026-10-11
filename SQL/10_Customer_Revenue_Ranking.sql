WITH customer_details AS (
SELECT
	s.CustomerKey,
	Name,
	Country,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	Count(Distinct Order_Number) AS Total_Orders
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
INNER JOIN customers c
	ON c.CustomerKey = s.CustomerKey
GROUP BY s.CustomerKey, Name, Country
)

SELECT 
	CustomerKey,
	Name,
	Country,
	Total_Revenue_USD,
	Total_Orders,
	Total_Revenue_USD / Total_Orders AS Average_Order_Value_USD,
	DENSE_RANK() OVER(PARTITION BY Country ORDER BY Total_Revenue_USD DESC) AS Country_Revenue_Rank,
	Total_Revenue_USD / SUM(Total_Revenue_USD) OVER(PARTITION BY Country) * 100.0 AS Revenue_Share_of_Country_Percent
FROM customer_details
ORDER BY Country, Country_Revenue_Rank;