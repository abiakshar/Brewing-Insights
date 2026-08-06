# ☕ Brewing Insights: End-to-End Coffee Shop Data Analytics

![SQL](https://img.shields.io/badge/MSSQL-00468D?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Data Analysis](https://img.shields.io/badge/Data_Analysis-Transform_&_Visualize-success?style=for-the-badge)

## 🎯 Business Objective
The primary goal of this project is to analyze six months of retail data to **identify revenue growth levers, optimize Average Order Value (AOV), and streamline staffing across all locations**. By transitioning raw transactional data into dynamic dashboards, this project provides actionable, data-driven recommendations for store managers and stakeholders.

## 📊 Dataset
*   **Total Records:** 149,116 raw transaction rows.
*   **Timeframe:** January 2023 – June 2023.
*   **Attributes:** Transaction IDs, dates/times, quantities, store locations (Astoria, Hell's Kitchen, Lower Manhattan), product categories, and unit prices.

## 🛠️ Methodology & ETL (SQL to Power BI)
This project features a robust end-to-end pipeline:

1.  **Data Ingestion & Profiling (MSSQL):** 
    *   Utilized `BULK INSERT` to load raw CSV data.
    *   Performed rigorous data quality checks, including hidden whitespace detection (`LTRIM`/`RTRIM`), regex pattern matching for invalid characters, and granularity consistency checks.
2.  **Data Cleaning & Fact Table Creation:** 
    *   Handled time sequence logic, statistical outlier detection (transactions > 4 standard deviations), and missing pattern detection.
    *   Created a structured `coffee_shop_sales_fact` table with strict constraints (`CHECK(transaction_qty > 0)`).
3.  **Exploratory Data Analysis (EDA):** 
    *   Wrote complex SQL queries utilizing Window Functions and CTEs to analyze month-over-month growth, 7-day moving averages, and market basket combinations.
4.  **Data Visualization (Power BI):** 
    *   Imported the clean fact table into Power BI to build interactive, operational dashboards targeting executive summary, top-line performance, customer spending, and staffing.

## 💡 Key Insights
*   **Revenue & Volume:** Generated **$698.81K** in total revenue across **149K orders** (214K items sold).
*   **Customer Behavior:** Single-item purchases completely dominate customer behavior, keeping the Average Order Value (AOV) stagnant at **$4.69**.
*   **Operational Bottlenecks:** The morning and mid-day rushes (specifically 8 AM - 10 AM) account for **57%** of all orders. 
*   **Store Performance:** Revenue is evenly distributed, with **Hell's Kitchen** performing slightly above the rest as the top store ($236.5K).

## 📈 Dashboard Showcase

### 1. Executive Summary
![Executive Summary](Executive%20Summary.png)

### 2. Top-Line Performance
![Top-Line Performance](Top%20Line%20Performance.png)

### 3. Customer Spending
![Customer Spending](Customer%20Behavior.png)

### 4. Staffing Optimization
![Staffing Optimization](Staffing%20Optimization.png)

## 🚀 How to Run/Replicate
1.  **Database Setup:** Execute the `CoffeeShop_ETL.sql` script in SQL Server Management Studio (SSMS) to create the database, import the CSV, and run the quality checks.
2.  **Dashboard Viewing:** Download the `Brewing_Insights_Dashboard.pbix` file.
3.  **Open in Power BI:** Open the file using Power BI Desktop to interact with the visualizations. (Ensure your data source settings point to your local SQL Server instance if you wish to refresh the data).
