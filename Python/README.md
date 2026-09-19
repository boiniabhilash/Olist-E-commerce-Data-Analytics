# Olist E-Commerce Data Analysis — Python

## Project Overview

This project analyzes the Olist Brazilian e-commerce dataset using Python to understand sales performance, customer behavior, delivery performance, and customer satisfaction.

The analysis progresses from basic exploratory data analysis to advanced customer analytics, statistical analysis, predictive modeling, and an AI/GenAI Business Analyst prototype.

---

## Objectives

* Understand overall e-commerce sales and order patterns
* Analyze customer purchasing behavior
* Identify delivery performance issues
* Analyze customer review scores
* Detect unusual order values and outliers
* Segment customers based on purchase behavior
* Perform RFM analysis
* Identify relationships between delivery and customer satisfaction
* Perform statistical analysis
* Build a baseline predictive model for low review scores
* Develop an AI-ready Business Analyst prototype

---

## Dataset

The analysis uses the Olist Brazilian E-Commerce dataset.

Main datasets used:

* Orders
* Order Items
* Payments
* Customers
* Reviews

The datasets were cleaned, prepared, merged, and analyzed using Python.

---

## Tools & Libraries

* Python
* Pandas
* NumPy
* Matplotlib
* SciPy
* Scikit-learn
* Jupyter Notebook

---

# Analysis Performed

## 1. Data Loading & Preparation

The datasets were loaded into Pandas DataFrames and prepared for analysis.

Key preparation activities included:

* Loading multiple CSV files
* Checking dataset dimensions
* Inspecting data types
* Handling missing values
* Converting date/time columns
* Creating analysis-ready variables
* Combining relevant datasets for business analysis

---

## 2. Exploratory Data Analysis

Basic business KPIs and patterns were analyzed, including:

* Total orders
* Product sales
* Freight value
* Average order value
* Delivery time
* Review scores
* Order status
* Payment information

Visualizations were created to understand the major patterns in the dataset.

---

## 3. Distribution Analysis

Order-level product values were analyzed to understand the distribution of customer purchases.

Key findings:

* Most orders were relatively low-value.
* The distribution was right-skewed.
* The median order value was lower than the mean.
* A small number of orders had substantially higher values.

Approximately 84.8% of analyzed orders had product values below 200.

---

## 4. Outlier Detection

The Interquartile Range (IQR) method was used to identify unusually high order values.

Results:

* Q1: 45.90
* Q3: 149.90
* Upper outlier limit: 305.90
* Outliers: 7,913
* Outlier percentage: approximately 8.02%

High-value orders were retained because they may represent genuine customer purchases rather than data errors.

---

## 5. Customer Segmentation

Customers were segmented using purchase value.

Segments:

* Low Value
* Medium Value
* High Value
* Very High Value

The analysis showed that most customers belonged to the lower-value segment, while a smaller group generated substantially higher purchase values.

An important dataset characteristic was identified:

> Each customer has one order in the available Olist customer/order structure.

Therefore, traditional repeat-customer analysis is limited in this dataset.

---

# 6. RFM Analysis

RFM analysis was performed using:

* **Recency** — how recently a customer purchased
* **Frequency** — how often a customer purchased
* **Monetary** — how much a customer spent

The Python RFM analysis showed:

* Frequency was 1 for all customers.
* Therefore, RFM differentiation was mainly driven by Recency and Monetary value.

RFM segments were created to identify:

* Low-value / less recent customers
* Medium customers
* Higher-value / more recent customers

This analysis was also incorporated into the Power BI dashboard.

---

# 7. Correlation Analysis

Correlation analysis was performed at the order level to avoid overweighting orders containing multiple items.

Important correlations:

| Variables                    | Correlation |
| ---------------------------- | ----------: |
| Price & Freight              |       0.413 |
| Price & Delivery Days        |       0.055 |
| Price & Review Score         |      -0.040 |
| Freight & Delivery Days      |       0.167 |
| Freight & Review Score       |      -0.089 |
| Delivery Days & Review Score |      -0.334 |

The strongest relationship observed was between delivery time and review score.

A negative correlation of approximately **-0.334** indicates that longer delivery times were associated with lower review scores.

**Correlation does not prove causation.**

---

# 8. Statistical Analysis

A Pearson correlation test was performed between:

* Delivery Days
* Review Score

The analysis used 96,359 observations.

Results:

* Pearson correlation: approximately **-0.334**
* p-value: effectively 0 at the available numerical precision

This provides statistical evidence of an association between delivery time and review score.

However, the result does not establish that delivery time alone causes lower customer satisfaction.

---

# 9. Predictive Analysis

A baseline Logistic Regression model was developed to predict whether an order would receive a low review score.

A low review was defined as:

* Review score ≤ 2

Features:

* Product price
* Freight value
* Delivery days

Target:

* Low review = 1
* Other review = 0

### Baseline Model

Performance:

* Accuracy: 88.07%
* Precision: 70.31%
* Recall: 11.98%
* F1 Score: 20.48%

The baseline model had relatively high accuracy but detected only a small proportion of actual low-review cases.

### Balanced Model

A second Logistic Regression model used class weighting to address class imbalance.

Performance:

* Accuracy: 72.64%
* Precision: 24.33%
* Recall: 53.77%
* F1 Score: 33.50%

The balanced model substantially improved recall for low-review orders, although precision remained limited.

This demonstrates the importance of evaluating multiple classification metrics rather than relying only on accuracy.

---

# 10. AI / GenAI Business Analyst Prototype

A separate notebook was created:

`Olist_Ecommerce_AI_Business_Analyst.ipynb`

The goal was to create an AI-ready Business Analyst workflow that combines analytical evidence with natural-language business questions.

Example business question:

> Why did customer satisfaction decrease?

The prototype combines evidence such as:

* Average delivery time
* Number of late orders
* Delivery/review correlation
* Low-review order count
* Predictive-model performance

The workflow is designed to produce:

1. Key finding
2. Evidence
3. Possible factors
4. Business recommendation
5. Limitations

### Important

The current notebook is an **AI-ready prototype**, not a production LLM application.

The prototype uses structured analytical evidence and rule-based responses. An external LLM/API connection was not added.

This avoids exposing API credentials inside a browser-based Jupyter environment.

---

# Key Business Insights

The analysis identified several important business patterns:

* Delivery performance is associated with customer satisfaction.
* Longer delivery times are associated with lower review scores.
* A meaningful number of orders were delivered late.
* Customer purchase values are highly right-skewed.
* A relatively small group of high-value customers contributes substantially more purchase value.
* The dataset contains one order per customer in the available customer/order structure, limiting repeat-customer analysis.
* Predicting low reviews is challenging because low-review cases are a minority class.
* Class balancing improves recall but creates a trade-off with precision.

---

# Project Limitations

* Customer frequency is effectively 1 in the available dataset structure.
* Therefore, repeat-customer analysis is limited.
* Correlation does not establish causation.
* The predictive model is a baseline model and is not production-ready.
* The predictive model uses a limited set of features.
* The SQL review table used in the SQL phase contained fewer review records than the full review dataset used in Python.
* RFM scoring methods may differ between Python and Power BI because the Power BI dashboard uses fixed business thresholds.

---

# Repository Structure

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

# Skills Demonstrated

### Python

* Data cleaning
* Exploratory data analysis
* Data transformation
* Business KPI analysis
* Distribution analysis
* Outlier detection
* Customer segmentation
* RFM analysis
* Correlation analysis
* Statistical testing
* Logistic Regression
* Classification evaluation
* Data visualization
* AI/GenAI workflow design

### Business Analytics

* Customer behavior analysis
* Sales analysis
* Delivery performance analysis
* Customer satisfaction analysis
* Business problem framing
* Data-driven recommendations
* Analytical limitations and uncertainty

---

# Outcome

This Python phase progressed from basic data analysis to advanced analytics and an AI-ready Business Analyst prototype.

The resulting analysis provides a foundation for the final Olist E-Commerce Business Intelligence portfolio project combining:

**Excel → SQL → Python → Power BI → AI/GenAI**
