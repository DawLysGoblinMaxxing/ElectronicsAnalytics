WITH Customers_Total AS (
SELECT
	s.CustomerKey,
	Name,
	Country,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(quantity) AS Total_Units,
	COUNT(DISTINCT Order_Number) AS Total_Orders,
	SUM(Unit_Price_USD * quantity) / COUNT(DISTINCT Order_Number) AS Average_Order_Value_USD
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
	Total_Units,
	Total_Orders,
	Average_Order_Value_USD,
	CASE
		WHEN Total_Revenue_USD > (SELECT AVG(Total_Revenue_USD)  FROM Customers_Total)
			THEN 'High Value'
		ELSE 'Regular'
			END AS Customer_Segment
FROM Customers_Total
ORDER BY Total_Revenue_USD DESC;