Part 3 – Data Warehouse and OLAP Analytics

FlexiMart Data Warehouse Project

Student: Ramanathan Sathappan



1\. Overview

Part 3 focuses on designing and implementing a complete data warehouse for FlexiMart using a star schema, loading dimensional and fact data, and performing OLAP analytical queries. This part demonstrates dimensional modeling, ETL-style loading, and SQL analytics.



This folder contains all scripts and documentation required for Part 3.



2\. Files Included

star\_schema\_design.md

Contains the full star schema documentation:

\- Fact table: fact\_sales

\- Dimensions: dim\_date, dim\_product, dim\_customer

\- Grain, attributes, surrogate keys

\- Design decisions

\- Example of source-to-warehouse data flow

warehouse\_schema.sql

Creates all warehouse tables:

\- dim\_date

\- dim\_product

\- dim\_customer

\- fact\_sales

Includes primary keys, auto-increment surrogate keys, and foreign key constraints.

Run this file before loading any data.

warehouse\_data.sql

Loads all required data:

\- 30 dates (Jan–Feb 2024)

\- 15 products across 3 categories

\- 12 customers across 4 cities

\- 40 sales transactions

Data follows assignment guidelines:

\- Weekend sales are higher

\- Product prices vary

\- Customers represent multiple cities

\- Fact table references all dimensions correctly



analytics\_queries.sql

Contains all OLAP analytical queries:

Query 1: Monthly Sales Drill-Down

\- Year → Quarter → Month

\- Total sales and total quantity



Query 2: Top 10 Products by Revenue

\- Units sold

\- Total revenue

\- Revenue percentage contribution



Query 3: Customer Segmentation

\- High, Medium, Low value customers

\- Customer count, total revenue, average revenue



3\. How to Run the Warehouse

Step 1: Create the schema

Run:

warehouse\_schema.sql





Step 2: Load the data

If reloading, run:

SET FOREIGN\_KEY\_CHECKS = 0;

TRUNCATE TABLE fact\_sales;

TRUNCATE TABLE dim\_customer;

TRUNCATE TABLE dim\_product;

TRUNCATE TABLE dim\_date;

SET FOREIGN\_KEY\_CHECKS = 1;





Then run:

warehouse\_data.sql





Step 3: Run OLAP queries

Execute:

analytics\_queries.sql





4\. Validation Checks

Run these to confirm correct loading:

SELECT COUNT(\*) FROM dim\_date;      -- Expect 30

SELECT COUNT(\*) FROM dim\_product;   -- Expect 15

SELECT COUNT(\*) FROM dim\_customer;  -- Expect 12

SELECT COUNT(\*) FROM fact\_sales;    -- Expect 40





5\. Notes

\- Surrogate keys are auto-generated for product, customer, and sales tables.

\- date\_key uses YYYYMMDD format.

\- Fact table supports drill-down and roll-up operations.

