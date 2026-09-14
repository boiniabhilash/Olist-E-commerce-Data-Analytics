# Olist E-Commerce Data Analytics

## End-to-End Data Analytics Portfolio Project

An end-to-end e-commerce analytics project using the **Olist dataset** to analyze business performance through multiple data analytics tools.

The same business dataset is analyzed using different tools, with each stage focusing on a different analytical skill.

---

## Project Roadmap

| Stage | Tool        | Focus                                                       | Status      |
| ----- | ----------- | ----------------------------------------------------------- | ----------- |
| 1     | Excel       | Data cleaning, PivotTables, business analysis and dashboard | ✅ Completed |
| 2     | SQL / MySQL | Business analysis, advanced SQL and data quality analysis   | ✅ Completed |
| 3     | Power BI    | Data modeling, DAX and interactive dashboard                | 🔜 Next     |
| 4     | Python      | Exploratory data analysis and visualization                 | 🔜 Planned  |

---

## Business Domain

**E-Commerce**

The analysis focuses on:

* Orders
* Products
* Sellers
* Payments
* Sales performance
* Delivery performance
* Data quality

---

## Tools Used

* Microsoft Excel
* MySQL / SQL
* Power BI
* Python

---

# Excel Analysis

The Olist dataset was initially analyzed using Excel.

### Excel skills demonstrated

* Data cleaning
* Data preparation
* PivotTables
* Business analysis
* Delivery performance analysis
* Customer state analysis
* Seller delivery performance
* KPI analysis
* Dashboard development
* Data visualization

The Excel workbook is maintained separately because the working file is larger than GitHub's standard file-size limit.

---

# SQL Analysis

The same Olist dataset was analyzed using MySQL to perform deeper relational and business analysis.

### SQL concepts demonstrated

* SELECT
* WHERE
* GROUP BY
* ORDER BY
* Aggregate functions
* CASE WHEN
* INNER JOIN
* LEFT JOIN
* CTEs
* Subqueries
* Window functions
* RANK()
* LAG()
* STR_TO_DATE()
* DATEDIFF()
* Percentage calculations
* Data reconciliation
* Data quality analysis

SQL queries are available in:

`SQL/olist_sql_analysis.sql`

---

# Key Business Findings

### Overall Performance

* **99,441** total orders
* **96,478** orders marked as delivered
* **97.02%** of orders were marked as delivered
* **625** canceled orders
* **609** unavailable orders

### Payment Analysis

* Credit card represented **78.34%** of total payment value.
* Boleto represented **17.92%**.

### Delivery Performance

Among 96,478 delivered orders:

* **91.88%** were delivered earlier than the estimated date.
* **6.77%** were delivered late.
* **1.34%** arrived exactly on the estimated date.
* **0.01%** were unclassified because of missing delivery-date information.

### Late Delivery Analysis

* **6,534** late deliveries
* Average delay: **10.62 days**
* Maximum delay: **188 days**

### Data Quality Analysis

A reconciliation between the `orders` and `order_items` tables identified **775 orders without item-level records**.

Approximately **98.97%** of these orders were classified as unavailable or canceled, indicating that the missing item records were largely associated with unsuccessful order lifecycles.

### Seller Analysis

The highest-selling seller generated approximately **229,472.63** in product sales and contributed approximately **1.69%** of total product sales.

The top 10 sellers contributed approximately **13.74%**, indicating that product sales were relatively distributed across sellers.

---

# Data Quality & Limitations

During the analysis, several data-quality considerations were identified:

* Some date fields were stored as text and required conversion using `STR_TO_DATE()`.
* Eight delivered orders contained missing delivery-date values and were therefore classified as unclassified.
* The customer identifier structure did not support reliable repeat-customer analysis.
* The order reviews table was only partially imported and was therefore excluded from the final SQL analysis.
* September 2018 contained an unusually low sales value and should be treated as a data-coverage anomaly rather than a normal business trend.

---

# Project Objective

The objective is to demonstrate how a real-world e-commerce dataset can be taken through multiple stages of a data analytics workflow:

**Data → Cleaning → Analysis → Business Insights → Visualization → Decision Support**

The project will progressively use Excel, SQL, Power BI and Python to demonstrate different analytical capabilities.

---

# Project Status

### Completed

* [x] Excel Analysis
* [x] SQL / MySQL Analysis

### Upcoming

* [ ] Power BI Data Modeling
* [ ] Power BI Dashboard
* [ ] Python Exploratory Data Analysis
* [ ] Final Cross-Tool Business Insights


