# Olist E-Commerce Data Analytics

## End-to-End Data Analytics Portfolio Project

An end-to-end e-commerce analytics project using the **Olist dataset** to analyze business performance through multiple data analytics tools.

The same business dataset is analyzed across different tools, with each stage focusing on different analytical skills and business questions.

---

## Project Roadmap

| Stage | Tool        | Focus                                                       | Status      |
| ----- | ----------- | ----------------------------------------------------------- | ----------- |
| 1     | Excel       | Data cleaning, PivotTables, business analysis and dashboard | ✅ Completed |
| 2     | SQL / MySQL | Business analysis, advanced SQL and data quality analysis   | ✅ Completed |
| 3     | Power BI    | Data modeling, DAX and interactive dashboard                | ✅ Completed |
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

The Excel workbook is maintained separately because the working file is larger than GitHub's standard individual file-size limit.

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

# Power BI Analysis

The final stage of the current project was developed in Power BI to create an interactive business dashboard.

### Power BI skills demonstrated

* Data modeling
* DAX measures
* KPI development
* Interactive visuals
* Slicers and filtering
* Payment analysis
* Delivery performance analysis
* Business performance visualization
* Dashboard formatting
* Data-quality documentation

### Dashboard Preview

![Olist E-Commerce Dashboard](PowerBI/Olist_Dashboard.png)

The complete Power BI dashboard file is available in:

`PowerBI/Olist Ecommerce Dashboard.pbix`

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
* **6.77%** arrived late.
* **1.34%** arrived exactly on the estimated date.
* A very small number of records could not be classified because of missing delivery-date information.

### Late Delivery Analysis

* **6,534** late deliveries
* Average delay: **10.62 days**
* Maximum delay: **188 days**

### Data Quality Analysis

A reconciliation between the `orders` and `order_items` tables identified **775 orders without item-level records**.

Approximately **98.97%** of these orders were classified as unavailable or canceled, indicating that the missing item records were largely associated with unsuccessful order lifecycles.

### Seller Analysis

Seller-level analysis was performed to examine sales contribution, order volume, freight costs and average order-item value.

The analysis also compared the contribution of the top sellers with overall product sales to understand seller concentration.

---

# Data Quality & Limitations

During the analysis, several data-quality considerations were identified:

* Some date fields were stored as text and required conversion using `STR_TO_DATE()`.
* Eight delivered orders contained missing delivery-date values and were therefore classified as unclassified.
* The customer identifier structure did not support reliable repeat-customer analysis.
* The order reviews table was only partially imported and was therefore excluded from the final SQL analysis.
* September 2018 contained an unusually low number/value of records and should be treated as a data-coverage anomaly rather than interpreted as a normal business trend.

These limitations were documented rather than silently removing the affected records.

---

# Project Objective

The objective is to demonstrate how a real-world e-commerce dataset can be taken through multiple stages of a data analytics workflow:

**Data → Cleaning → Analysis → Business Insights → Visualization → Decision Support**

The project progressively uses Excel, SQL, Power BI and Python to demonstrate different analytical capabilities.

---

# Project Structure

```text
olist-ecommerce-data-analytics/
│
├── README.md
│
├── Excel/
│   └── Excel project documentation
│
├── SQL/
│   └── olist_sql_analysis.sql
│
├── PowerBI/
│   ├── Olist_Ecommerce_Dashboard.pbix
│   └── Olist_Dashboard.png
│
└── Python/
    └── Coming soon
```

---

# Project Status

### Completed

* [x] Excel Analysis
* [x] SQL / MySQL Analysis
* [x] Power BI Data Modeling
* [x] Power BI Dashboard
* [x] Dashboard Formatting
* [x] Data Quality Documentation

### Upcoming

* [ ] Python Exploratory Data Analysis
* [ ] Python Visualization
* [ ] Final Cross-Tool Business Insights
* [ ] Final Portfolio Review

---

## Future Development

The next stage of the project will use **Python** for exploratory data analysis and visualization.

The completed Excel, SQL and Power BI work will remain unchanged while Python is developed as the next analytical stage.
