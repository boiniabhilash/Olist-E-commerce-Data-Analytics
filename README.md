# Olist E-Commerce Business Intelligence & Customer Analytics

## Project Overview

An end-to-end data analytics project built using the Olist Brazilian E-Commerce dataset.

The project analyzes e-commerce sales, customers, products, payments, delivery performance, and customer satisfaction across multiple analytical tools.

The workflow progresses from data preparation and business analysis to SQL analytics, advanced Python analysis, interactive Power BI dashboards, and an AI/GenAI Business Analyst prototype.

### Project Workflow

**Excel → SQL → Python → Power BI → AI/GenAI**

---

# Business Objective

The objective of this project is to understand:

* How the business is performing
* Which products and categories generate the most sales
* Which sellers and states contribute to sales
* How customers behave and differ in value
* How delivery performance affects customer satisfaction
* Which customers require different levels of attention
* Whether customer dissatisfaction can be predicted
* How AI/GenAI can support business analysis

---

# Dataset

The project uses the **Olist Brazilian E-Commerce dataset**, containing information about:

* Orders
* Customers
* Products
* Sellers
* Order Items
* Payments
* Reviews
* Product categories
* Delivery dates

The dataset contains approximately 100,000 orders and more than 100,000 order-item and payment records.

---

# Tools & Technologies

| Tool       | Purpose                                                   |
| ---------- | --------------------------------------------------------- |
| Excel      | Data cleaning, PivotTables, exploratory business analysis |
| MySQL      | Relational database analysis and advanced SQL             |
| Python     | EDA, statistics, RFM, segmentation, predictive analytics  |
| Power BI   | Interactive business intelligence dashboard               |
| AI / GenAI | AI-ready Business Analyst prototype                       |
| GitHub     | Project documentation and portfolio presentation          |

---

# Project Structure

```text
Olist-Ecommerce-Analytics/
│
├── Excel/
│   ├── Olist Excel Analysis.xlsx
│   └── README.md
│
├── Sql/
│   ├── olist analysis title.sql
│   ├── olist_sql_analysis.sql
│   └── README.md
│
├── Python/
│   ├── Olist_Ecommerce_Data_Analysis_Python.ipynb
│   ├── Olist_Ecommerce_AI_Business_Analyst.ipynb
│   └── README.md
│
├── PowerBI/
│   ├── Olist Ecommerce Dashboard.pbix
│   └── Olist Dashboard.png
│
└── README.md
```

---

# Phase 1 — Excel Analysis

The Excel phase focused on preparing the data and performing initial business analysis.

### Activities

* Data cleaning
* Data validation
* PivotTables
* Customer state analysis
* Seller delivery analysis
* Delivery performance analysis
* Sales analysis
* Business KPI analysis
* Initial dashboard development

### Business questions

* How many orders were placed?
* Which states generated the most sales?
* Which sellers performed strongly?
* How many orders were early, on time, or late?
* What are the major sales patterns?

---

# Phase 2 — SQL Analysis

The SQL phase rebuilt the business analysis using MySQL.

### SQL concepts demonstrated

* Database creation
* Table creation
* Data types
* Primary keys
* Foreign keys
* Database relationships
* SELECT
* WHERE
* GROUP BY
* ORDER BY
* Aggregate functions
* CASE WHEN
* JOINs
* CTEs
* Subqueries
* Window functions
* Ranking

### Business analysis

* Customer analysis
* Seller analysis
* Revenue analysis
* Product analysis
* Payment analysis
* Delivery analysis
* Order status analysis
* Business KPI analysis

### Example business questions

* Who are the top sellers by revenue?
* Which product categories generate the most sales?
* Which states have the most orders?
* What are the major payment methods?
* How many orders are delivered late?
* How does delivery performance vary by state?

---

# Phase 3 — Python Advanced Analytics

Python was used to move beyond descriptive analysis into advanced customer and statistical analytics.

### Analysis performed

* Data cleaning
* Exploratory data analysis
* Distribution analysis
* Outlier detection
* Customer segmentation
* RFM analysis
* Correlation analysis
* Statistical testing
* Predictive modeling
* Data visualization

---

## Distribution & Outlier Analysis

Order values were analyzed to understand their distribution.

The analysis showed a strongly right-skewed distribution, with a relatively small number of high-value orders.

Using the IQR method:

* Q1: 45.90
* Q3: 149.90
* Upper outlier limit: 305.90
* Outliers: 7,913
* Outlier percentage: approximately 8.02%

High-value orders were retained because they may represent genuine business transactions.

---

# Customer Segmentation

Customers were segmented based on purchase value:

* Low
* Medium
* High
* Very High

The analysis showed that most customers belonged to lower-value groups, while a smaller group generated substantially higher purchase values.

An important dataset characteristic was identified:

> Each customer has one order in the available Olist customer/order structure.

Therefore, repeat-customer analysis is limited.

---

# RFM Analysis

RFM analysis was performed using:

* **Recency** — how recently the customer purchased
* **Frequency** — how often the customer purchased
* **Monetary** — how much the customer spent

Because customer frequency is 1 in the available data structure, the RFM analysis is primarily differentiated by **Recency and Monetary value**.

RFM segmentation was also incorporated into the Power BI dashboard.

---

# Correlation & Statistical Analysis

Order-level correlation analysis examined relationships between:

* Product price
* Freight value
* Delivery time
* Review score

Key result:

**Delivery Days vs Review Score: approximately -0.334**

This indicates a negative association between delivery time and customer review score.

A Pearson correlation test was also performed using 96,359 observations.

### Important interpretation

Correlation indicates association, not causation.

Therefore, the analysis does not claim that delivery time alone causes lower customer satisfaction.

---

# Predictive Analytics

A Logistic Regression model was developed to predict **low review scores**.

### Target

Low review:

**Review Score ≤ 2**

### Features

* Product price
* Freight value
* Delivery days

### Baseline model

* Accuracy: 88.07%
* Precision: 70.31%
* Recall: 11.98%
* F1 Score: 20.48%

### Balanced model

A class-balanced Logistic Regression model was also tested.

* Accuracy: 72.64%
* Precision: 24.33%
* Recall: 53.77%
* F1 Score: 33.50%

The balanced model improved recall for low-review cases while reducing overall accuracy and precision.

This demonstrates the importance of considering multiple evaluation metrics when dealing with imbalanced classification problems.

---

# Phase 4 — Power BI Dashboard

The Power BI phase transformed the analysis into an interactive business intelligence dashboard.

## Page 1 — Executive Overview

Key elements:

* Total Orders
* Total Sales
* Total Customers
* Average Order Value
* Delivery Rate
* Monthly Sales Trend
* Top Product Categories
* Sales by Customer State
* Payment Analysis
* Order Status
* Top Sellers
* Delivery Performance by State

---

## Page 2 — Sales & Product Intelligence

Key elements:

* Total Product Sales
* Total Freight
* Average Order Value
* Sales by Product Category
* Monthly Product Sales Trend
* Top 10 Sellers by Product Sales
* Top 10 Products by Sales
* Freight Cost by Product Category

---

## Page 3 — Customer Intelligence

Key elements:

* Total Customers
* Average Customer Value
* Average Orders per Customer
* Average Review Score
* Customer Review Distribution
* RFM Customer Segments
* Average Customer Value by RFM Segment
* Average Recency by RFM Segment

---

## Page 4 — Delivery & Customer Experience

Key elements:

* Late Delivery %
* Average Delivery Days
* Delivery Performance Distribution
* Review Score by Delivery Performance
* Average Delivery Time by State
* Late Delivery % by State
* Average Review Score

---

# Phase 5 — AI / GenAI Business Analyst

A separate notebook was created:

`Olist_Ecommerce_AI_Business_Analyst.ipynb`

The goal is to demonstrate how analytical evidence can be structured for an AI Business Analyst workflow.

### Example business question

> Why did customer satisfaction decrease?

The prototype combines evidence such as:

* Average delivery time
* Late orders
* Delivery/review correlation
* Low-review orders
* Predictive-model performance

The workflow structures responses into:

1. Key Finding
2. Evidence
3. Possible Factors
4. Business Recommendation
5. Limitations

### Current implementation

The notebook is an **AI-ready Business Analyst prototype**.

It currently uses structured project evidence and rule-based responses.

An external LLM/API has **not** been connected.

This means the project does not claim to be a production AI chatbot or production LLM application.

---

# Key Business Insights

The project identified several important patterns:

### 1. Delivery and customer satisfaction

Longer delivery times were associated with lower review scores.

The observed correlation was approximately **-0.334**.

### 2. Customer value is highly uneven

Most customers have relatively low purchase values, while a smaller group contributes significantly higher monetary value.

### 3. Delivery performance varies

A meaningful number of orders were delivered late, making delivery performance an important customer-experience metric.

### 4. Repeat-customer analysis is limited

The available Olist customer/order structure contains one order per customer, so traditional repeat-purchase analysis cannot be meaningfully performed.

### 5. Low-review prediction is challenging

The balanced model detected more low-review cases than the baseline model, but precision remained limited.

This demonstrates the trade-off between recall and precision in imbalanced classification.

### 6. AI can support analytical workflows

Structured business evidence can be combined with natural-language questions to create an AI-assisted Business Analyst workflow.

---

# Project Limitations

* Customer frequency is effectively 1 in the available dataset structure.
* Repeat-customer analysis is therefore limited.
* Correlation does not prove causation.
* The predictive model is a baseline and is not production-ready.
* The predictive model uses a limited feature set.
* The SQL review table contained fewer review records than the Python review dataset.
* RFM scoring methods differ slightly between Python and Power BI because Power BI uses fixed business thresholds.
* The AI component is a prototype and is not a production LLM application.

---

# Skills Demonstrated

## Data Analytics

* Data cleaning
* Exploratory data analysis
* Business KPI analysis
* Data visualization
* Business problem solving
* Insight generation

## SQL

* MySQL
* Database design
* Relational data modeling
* Joins
* CTEs
* Subqueries
* Window functions
* Ranking
* Aggregation
* Conditional logic

## Python

* Pandas
* NumPy
* Matplotlib
* SciPy
* Scikit-learn
* Statistical analysis
* RFM analysis
* Customer segmentation
* Predictive modeling

## Power BI

* Data modeling
* DAX
* KPI cards
* Interactive dashboards
* Slicers
* Business intelligence reporting
* Customer analytics
* Delivery analytics
* RFM visualization

## AI / GenAI

* AI Business Analyst workflow design
* Structured evidence retrieval
* Prompt engineering
* Business question answering
* AI response evaluation
* Hallucination and causation safeguards

---

# Final Project Outcome

This project demonstrates an end-to-end Data Analyst workflow:

**Raw Data → Excel → SQL → Python → Power BI → AI/GenAI**

The project combines technical analysis with business interpretation to understand:

**Sales → Products → Customers → Delivery → Customer Satisfaction → Predictive Analytics → AI-assisted Business Analysis**

---

## Repository

All project files, analysis notebooks, SQL scripts, Excel analysis, Power BI dashboard, and documentation are organized within this repository.
