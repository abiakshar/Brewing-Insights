# ☕ Brewing Insights: Operational & Revenue Optimization Analysis
![Brewing Insights Dashboard](dashboard%201.png)

## 📌 Executive Summary
An end-to-end business intelligence project analyzing **149,000+ coffee shop transactions ($698.8K revenue)** across 3 store locations. By combining **SQL-driven ETL and statistical profiling** with **Power BI visualization**, this analysis uncovered core operational bottlenecks and modeled actionable strategy shifts to increase labor efficiency and average order value (AOV).

---

## 🚀 Key Business Insights & Strategic Recommendations

| Problem Identified | Data Insight Uncovered | Actionable Recommendation |
| :--- | :--- | :--- |
| **Labor Misallocation** | **69% of total transaction volume** occurs between 6 AM and 10 AM, but shift staffing was spread evenly across 12-hour days. | **Front-load 25% more staff to the Morning Rush** to reduce order wait times and capture peak foot traffic. |
| **Low Food Attachment** | Beverage lines (Coffee & Tea) dominate **66.7% of volume**, while Bakery represents only **11.7% of sales**. | Implement a **$1 morning pastry add-on** at checkout to lift average order value ($4.68). |
| **Off-Peak OPEX Drain** | Lower Manhattan location revenue drops to **near $0 after 6 PM**, yet operating costs remain fixed. | **Reduce operating hours by 2 hours** at Lower Manhattan to trim utility and labor expenses without impacting revenue. |

---

## 🎯 Business Objectives
This analysis was engineered to answer four critical leadership questions:
1. **Resource Allocation:** How can we optimize store shift schedules based on hourly throughput?
2. **Product Strategy:** Which product categories drive volume versus margin, and where are cross-selling opportunities?
3. **Location Benchmarking:** How do store locations differ in peak-hour revenue, volume, and customer spending habits?
4. **Growth Trajectory:** What is the month-over-month (MoM) revenue trend across the first half of the year?

---

## 🛠️ Technical Architecture & Methodology
│  Raw Transaction CSVs  │ ───► │   T-SQL (SQL Server)     │ ───► │    Power BI Dashboard    │
│   (149K+ Records)      │      │  ETL, Cleaning & EDA     │      │   Interactive Reporting  │

### 1. Data Ingestion & Quality Control (SQL)
* **High-Volume Ingestion:** Used `BULK INSERT` to stage raw transaction records into SQL Server.
* **Data Sanitization:** Cleared trailing white spaces, standardized datetime schemas, and applied `CHECK` constraints (`transaction_qty > 0`, `unit_price > 0`).
* **Outlier Scrubbing:** Applied statistical profiling ($\mu \pm 4\sigma$) to identify and isolate extreme transaction anomalies before modeling.

### 2. Advanced Analytics & Modeling (SQL)
* Developed analytical views leveraging **Window Functions (`RANK()`, `LAG()`, `OVER()`)** and **CTEs**.
* Built **7-day rolling revenue averages** and evaluated Month-over-Month (MoM) growth rates.
* Conducted **Market Basket Analysis** to map basket sizes, item counts, and revenue impact across weekday vs. weekend patterns.

### 3. Dimensional Modeling & Dashboarding (Power BI)
* Designed a star schema linking transaction facts with date, product, and store dimension tables.
* Built dynamic measures using **DAX** for Peak Period classification, Price Sensitivity tracking, and hourly trend analysis.

---

## 💻 Tech Stack
* **Database Engine & ETL:** T-SQL (SQL Server)
* **Business Intelligence & Modeling:** Power BI, DAX
* **Analytical Techniques:** Statistical Outlier Detection, Rolling Averages, Market Basket Analysis, Dimensional Modeling

---

## 🗂️ Repository Structure
* **`CoffeeSalesProject_Portfolio.sql`**: Full ETL pipeline, data quality checks, staging tables, and EDA queries.
* **`Brewing_Insights - CoffeeShopSales.pbix`**: Interactive Power BI dashboard file.
* **`README.md`**: Executive summary and technical documentation.
