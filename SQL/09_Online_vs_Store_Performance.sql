WITH Order_Delivery AS (
SELECT
	Order_Number,
	StoreKey,
	Order_Date,
	Delivery_Date,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(quantity) AS Total_Units,
	DATEDIFF(day, Order_Date, Delivery_Date) AS Delivery_Days
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
GROUP BY Order_Number, StoreKey, Order_Date, Delivery_Date
)

SELECT
	CASE 
		WHEN StoreKey = 0 THEN 'Online'
		ELSE 'Store'
	END AS Sales_Channel,
	COUNT(*) AS Total_Orders,
	SUM(Total_Revenue_USD) AS Total_Revenue_USD,
	SUM(Total_Units) AS Total_Units,
	SUM(Total_Revenue_USD) / COUNT(*) AS Average_Order_Value_USD,
	AVG(Delivery_Days) AS Average_Delivery_Days
FROM Order_Delivery od
GROUP BY CASE 
			WHEN StoreKey = 0 THEN 'Online'
			ELSE 'Store'
		END;
