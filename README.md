# ☕ Brewing Insights: End-to-End Coffee Shop Data Analytics
[![Live Demo](https://img.shields.io/badge/Streamlit-Live_App-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)](https://your-new-link.streamlit.app)

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Streamlit](https://img.shields.io/badge/Streamlit-FF4B4B?style=for-the-badge&logo=streamlit&logoColor=white)
![Snowflake](https://img.shields.io/badge/Snowflake-29B5E8?style=for-the-badge&logo=snowflake&logoColor=white)
![Gemini AI](https://img.shields.io/badge/Gemini_AI-8E75B2?style=for-the-badge&logo=googlebard&logoColor=white)
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

| **Attribute** | **Details** |
|-----------|---------|
| **Source** | Maven Analytics Coffee Shop Sales Dataset |
| **Duration** | January 2023 – June 2023 |
| **Records** | 149,116 Transactions |
| **Stores** | Astoria, Hell's Kitchen, Lower Manhattan |
| **Products** | Coffee, Tea, Bakery, Drinking Chocolate, Flavors, Others |

## 🛠 Technology Stack

| **Category** | **Technology**|
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
- Peak periods represent a significant share of overall order volume, creating a clear staffing opportunity.
- **Drinking Chocolate** and **Flavors** yield high-profit margins.

### 2. Top-Line Performance
![Top-Line Performance](Top%20Line%20Performance.png)

### Business Question

**How is revenue performing, and what is driving overall sales?**

### Key Insights

- Total revenue reached **$698.81K** across the six-month period.
- Revenue shows a strong upward trend from January through June.
- Average Order Value remains stable at **$4.69**.
- **Hell's Kitchen** leads the three locations with approximately **$236.5K** in revenue.
- Coffee and Tea are the strongest contributors to sales followed by Bakery and Dinking Chocolate.
- Revenue is relatively balanced across the three stores, indicating no single-store dependency.

### Recommended Action

- Capitalize on the strong upward trend from Jan–June by running targeted promotions for high-margin categories like **Drinking Chocolate** and **Flavors**.
- Audit **Hell's Kitchen’s** local marketing and product mix to identify successful strategies that can be replicated across Astoria and Lower Manhattan.

### 3. Customer Spending
![Customer Spending](Customer%20Behavior.png)

### Business Question

**What drives customer spending, and how can we increase basket size?**

### Key Insights

- Coffee and Tea dominate customer purchases.
- Weekday and weekend AOV are almost identical.
- Coffee is the most common product in both single-item and two-item purchases.
- While single item purchase dominate the overall store sales, isolating the "flavors" category reveals a behavioral inversion.

### Recommended Action

- Introduce **coffee + bakery** and **coffee + tea** bundle offers.
- Use checkout cross-selling to encourage customers to add complementary products.
- Test targeted promotions designed to move customers from one-item to multi-item purchases by introducing **Family Bundling**
  
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
- Align employee schedules with hourly demand rather than utilizing uniform staffing levels.
- Ensure adequate inventory for coffee and other high-demand products before peak periods.

## 📈 Business Recommendations

### 1. Increase Average Order Value
Move customers from single-item purchases toward multi-item baskets through **beverage + bakery** bundles and checkout cross-selling like add **flavors** to their coffee. Promote high-margin (60%) Drinking Chocolate during evening hours.
Additionally, maximize revenue per transaction by  encouraging customers to buy high price categories.

### 2. Optimize Peak-Hour Staffing
Align employee schedules with hourly demand, particularly during the morning rush, to improve service efficiency, maximize throughput, and reduce potential wait times.

### 3. Strengthen Inventory Planning
Prioritize inventory availability for high-demand categories like Coffee and Tea, before peak operating periods.

### 4. Replicate Store-Level Success
Analyze the practices contributing to Hell's Kitchen's slightly higher revenue and evaluate whether they can be applied across other locations.

## 🚀 Skills Demonstrated

### SQL

* Data Cleaning
* Data Validation
* Window Functions
* CTEs
* Aggregate Functions
* Ranking Functions
* Business Analysis
  
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

## 📚 Data Dictionary & System Limitations
Metric Definitions & Formulas

Revenue: Calculated as transaction_qty multiplied by unit_price.

Total Revenue: The sum of all Revenue across a specified period or category.

Transaction Count: The number of unique transaction_ids (not the total number of items sold).

Average Order Value (AOV): Calculated as Total Revenue divided by Transaction Count.

Items Sold / Volume: The sum of transaction_qty.

Peak Hours (Morning Rush): Defined operationally as transactions occurring between 7:00 AM and 10:00 AM.

### Categorical Dimensions

Locations: Data is restricted to exactly three stores: Astoria, Hell's Kitchen, and Lower Manhattan.

Product Categories: Items are strictly grouped into Coffee, Tea, Bakery, Drinking Chocolate, Flavors, and Others.

### Data Limitations (Out of Scope)

Timeframe Restriction: The dataset strictly covers January 1, 2023, through June 30, 2023. Any requests for data outside this window (e.g., Q3, Q4, or 2024) cannot be answered.

### No Customer Identifiers: 

This dataset contains completely anonymized transactions. There are no customer names, emails, loyalty IDs, or account numbers.

### No Retention Metrics: 

Because there are no unique customer IDs, it is impossible to calculate customer retention, churn rates, repeat purchase rates, or unique customer counts.

### Market Scope: 

The current data reflects the U.S. market (New York). Indian market data is part of the future scope and is not currently available for query.

## 🚀 Phase 2: AI-Powered Analytics Assistant (Streamlit + LLM)

To make the data accessible via natural language, I engineered an AI Assistant that dynamically routes queries between a relational database and unstructured text documentation.

### System Architecture
* **The Intent Router:** Uses Google Gemini to analyze user prompts and route quantitative queries to Snowflake and qualitative policy questions to a local Knowledge Base.
* **Text-to-SQL Engine:** Translates natural language into Snowflake T-SQL, automatically applying strict schema constraints, formatting `VARCHAR` dates (e.g., `TO_DATE`), and enforcing a `LIMIT 5` executive summary rule for trend analysis.
* **Document RAG Engine:** Retrieves answers regarding store policies and dataset boundaries directly from Markdown documentation without requiring a database connection.
* **Interactive UI:** Built a custom Streamlit web interface with a coffee-themed layout that automatically visualizes SQL outputs into bar charts for instant managerial insights.

### Technical Challenges Overcome
* **Data Type Handling:** Resolved implicit conversion errors in Snowflake by embedding strict date-casting rules (`DAYNAME`, `TO_DATE`) directly into the LLM's semantic context window.
* **Non-Deterministic AI Routing:** Prevented the LLM from hallucinating routing decisions (e.g., sending staffing queries to the RAG engine) by refining the prompt architecture to strictly map operational demand keywords to the SQL executor.


