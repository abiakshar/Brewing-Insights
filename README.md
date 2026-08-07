# ☕ Brewing Insights: End-to-End Coffee Shop Data Analytics

![SQL](https://img.shields.io/badge/MSSQL-00468D?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Data Analysis](https://img.shields.io/badge/Data_Analysis-Transform_&_Visualize-success?style=for-the-badge)

## 🎯 Business Objective
An end-to-end SQL Server and Power BI analytics project that transforms six months of retail transaction data into actionable business insights for revenue growth, customer behavior, and operational optimization.

The objective of this project is to help business stakeholders:

* Increase revenue
* Improve Average Order Value (AOV)
* Understand customer purchasing behavior
* Optimize staffing during peak hours
* Support data-driven operational decisions

## 📌 Project Overview

Coffee shops generate thousands of transactions every day, but raw sales data alone cannot answer critical business questions such as:

* Which store generates the highest revenue?
* What products drive profitability?
* When should managers schedule more staff?
* Why is Average Order Value (AOV) not increasing?
* Which business strategies can improve sales?

This project converts 149,116 raw transactions into interactive Power BI dashboards using SQL Server for data ingestion, cleaning, profiling, and exploratory analysis.

## 📊 Dataset

| Attribute | Details |
|-----------|---------|
| **Source** | Maven Analytics Coffee Shop Sales Dataset |
| **Duration** | January 2023 – June 2023 |
| **Records** | 149,116 Transactions |
| **Stores** | Astoria, Hell's Kitchen, Lower Manhattan |
| **Products** | Coffee, Tea, Bakery, Drinking Chocolate, Flavors, Others |

## 🛠 Technology Stack

| Category | Technology|
|----------|-----------|
| Database | SQL Server |
| Data Cleaning	| SQL |
| Data Visualization |	Power BI |
| Data Modeling	| Power BI |
| Calculations | DAX |
| Version Control |	Git & GitHub |

## 🔄 Project Workflow
```
Raw CSV Dataset
        │
        ▼
SQL Server
(Data Loading)
        │
        ▼
Data Cleaning & Validation
        │
        ▼
Exploratory Data Analysis
        │
        ▼
Fact Table Creation
        │
        ▼
Power BI Dashboard
        │
        ▼
Business Insights
        │
        ▼
Strategic Recommendations
```
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

## 📈 Dashboard Showcase

### 1. Executive Summary
![Executive Summary](Executive%20Summary.png)

### Purpose

Provides an executive-level overview of business performance, highlighting revenue, customer spending, operational health, and strategic opportunities.

### Key Insights
* Generated $698.81K in revenue from 149K orders.
* Sold 214K items across three store locations.
* Average Order Value remained stable at $4.69.
* Hell's Kitchen emerged as the top-performing store.
* Morning and mid-day periods contribute 57% of total orders.

### Business Value

This dashboard enables executives to quickly assess business health, identify operational bottlenecks, and prioritize revenue growth initiatives.

### 2. Top-Line Performance
![Top-Line Performance](Top%20Line%20Performance.png)

### Purpose

Monitors overall business performance by tracking revenue, order volume, store performance, profitability, and monthly growth trends.

### Key Insights
* Revenue steadily increased throughout the six-month period.
* Hell's Kitchen generated the highest revenue among all locations.
* Coffee remains the primary revenue driver.
* Monthly sales show consistent positive growth.

### Business Value

Helps management evaluate financial performance, compare store profitability, and monitor revenue trends over time.

### 3. Customer Spending
![Customer Spending](Customer%20Behavior.png)

### Purpose

Analyzes purchasing behavior to understand buying patterns, peak shopping hours, product preferences, and opportunities to increase customer spending.

### Key Insights

* Single-item purchases dominate customer behavior.
* Weekday and weekend Average Order Value remain nearly identical.
* Coffee and Tea account for the majority of customer purchases.
* Morning rush contributes significantly to total daily orders.
* Most two-item purchases involve Coffee combined with Tea.

### Business Value

Supports cross-selling strategies, bundle creation, promotional planning, and customer segmentation to improve Average Order Value.

### 4. Staffing Optimization
![Staffing Optimization](Staffing%20Optimization.png)

### Purpose

Identifies peak demand periods and staffing requirements to improve operational efficiency and customer experience.

### Key Insights
* Peak demand consistently occurs between 8 AM and 10 AM.
* Coffee products require the greatest operational focus.
* Staffing demand remains highest during morning and mid-day periods.
* Demand patterns are consistent across all three store locations.

### Business Value

Enables managers to optimize employee scheduling, reduce wait times, improve service quality, and maintain adequate inventory during peak hours.

## 📈 Business Recommendations

Based on the analysis, the following initiatives can improve business performance:

## Increase Average Order Value
* Introduce beverage and bakery bundle offers.
* Promote checkout cross-selling.
* Launch limited-time combo promotions.
## Improve Operational Efficiency
* Schedule additional staff during morning peak hours.
* Align shift planning with hourly customer demand.
## Inventory Optimization
* Maintain higher inventory levels for high-demand products.
* Forecast stock requirements using historical sales trends.
## Revenue Growth
* Replicate successful sales strategies from Hell's Kitchen across other stores.
* Promote complementary products to encourage multi-item purchases.

##💡 Key Insights

*   **Revenue & Volume:** Generated **$698.81K** in total revenue across **149K orders** (214K items sold).
*   **Customer Behavior:** Single-item purchases completely dominate customer behavior, keeping the Average Order Value (AOV) stagnant at **$4.69**.
*   **Operational Bottlenecks:** The morning and mid-day rushes (specifically 8 AM - 10 AM) account for **57%** of all orders. 
*   **Store Performance:** Revenue is evenly distributed, with **Hell's Kitchen** performing slightly above the rest as the top store ($236.5K).


## 🚀 Skills Demonstrated

### SQL

* Data Cleaning
* Data Validation
* Window Functions
* CTEs
* Aggregate Functions
* Ranking Functions
* Business Analysis
* Query Optimization

### Power BI

* Data Modeling
* DAX Measures
* KPI Cards
* Interactive Slicers
* Custom Tooltips
* Business Storytelling
* Executive Dashboard Design
  
### Business Analytics

* Revenue Analysis
* Customer Segmentation
* Product Performance
* Operational Analytics
* Staffing Optimization
* Executive Reporting

## 🎯 Executive Conclusion

The analysis demonstrates a healthy and stable business with balanced revenue distribution across all stores. While overall sales performance is strong, significant opportunities exist to increase Average Order Value through product bundling, optimize staffing during peak demand hours, and improve operational efficiency using data-driven decision-making.

## 🚀 Future Scope

This project marks the beginning of my journey into retail and business analytics. As someone who is genuinely interested in the coffee business, my next goal is to apply the same analytical approach to Indian coffee and tea shop data. I hope to explore how customer behavior, product preferences, and operational challenges differ from the U.S. market and develop insights that can support better business decisions for local businesses.


