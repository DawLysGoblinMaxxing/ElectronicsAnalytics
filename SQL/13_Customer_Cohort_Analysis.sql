WITH cohort AS (
SELECT
	CustomerKey,
	DATEFROMPARTS(YEAR(MIN(Order_Date)),MONTH(MIN(Order_Date)),1) AS Cohort_Month
FROM sales
GROUP BY CustomerKey
),

purchase AS (
SELECT 
	c.CustomerKey,
	c.Cohort_Month,
	DATEFROMPARTS(YEAR(Order_Date),Month(Order_Date),1) AS Purchase_Month
FROM cohort c
INNER JOIN sales s
	ON c.CustomerKey = s.CustomerKey
GROUP BY c.CustomerKey, c.Cohort_Month,DATEFROMPARTS(YEAR(Order_Date),Month(Order_Date),1)
)

SELECT
	Cohort_Month,
	Purchase_Month,
	COUNT(DISTINCT pu.CustomerKey) AS Active_Customers,		
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	COUNT(DISTINCT Order_Number) AS Total_Orders,
	SUM(Unit_Price_USD * quantity) / COUNT(DISTINCT pu.CustomerKey) AS Revenue_Per_Customer_USD
FROM purchase pu
INNER JOIN sales s
	ON s.CustomerKey = pu.CustomerKey
	AND pu.Purchase_Month = DATEFROMPARTS(YEAR(s.Order_Date), MONTH(s.Order_Date),1)
INNER JOIN products pr
	ON pr.ProductKey = s.ProductKey	
GROUP BY Cohort_Month, Purchase_Month
ORDER BY Cohort_Month, Purchase_Month;
