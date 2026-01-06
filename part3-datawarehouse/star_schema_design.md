\# Star Schema Design – FlexiMart Data Warehouse  

\*\*Part 3 – Task 3.1 (10 Marks)\*\*  

\*\*Student: Ramanathan Sathappan\*\*



---



\## \*\*Section 1: Schema Overview (Star Schema Description)\*\*



The FlexiMart data warehouse is designed using a \*\*star schema\*\* to support fast analytical queries on historical sales. The central table is \*\*fact\_sales\*\*, surrounded by three dimension tables: \*\*dim\_date\*\*, \*\*dim\_product\*\*, and \*\*dim\_customer\*\*.



\### \*\*FACT TABLE: fact\_sales\*\*

\*\*Grain:\*\* One row per product per order line item  

\*\*Business Process:\*\* Sales transactions  



\*\*Measures (Numeric Facts):\*\*

\- \*\*quantity\_sold\*\* – Number of units sold  

\- \*\*unit\_price\*\* – Price per unit at the time of sale  

\- \*\*discount\_amount\*\* – Discount applied to the line item  

\- \*\*total\_amount\*\* – Final amount (quantity × unit\_price − discount\_amount)



\*\*Foreign Keys:\*\*

\- \*\*date\_key → dim\_date\*\*  

\- \*\*product\_key → dim\_product\*\*  

\- \*\*customer\_key → dim\_customer\*\*



---



\### \*\*DIMENSION TABLE: dim\_date\*\*

\*\*Purpose:\*\* Supports time‑based analysis  

\*\*Type:\*\* Conformed dimension  



\*\*Attributes:\*\*

\- \*\*date\_key (PK):\*\* Integer surrogate key (YYYYMMDD)  

\- \*\*full\_date:\*\* Actual calendar date  

\- \*\*day\_of\_week:\*\* Monday–Sunday  

\- \*\*month:\*\* 1–12  

\- \*\*month\_name:\*\* January–December  

\- \*\*quarter:\*\* Q1–Q4  

\- \*\*year:\*\* Calendar year  

\- \*\*is\_weekend:\*\* Boolean indicator  



---



\### \*\*DIMENSION TABLE: dim\_product\*\*

\*\*Purpose:\*\* Describes product attributes  

\*\*Attributes:\*\*

\- \*\*product\_key (PK):\*\* Surrogate key  

\- \*\*product\_id:\*\* Natural key from source system  

\- \*\*product\_name:\*\* Name of the product  

\- \*\*category:\*\* Product category (e.g., Electronics, Footwear)  

\- \*\*brand:\*\* Brand or manufacturer  

\- \*\*specifications:\*\* JSON/text field for flexible attributes  

\- \*\*launch\_year:\*\* Year product was introduced  



---



\### \*\*DIMENSION TABLE: dim\_customer\*\*

\*\*Purpose:\*\* Describes customer demographics  

\*\*Attributes:\*\*

\- \*\*customer\_key (PK):\*\* Surrogate key  

\- \*\*customer\_id:\*\* Natural key from source  

\- \*\*customer\_name:\*\* Full name  

\- \*\*email:\*\* Customer email  

\- \*\*phone:\*\* Contact number  

\- \*\*city:\*\* City of residence  

\- \*\*registration\_date:\*\* When the customer joined FlexiMart  

\- \*\*customer\_segment:\*\* e.g., Regular, Premium, Corporate  



---



\## \*\*Section 2: Design Decisions\*\*



The chosen granularity for the fact table is the \*\*transaction line‑item level\*\*, meaning each row represents a single product sold within an order. This level of detail is ideal because it preserves all sales information and supports flexible analysis such as product‑level trends, customer purchasing behavior, and time‑based aggregations. Higher‑level grains would lose important detail, while lower‑level grains would add unnecessary complexity.



Surrogate keys are used instead of natural keys to ensure consistency, performance, and independence from source system changes. Natural keys such as product IDs or customer IDs may change over time, contain gaps, or be non‑numeric, which can slow down joins. Surrogate keys provide stable, integer‑based identifiers optimized for analytics.



This star schema supports \*\*drill‑down\*\* (e.g., year → month → day) and \*\*roll‑up\*\* (e.g., product → category → brand) operations through well‑structured dimensions. Analysts can easily aggregate sales by time, product attributes, or customer segments, enabling powerful OLAP‑style reporting.



---



\## \*\*Section 3: Sample Data Flow (Source → Data Warehouse)\*\*



\### \*\*Source Transaction\*\*

Order #101  

Customer: \*John Doe\*  

Product: \*Laptop\*  

Quantity: 2  

Unit Price: 50,000  



\### \*\*Transformed into Data Warehouse\*\*



\#### \*\*fact\_sales\*\*

```json

{

&nbsp; "date\_key": 20240115,

&nbsp; "product\_key": 5,

&nbsp; "customer\_key": 12,

&nbsp; "quantity\_sold": 2,

&nbsp; "unit\_price": 50000,

&nbsp; "discount\_amount": 0,

&nbsp; "total\_amount": 100000

}

```



\#### \*\*dim\_date\*\*

```json

{

&nbsp; "date\_key": 20240115,

&nbsp; "full\_date": "2024-01-15",

&nbsp; "day\_of\_week": "Monday",

&nbsp; "month": 1,

&nbsp; "month\_name": "January",

&nbsp; "quarter": "Q1",

&nbsp; "year": 2024,

&nbsp; "is\_weekend": false

}

```



\#### \*\*dim\_product\*\*

```json

{

&nbsp; "product\_key": 5,

&nbsp; "product\_id": "ELEC010",

&nbsp; "product\_name": "Laptop",

&nbsp; "category": "Electronics",

&nbsp; "brand": "HP",

&nbsp; "specifications": {"ram": "16GB", "processor": "Intel i7"},

&nbsp; "launch\_year": 2023

}

```



\#### \*\*dim\_customer\*\*

```json

{

&nbsp; "customer\_key": 12,

&nbsp; "customer\_id": "CUST101",

&nbsp; "customer\_name": "John Doe",

&nbsp; "email": "john@example.com",

&nbsp; "phone": "+91-9876543210",

&nbsp; "city": "Mumbai",

&nbsp; "registration\_date": "2022-05-10",

&nbsp; "customer\_segment": "Regular"

}

```

