WITH basic_KPI AS (
SELECT
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD,
	SUM(Unit_Cost_USD * quantity) AS Total_Cost_USD,
	SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity) AS Gross_Profit_USD,
	(SUM(Unit_Price_USD * quantity) - SUM(Unit_Cost_USD * quantity)) / SUM(Unit_Price_USD * quantity) * 100.0 AS Gross_Margin_Percent,
	COUNT(DISTINCT Order_Number) AS Total_Orders,
	SUM(quantity) AS Total_Units,
	SUM(Unit_Price_USD * quantity) / COUNT(DISTINCT Order_Number) AS Average_Order_Value_USD
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
	),

best_category AS (
SELECT TOP 1
	Category AS Top_Category,
	SUM(Unit_Price_USD * quantity) AS Top_Category_Revenue_USD
FROM products p
INNER JOIN sales s 
	ON p.ProductKey = s.ProductKey
GROUP BY Category
ORDER BY Top_Category_Revenue_USD DESC
),

best_product AS (
SELECT TOP 1
	Product_Name AS Top_Product,
	p.ProductKey,
	SUM(Unit_Price_USD * quantity) AS Top_Product_Revenue_USD
FROM sales s
INNER JOIN products p 
	ON s.ProductKey = p.ProductKey
GROUP BY Product_Name, p.ProductKey
ORDER BY Top_Product_Revenue_USD DESC, p.ProductKey
),

best_store AS (
SELECT TOP 1
	st.StoreKey AS Top_Store,
	Country AS Top_Store_Country,
	SUM(Unit_Price_USD * quantity) AS Top_Store_Revenue_USD
FROM stores st
INNER JOIN sales s
	ON st.StoreKey = s.StoreKey
INNER JOIN products p
	ON p.ProductKey = s.ProductKey
WHERE st.StoreKey != 0
GROUP BY st.StoreKey, Country
ORDER BY Top_Store_Revenue_USD DESC
),

best_country AS (
SELECT TOP 1
	Country AS Top_Country,
	SUM(Unit_Price_USD * quantity) AS Top_Country_Revenue_USD
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
INNER JOIN stores st
	ON st.StoreKey = s.StoreKey
GROUP BY Country
ORDER BY Top_Country_Revenue_USD DESC
),

best_sales_channel AS (
SELECT TOP 1
	CASE
		WHEN s.StoreKey = 0 THEN 'Online'
		ELSE 'Store'
	END AS Top_Sales_Channel,
	SUM (Unit_Price_USD * quantity) AS Top_Sales_Channel_Revenue_USD
FROM sales s
INNER JOIN products p
	ON s.ProductKey = p.ProductKey
GROUP BY 
	CASE
		WHEN s.StoreKey = 0 THEN 'Online'
		ELSE 'Store'
	END
ORDER BY Top_Sales_Channel_Revenue_USD DESC
),

monthly_revenue AS (
SELECT
	YEAR(Order_Date) AS Year,
	Month(Order_Date) AS Month,
	SUM(Unit_Price_USD * quantity) AS Total_Revenue_USD
FROM sales s
INNER JOIN products p
	ON p.ProductKey = s.ProductKey
GROUP BY YEAR(Order_Date), Month(Order_Date)
),

monthly_changes AS (
SELECT
	Year,
	Month,
	Total_Revenue_USD,
	LAG(Total_Revenue_USD) OVER(ORDER BY Year, Month) AS Previous_Month_Revenue_USD,
	LAG(Total_Revenue_USD) OVER(PARTITION BY Month ORDER BY Year) AS Previous_Year_Revenue_USD
FROM monthly_revenue
),

latest_month AS (
SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY Year DESC, Month DESC) AS Ranking
FROM monthly_changes mc
)

SELECT
	b.Total_Revenue_USD,
	b.Total_Cost_USD,
	b.Gross_Profit_USD,
	b.Gross_Margin_Percent,
	b.Total_Orders,
	b.Total_Units,
	b.Average_Order_Value_USD,
	bca.Top_Category,
	bca.Top_Category_Revenue_USD,
	bp.Top_Product,
	bp.Top_Product_Revenue_USD,
	bs.Top_Store,
	bs.Top_Store_Revenue_USD,
	bs.Top_Store_Country,
	bco.Top_Country,
	bco.Top_Country_Revenue_USD,
	bsc.Top_Sales_Channel,
	bsc.Top_Sales_Channel_Revenue_USD,
	lm.Total_Revenue_USD AS Latest_Month_Revenue_USD,
	lm.Previous_Month_Revenue_USD,
	lm.Previous_Year_Revenue_USD,
	(lm.Total_Revenue_USD - lm.Previous_Month_Revenue_USD) / NULLIF(lm.Previous_Month_Revenue_USD,0) * 100.0 AS Latest_Month_Growth_Percent,
	(lm.Total_Revenue_USD - lm.Previous_Year_Revenue_USD) / NULLIF(lm.Previous_Year_Revenue_USD,0) * 100.0 AS Latest_Month_YoY_Growth_Percent
FROM basic_KPI b
CROSS JOIN best_category bca
CROSS JOIN best_product bp
CROSS JOIN best_store bs
CROSS JOIN best_country bco
CROSS JOIN best_sales_channel bsc
CROSS JOIN latest_month lm
WHERE Ranking = 1;