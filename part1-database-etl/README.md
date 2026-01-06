# README.md — FlexiMart Data Architecture (Part 1)

## Overview
This project implements the ETL pipeline, database schema documentation, and business SQL queries for the FlexiMart retail dataset.  
It includes:

- **Task 1.1:** ETL Pipeline Implementation  
- **Task 1.2:** Database Schema Documentation  
- **Task 1.3:** Business Query Implementation  

The goal is to clean raw CSV data, load it into a normalized relational database, and generate analytical SQL queries for business insights.

---

## 📌 Task 1.1 — ETL Pipeline
The ETL pipeline is implemented in **`etl_pipeline.py`** and performs the following steps:

### Extract
Reads all three raw CSV files:
- `customers_raw.csv`
- `products_raw.csv`
- `sales_raw.csv`

### Transform
- Removes duplicate records  
- Handles missing values:
  - Missing emails → default email  
  - Missing prices/stock → filled with 0  
  - Missing customer/product IDs → dropped  
  - Missing dates → filled with today’s date  
- Standardizes:
  - Phone numbers → `+91-XXXXXXXXXX`
  - Category names → Title Case  
  - Dates → `YYYY-MM-DD`  
- Computes:
  - Subtotals  
  - Surrogate key mappings  
- Adds:
  - Default order status = `"Pending"`

### Load
- Loads cleaned data into MySQL using PyMySQL  
- Inserts into tables in correct dependency order:
  1. customers  
  2. products  
  3. orders  
  4. order_items  
- Generates **data_quality_report.txt**

### Example Output
```
25 customers inserted.
20 products inserted.
8 orders inserted.
8 order_items inserted.
ETL Pipeline completed successfully!
```

---

## 📌 Task 1.2 — Database Schema Documentation
Full documentation is provided in **`schema_documentation.md`**, including:

### ✔ Entity–Relationship Descriptions  
Covers all four tables:
- customers  
- products  
- orders  
- order_items  

### ✔ Normalization Explanation (3NF)  
Includes:
- Functional dependencies  
- Avoidance of anomalies  
- Justification for 3NF design  

### ✔ Sample Data Tables  
Shows 2–3 example rows per table.

---

## 📌 Task 1.3 — Business Queries
All SQL queries are included in **`business_queries.sql`**.

### Query 1 — Customer Purchase History
Returns customers with:
- At least 2 orders  
- More than ₹5000 total spent  

### Query 2 — Product Sales Analysis
Returns categories with:
- Total revenue > ₹10,000  
- Count of products sold  
- Total quantity sold  

### Query 3 — Monthly Sales Trend (2024)
Shows:
- Month name  
- Total orders  
- Monthly revenue  
- Cumulative revenue (window function)  

---

## 📁 Repository Structure
```
/part1-database-etl
│
├── etl_pipeline.py
├── data_quality_report.txt
├── schema_documentation.md
├── business_queries.sql
│
└── data/
    ├── customers_raw.csv
    ├── products_raw.csv
    └── sales_raw.csv
```

---

## ⚙ Technologies Used
- Python (Pandas, PyMySQL)
- MySQL 8.0
- SQL (Joins, Aggregations, Window Functions)
- GitHub for version control

---

## ✔ Status
All tasks for **Part 1** have been completed successfully:
- ETL pipeline runs end‑to‑end  
- Database schema implemented  
- Documentation prepared  
- Business queries validated

Updated documentation for ETL pipeline.