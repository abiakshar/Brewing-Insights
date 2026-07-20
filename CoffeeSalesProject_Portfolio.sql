
/* =============================================================================
   COFFEE SHOP SALES: END-TO-END DATA ANALYSIS PROJECT
   =============================================================================
   This script covers the entire ETL and Analysis process:
   1. Data Ingestion
   2. Data Quality Assessment & Profiling
   3. Data Quality Summary
   4. Data Cleaning & Fact Table creation
   5. Exploratory Data Analysis (EDA) & Business Insights */

/* ==================================
   1. SETUP & DATA INGESTION
   ================================== */

CREATE TABLE coffee_shop_sales(
transaction_id INT,
transaction_date VARCHAR(50),
transaction_time VARCHAR(50),
transaction_qty INT,
store_id INT,
store_location VARCHAR(50),
product_id INT,
unit_price DECIMAL(10,2),
product_category VARCHAR(50),
product_type VARCHAR(100),
product_detail VARCHAR(150)
);

BULK INSERT coffee_shop_sales
FROM 'C:\Temp\Coffee Shop Sales.csv'
WITH(
	FIRSTROW =2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n',
	TABLOCK
);
 
/* ======================================
   2. DATA VALIDATION & PROFILING
   ====================================== */

-- A) DETECT HIDDEN SPACES IN TEXT COLUMNS
-- CHECK TEXT COLUMN CLEANLINESS 
-- WHITESPACE NORMALIZATION / TEXT STANDARDIZATION
-- LEADING/TRAILING SPACES

SELECT * FROM coffee_shop_sales
WHERE store_location <> LTRIM(rtrim(store_location));

SELECT * FROM coffee_shop_sales
WHERE product_category <> LTRIM(rtrim(product_category));

SELECT * FROM coffee_shop_sales
WHERE product_type <> LTRIM(rtrim(product_type));

SELECT * FROM coffee_shop_sales
WHERE product_detail <> LTRIM(rtrim(product_detail));


-- B) PATTERN CHECK (Detect strange characters in text columns)
SELECT * FROM coffee_shop_sales
WHERE product_category LIKE '%[^A-Za-z ]%';

SELECT * FROM coffee_shop_sales
WHERE product_type LIKE '%[^A-Za-z ]%';

SELECT * FROM coffee_shop_sales
WHERE product_detail LIKE '%[^A-Za-z ''!-]%';

SELECT * FROM coffee_shop_sales
WHERE store_location LIKE '%[^A-Za-z'' -]%';

-- C) CHECK GRANULARITY CONSISTENCY: Ensure one transaction doesn't map to multiple stores 
SELECT transaction_id, COUNT(DISTINCT CONCAT(product_id, '|', store_id)) [variations]
FROM coffee_shop_sales
GROUP BY transaction_id
HAVING COUNT(DISTINCT CONCAT(product_id, '|', store_id)) > 1;

-- D). TIME SEQUENCE LOGIC: Flag transactions spanning more than 60 minutes
SELECT transaction_id, transaction_date,
    MIN(TRY_CONVERT(TIME, transaction_time)) [min_time],
    MAX(TRY_CONVERT(TIME, transaction_time)) [max_time]
FROM coffee_shop_sales
GROUP BY transaction_id, transaction_date
HAVING DATEDIFF(MINUTE, 
    MIN(TRY_CONVERT(TIME, transaction_time)),
    MAX(TRY_CONVERT(TIME, transaction_time))) > 60;

-- E) CHECK FOR FULL-ROW DUPLICATES (Window Function Approach)
SELECT * FROM
    (SELECT *, COUNT(*) OVER(
        PARTITION BY transaction_id,
        transaction_date,
        transaction_time,
        transaction_qty,
        store_id,
        store_location,
        product_id,
        unit_price,
        product_category,
        product_type,
        product_detail) [duplicate_count]
    FROM coffee_shop_sales) t
WHERE duplicate_count > 1;

-- F) STATISTICAL OUTLIER DETECTION (Standard Deviation)
SELECT AVG(transaction_qty) [avg_qty],
    STDEV(transaction_qty) [std_dev_qty]
FROM coffee_shop_sales;

-- Identify specific transactions that exceed 4 standard deviations
SELECT * FROM coffee_shop_sales
WHERE transaction_qty >
    (
    SELECT AVG(transaction_qty) + 4 * STDEV(transaction_qty)
    FROM coffee_shop_sales
    );

-- G) MISSING PATTERN DETECTION
-- Find if any hour (0-23) has no transactions in the dataset.
WITH hours AS (
    SELECT 0 AS h
    UNION ALL 
    SELECT h + 1 FROM hours WHERE h < 23
)
SELECT h FROM hours
WHERE h NOT IN (
    SELECT DISTINCT DATEPART(HOUR, TRY_CONVERT(TIME, transaction_time))
    FROM coffee_shop_sales
);

/* =============================== 
   3. DATA QUALITY SUMMARY 
   =============================== */

SELECT 'Total Records' AS Check_name, COUNT(*) AS Result FROM coffee_shop_sales
UNION ALL
SELECT 'Duplicate Transactions', COUNT(*) FROM 
(
 SELECT transaction_id FROM coffee_shop_sales
 GROUP BY transaction_id
 HAVING COUNT(*) > 1
) t
UNION ALL
SELECT 'Invalid Quantity' , COUNT(*) FROM coffee_shop_sales
WHERE transaction_qty <=0
UNION ALL
SELECT 'Invalid Unit Price', COUNT(*) FROM coffee_shop_sales
WHERE unit_price <=0
UNION ALL
SELECT 'Invalid Date', COUNT(*) FROM coffee_shop_sales
WHERE TRY_CONVERT(DATE, transaction_date, 105) IS NULL
UNION ALL
SELECT 'Invalid Time', COUNT(*) FROM coffee_shop_sales
WHERE TRY_CONVERT(TIME, transaction_time) IS NULL
UNION ALL
SELECT 'Null Critical Fields', COUNT(*) FROM coffee_shop_sales
WHERE transaction_id IS NULL
OR transaction_qty IS NULL
OR store_id IS NULL
OR product_id IS NULL
OR unit_price IS NULL
UNION ALL
SELECT 'Product Mapping Issues', COUNT(*) FROM
(
SELECT product_id FROM coffee_shop_sales
GROUP BY product_id
HAVING COUNT(DISTINCT CONCAT(product_category, '|', product_type, '|', product_detail))>1
) t
UNION ALL
SELECT 'Store Mapping Issues', COUNT(*) FROM
(
SELECT store_id FROM coffee_shop_sales
GROUP BY store_id
HAVING COUNT(DISTINCT store_location) > 1
) t
UNION ALL
SELECT 'High Value Transactions (>200)', COUNT(*) FROM
(
SELECT transaction_id FROM coffee_shop_sales
GROUP BY transaction_id
HAVING SUM(transaction_qty * unit_price) > 200
) t


/*
========================
DATA QUALITY SUMMARY 
========================
Total Records: 149116
High Value Transactions (>200) : 10
Invalid Quantity: 0
Negative Prices: 0
Invalid Dates: 0
Invalied Time: 0
Duplicate Transactions: 0
Null Critical Fields : 0
Product Mapping Issues: 0
Store Mapping Issues: 0

STATUS: Data has passed quality checks. Ready for Transformation
*/

/* ==========================================
   4. FACT TABLE CREATION (DATA CLEANING)
   ========================================== */

CREATE TABLE coffee_shop_sales_fact(
    transaction_id INT,
    transaction_date DATE,
    transaction_time TIME,
    sales_hour INT,
    transaction_qty INT,
    store_id INT,
    store_location VARCHAR(50),
    product_id INT,
    unit_price DECIMAL(10,2),
    product_category VARCHAR(50),
    product_type VARCHAR(100),
    product_detail VARCHAR(150),
    revenue DECIMAL(10,2)
);

INSERT INTO coffee_shop_sales_fact
SELECT
    transaction_id,
    TRY_CONVERT(DATE, transaction_date, 105) [transaction_date],
    TRY_CONVERT(TIME(0), LTRIM(RTRIM(LEFT(transaction_time, 8)))) [transaction_time],
    DATEPART(HOUR, TRY_CONVERT(TIME(0), LTRIM(RTRIM(LEFT(transaction_time, 8))))) [sales_hour],
    transaction_qty,
    store_id,
    LTRIM(RTRIM(store_location)) [store_location],
    product_id,
    unit_price,
    LTRIM(RTRIM(product_category)) [product_category],
    LTRIM(RTRIM(product_type)) [product_type],
    LTRIM(RTRIM(product_detail)) [product_detail],
    transaction_qty * unit_price [revenue]
FROM coffee_shop_sales
WHERE
    TRY_CONVERT(DATE, transaction_date, 105) IS NOT NULL
    AND TRY_CONVERT(TIME(0), LTRIM(RTRIM(LEFT(transaction_time, 8)))) IS NOT NULL
    AND transaction_qty > 0
    AND unit_price > 0
    AND (transaction_qty * unit_price) > 0;

SELECT TOP 10 * FROM coffee_shop_sales_fact

-- COMPARE RAW TABLE AND FACT TABLE ROW COUNTS

SELECT COUNT(*) [raw_count] FROM coffee_shop_sales;
SELECT COUNT(*) [fact_count] FROM coffee_shop_sales_fact;

--ADD CONSTRAINTS

ALTER TABLE coffee_shop_sales_fact
ADD CONSTRAINT chk_qty CHECK(transaction_qty > 0);

ALTER TABLE coffee_shop_sales_fact
ADD CONSTRAINT chk_price CHECK(unit_price > 0);


/* =================================
   5. EXPLORATORY DATA ANALYSIS
   ================================= */
   
-- A) High-Level KPIs (Revenue, Transactions, Quantity)
SELECT 
	SUM(revenue) [total_revenue],
	COUNT(DISTINCT transaction_id) [total_transaction],
	SUM(transaction_qty) [total_quantity_sold]
FROM coffee_shop_sales_fact;

-- B) Peak Hours Analysis (For Staffing Optimization)
/* Identify busiest times: at which hour the coffee shop get the most customers? */
SELECT sales_hour, COUNT(DISTINCT transaction_id) [total_transactions], SUM(revenue) [revenue]
FROM coffee_shop_sales_fact
GROUP BY sales_hour
ORDER BY revenue DESC;

-- C) Sales by Date (Identify Trend)
SELECT 
    MONTH(transaction_date) [month],
    DATEPART(WEEK, transaction_date) [week_no],
    SUM(revenue) [revenue]
FROM coffee_shop_sales_fact
GROUP BY YEAR(transaction_date), MONTH(transaction_date), DATEPART(WEEK, transaction_date)
ORDER BY month, week_no;

--D) Day of Week Analysis
SELECT 
	DATENAME(WEEKDAY, transaction_date) [Days],
	SUM(revenue) [Total_Revenue]
FROM coffee_shop_sales_fact
GROUP BY DATENAME(WEEKDAY, transaction_date),
         DATEPART(WEEKDAY, transaction_date)
ORDER BY DATEPART(WEEKDAY, transaction_date);

-- E) 7-Day Moving Average for Revenue
SELECT 
    transaction_date,
    SUM(revenue) [daily_revenue],
    AVG(SUM(revenue)) OVER (
        ORDER BY transaction_date
        ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
    ) [moving_avg_7_days]
FROM coffee_shop_sales_fact
GROUP BY transaction_date
ORDER BY transaction_date;

-- F) Store Performance Matrix
SELECT store_location, SUM(revenue) [revenue],
    COUNT(DISTINCT transaction_id) [transactions],
    SUM(revenue)*1.0/COUNT(DISTINCT transaction_id) [avg_order_value]
FROM coffee_shop_sales_fact
GROUP BY store_location
ORDER BY revenue DESC;

-- G) Product Analysis
-- Top Products and category
SELECT TOP 10 product_type, product_category, SUM(revenue) [revenue]
FROM coffee_shop_sales_fact
GROUP BY product_type, product_category
ORDER BY revenue DESC;

-- Best Selling Items by Quantity (Overall Popularity)
SELECT TOP 10 product_type, product_detail, SUM(transaction_qty) [total_qty]
FROM coffee_shop_sales_fact
GROUP BY product_type, product_detail
ORDER BY total_qty DESC;

-- Overall Top 3 Products Between 6 AM and  10 AM (Morning Rush)
SELECT TOP 3 product_type, SUM(transaction_qty) [count]
FROM coffee_shop_sales_fact
WHERE sales_hour BETWEEN 6 AND 10
GROUP BY product_type
ORDER BY count DESC;

-- Top 3 products for Each Morning Hour (Window Function)
WITH ranked_products AS (
    SELECT sales_hour, product_type, SUM(transaction_qty) [total_units_sold],
        RANK() OVER(PARTITION BY sales_hour ORDER BY SUM(transaction_qty) DESC) AS rnk
    FROM coffee_shop_sales_fact
    WHERE sales_hour BETWEEN 6 AND 10
    GROUP BY sales_hour, product_type
)
SELECT * FROM ranked_products
WHERE rnk <= 3;

-- Peak Period (Morning Rush & Evening Peak)
SELECT
	CASE
		WHEN sales_hour BETWEEN 6 AND 10 THEN 'Morning Rush'
		WHEN sales_hour BETWEEN 16 AND 20 THEN 'Evening Peak'
		ELSE 'Other'
	END AS [Peak Period],
	sales_hour, product_category, SUM(transaction_qty) [total_units_sold]
FROM coffee_shop_sales_fact
WHERE sales_hour BETWEEN 6 AND 10 OR sales_hour BETWEEN 16 AND 20
GROUP BY sales_hour, product_category,
	CASE
		WHEN sales_hour BETWEEN 6 AND 10 THEN 'Morning Rush'
		WHEN sales_hour BETWEEN 16 AND 20 THEN 'Evening Peak'
	END
ORDER BY sales_hour;

-- H) Revenue Insights
-- Average Order Value
SELECT SUM(revenue)/COUNT(DISTINCT transaction_id) [avg_order_value]
FROM coffee_shop_sales_fact;

-- Revenue & Contribution% per Product Category
SELECT product_category, 
    MIN(unit_price) [min_price],
    MAX(unit_price) [max_price],
    CAST(AVG(unit_price) AS DECIMAL(10,2)) [avg_price],
    CAST(ROUND(SUM(revenue), 0) AS INT) [total_revenue],
	CAST(SUM(revenue)*100.0/(SELECT SUM(revenue) FROM coffee_shop_sales_fact) AS DECIMAL(10,2)) [Contribution %]

FROM coffee_shop_sales_fact
GROUP BY product_category
ORDER BY total_revenue DESC;

-- I) Transaction Analysis
-- Market Based Analysis (Items & Value per Transaction)
SELECT transaction_id, SUM(transaction_qty) [total_items], SUM(revenue) [total_bill]
FROM coffee_shop_sales_fact
GROUP BY transaction_id
ORDER BY total_items DESC;

-- Average Items per Transaction
SELECT CAST(SUM(transaction_qty)*1.0/COUNT(DISTINCT transaction_id) AS DECIMAL(10,2)) [avg_items_per_txn]
FROM coffee_shop_sales_fact;

-- J) Distribution Analysis (Most Common Purchase Size)
SELECT transaction_qty, COUNT(*) [frequency]
FROM coffee_shop_sales_fact
GROUP BY transaction_qty
ORDER BY transaction_qty;

-- K) Store Performance Matrix

WITH store_metrics AS(
	SELECT store_location, sales_hour, SUM(revenue) [hour_revenue],
	RANK() OVER(PARTITION BY store_location ORDER BY SUM(revenue) DESC) AS hour_rank
FROM coffee_shop_sales_fact
GROUP BY store_location, sales_hour
),
product_metrics AS(
	SELECT store_location, product_category, SUM(revenue) [category_revenue],
	RANK() over(PARTITION BY store_location ORDER BY SUM(revenue) DESC) AS prod_rank
FROM coffee_shop_sales_fact
GROUP BY store_location, product_category
)

SELECT
s.store_location,
s.sales_hour [peak_hour],
s.hour_revenue [peak_hour_revenue],
p.product_category  [top_product_category],
p.category_revenue [top_category_revenue]
FROM store_metrics s
JOIN product_metrics p 
ON S.store_location = p.store_location
WHERE s.hour_rank =1 AND P.prod_rank =1;

-- L) Growth Analysis (Month-over-Month Growth)
WITH monthly_growth AS (
    SELECT YEAR(transaction_date) [year],
        MONTH(transaction_date) [month],
        SUM(revenue) [revenue]
    FROM coffee_shop_sales_fact
    GROUP BY YEAR(transaction_date), MONTH(transaction_date)
)
SELECT *,
    LAG(revenue) OVER(ORDER BY year, month) [prev_month_revenue],
    CAST((revenue - LAG(revenue) OVER(ORDER BY year, month))*100.0 / 
    LAG(revenue) OVER(ORDER BY year, month) AS DECIMAL(10,2)) [growth_pct]
FROM monthly_growth;

-- M) Weekday vs. Weekend Analysis (When do people buy)
SELECT
    CASE WHEN DATENAME(WEEKDAY, transaction_date) IN ('Saturday','Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END [day_type],
    SUM(revenue) [total_revenue],
    COUNT(DISTINCT transaction_id) [total_orders],
	CAST(SUM(revenue)*1.0/COUNT(DISTINCT transaction_id) AS DECIMAL(10,2)) [avg_order_value] 
FROM coffee_shop_sales_fact
GROUP BY
    CASE WHEN DATENAME(WEEKDAY, transaction_date) IN ('Saturday','Sunday')
        THEN 'Weekend'
        ELSE 'Weekday'
    END;
 
-- N) Price Sensitivity (How does price affect volume)
SELECT product_type, unit_price, SUM(transaction_qty) [quantity_sold], SUM(revenue) [total_revenue]
FROM coffee_shop_sales_fact
GROUP BY product_type, unit_price
ORDER BY product_type, unit_price ASC;

select distinct product_type from coffee_shop_sales_fact
order by product_type