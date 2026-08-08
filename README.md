# ☕ Brewing Insights: End-to-End Coffee Shop Data Analytics

![SQL](https://img.shields.io/badge/MSSQL-00468D?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Data Analysis](https://img.shields.io/badge/Data_Analysis-Transform_&_Visualize-success?style=for-the-badge)

## Why I chose this project?

As someone who loves coffee and has an interest in the coffee business, I have always been curious about what happens behind the counter.

Whenever I see a busy coffee or tea shop, whether it's a local shop or a global brand, I find myself wondering:

- Why are some shops consistently flooded with customers?
- What drives their purchases?
- Which products contribute most to sales?
- How do managers handle peak-hour demand?

That curiosity became the starting point for this project.

Rather than simply building another dashboard, I wanted to use data to understand the business behind the transactions.

## 🎯 Business Questions

This analysis focuses on four key business questions:

1. **Revenue:** How are sales performing across stores, products, and months?
2. **Customer Spending:** What drives customer purchasing behavior and Average Order Value?
3. **Operations:** When does demand peak, and how can staffing be aligned with it?
4. **Growth:** Where are the biggest opportunities to increase revenue and basket size?

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

### Business Question

**How healthy is the business overall, and where are the biggest opportunities for improvement?**

### Key Insights

- Generated **$698.81K** in revenue from **149K orders**.
- Sold approximately **214K items** across three store locations.
- Average Order Value remained at **$4.69**.
- **Hell's Kitchen** generated the highest revenue at approximately **$236.5K**.
- Peak periods represent a significant share of order volume, creating a clear staffing opportunity.

### Recommended Action

- Increase basket size through **beverage + bakery bundles** and checkout cross-selling.
- Align staffing with peak demand to improve operational efficiency.
- Use high-performing product combinations to support promotional campaigns.

### 2. Top-Line Performance
![Top-Line Performance](Top%20Line%20Performance.png)

### Business Question

**How is revenue performing, and what is driving overall sales?**

### Key Insights

- Total revenue reached **$698.81K** across the six-month period.
- Revenue shows a strong upward trend from January through June.
- **Hell's Kitchen** leads the three locations with approximately **$236.5K** in revenue.
- Coffee is the strongest contributor to sales.
- Revenue is relatively balanced across the three stores, indicating no single-store dependency.

### Recommended Action

- Identify successful practices at Hell's Kitchen that could be replicated across other locations.
- Continue monitoring product and store-level trends to identify additional growth opportunities.

### 3. Customer Spending
![Customer Spending](Customer%20Behavior.png)

### Business Question

**What drives customer spending, and how can we increase basket size?**

### Key Insights

- Single-item purchases dominate customer transactions.
- Average Order Value remains stable at **$4.69**.
- Coffee and Tea dominate customer purchases.
- Weekday and weekend AOV are almost identical.
- Coffee is the most common product in both single-item and two-item purchases.

### Recommended Action

- Introduce **coffee + bakery** and **coffee + tea** bundle offers.
- Use checkout cross-selling to encourage customers to add complementary products.
- Test targeted promotions designed to move customers from one-item to multi-item purchases.
  
### 4. Staffing Optimization
![Staffing Optimization](Staffing%20Optimization.png)

### Business Question

**When do we need the most staff, and how should staffing be aligned with demand?**

### Key Insights

- Customer demand is concentrated during peak morning hours.
- Coffee represents the largest share of items sold.
- Demand patterns are relatively consistent across the three locations.
- Peak-hour demand creates an opportunity to better align employee schedules with customer volume.

### Recommended Action

- Front-load staffing during the morning rush.
- Align employee schedules with hourly demand rather than using uniform staffing levels.
- Ensure adequate coffee and other high-demand product inventory before peak periods

## 📈 Business Recommendations

Based on the analysis, the following initiatives can improve business performance:

### Increase Average Order Value
* Introduce beverage and bakery bundle offers.
* Promote checkout cross-selling.
* Launch limited-time combo promotions.
  
### Improve Operational Efficiency
* Schedule additional staff during morning peak hours.
* Align shift planning with hourly customer demand.
  
### Inventory Optimization
* Maintain higher inventory levels for high-demand products.
* Forecast stock requirements using historical sales trends.
  
### Revenue Growth
* Replicate successful sales strategies from Hell's Kitchen across other stores.
* Promote complementary products to encourage multi-item purchases.

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
* Customer Purchasing Behavior
* Product Performance
* Operational Analytics
* Staffing Optimization
* Executive Reporting

## 🎯 Executive Conclusion

The analysis indicates a stable business with balanced revenue across the three locations. The strongest opportunities are not simply in generating more transactions, but in **increasing the value of existing transactions and aligning operations with demand**.

The data points to two immediate opportunities: increase AOV through product bundling and cross-selling, and optimize staffing around peak demand periods.

## 🚀 Future Scope
This project is based on a publicly available **U.S. coffee shop sales dataset** and served as a foundation for applying SQL Server and Power BI to real-world business questions.

As a next step, I want to apply the same analytical approach to **Indian coffee and tea shop data**. Customer preferences, purchasing behavior, pricing, and operational challenges can differ significantly across markets.

My goal is to explore these differences using local data and develop insights that can support better decisions for Indian coffee and tea businesses.


