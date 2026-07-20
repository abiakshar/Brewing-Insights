# ☕ Brewing Insights: End-to-End Coffee Shop Sales Analysis
![Brewing Insights Dashboard](dashboard%201.png)
## 📌 Project Overview
**Brewing Insights** is an end-to-end data analysis of a coffee shop's sales operations. The goal of this project is to transform raw transactional data into actionable business intelligence to help optimize staffing, inventory management, and product strategy. 

The project demonstrates a complete ETL (Extract, Transform, Load) and analytical workflow, utilizing **SQL** for robust data ingestion, cleaning, and exploratory data analysis (EDA), and **Power BI** for dimensional modeling and interactive data visualization.

## 🗂️ Repository Structure
* **`CoffeeSalesProject_Portfolio.sql`**: The complete SQL script containing data ingestion, validation, quality checks, fact table creation, and advanced EDA queries.
* **`Brewing_Insights - CoffeeShopSales.pbix`**: The interactive Power BI dashboard file showcasing high-level KPIs, trends, and store performance matrices.
* **`README.md`**: Project documentation and methodology (this file).

## 🎯 Business Objectives
The analysis was designed to answer the following core business questions:
1. **Operational Efficiency:** When are the peak sales hours, and how can we optimize staff scheduling (e.g., Morning Rush vs. Evening Peak)?
2. **Product Strategy:** Which product categories drive the most revenue, and what are the best-selling items by volume?
3. **Location Performance:** How do different store locations compare in terms of transaction volume, peak hour revenue, and average order value?
4. **Sales Trends:** What are the day-of-week purchasing patterns, and how is the business growing month-over-month?

## 🛠️ Technical Workflow & Methodology

### 1. Data Ingestion & Quality Assessment (SQL)
* **Ingestion:** Used `BULK INSERT` to load raw CSV transaction data into a staging table.
* **Data Profiling:** Conducted thorough checks to detect hidden spaces, validate text patterns, ensure granularity consistency, and map time-sequence logic. 
* **Outlier Detection:** Utilized Standard Deviation to detect and isolate statistical outliers (transactions exceeding 4 standard deviations).

### 2. Data Transformation (SQL)
* Cleaned and cast data types to create a structured `coffee_shop_sales_fact` table.
* Applied `CHECK` constraints to enforce data integrity (e.g., `transaction_qty > 0`, `unit_price > 0`).

### 3. Exploratory Data Analysis (SQL)
Leveraged advanced SQL techniques including Window Functions (`RANK()`, `LAG()`, `OVER()`), aggregations, and CTEs to extract insights:
* Calculated 7-day moving averages for revenue.
* Performed Market Basket Analysis to determine the average items and value per transaction.
* Tracked month-over-month (MoM) revenue growth percentages.

### 4. Data Visualization (Power BI)
* Imported the cleaned SQL views/tables into Power BI.
* Built the **Brewing Insights** interactive dashboard, allowing stakeholders to filter by store location, product category, and specific date/time ranges to dynamically explore performance.

## 💡 Key Business Findings
* **Targeted Staffing:** Identified a distinct "Morning Rush" (6 AM - 10 AM) and "Evening Peak" (4 PM - 8 PM). This data allows management to align shift schedules with high-volume periods, reducing wait times and optimizing labor costs.
* **Product Insights:** Mapped out price sensitivity and overall popularity. Certain morning hours have highly specific top-3 product demands, which can streamline inventory prep.
* **Growth & Performance:** The month-over-month growth analysis and store performance matrix provide a clear baseline for evaluating individual store health and identifying locations that need strategic intervention.

## 💻 Tech Stack
* **Database Management & Analysis:** T-SQL (SQL Server)
* **Data Visualization & Modeling:** Power BI
* **Core Skills:** ETL, Data Cleaning, Statistical Outlier Detection, Window Functions, Dimensional Modeling, Business Intelligence.
