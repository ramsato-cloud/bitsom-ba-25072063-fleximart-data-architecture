\# FlexiMart Data Architecture Project



\*\*Student Name:\*\* Ramanathan Sathappan 

\*\*Student ID:\*\* bitsom\_ba\_25072063

\*\*Email:\*\* ramsato@gmail.com

\*\*Date:\*\* 2026-01-06



---



\## Project Overview



This project delivers a complete end‑to‑end data architecture for FlexiMart, including an operational relational database, a NoSQL document store, and a dimensional data warehouse. It covers ETL development, schema design, data quality validation, NoSQL modeling, and analytical SQL queries to support business intelligence needs.



---



\## Repository Structure



├── part1-database-etl/

│   ├── etl\_pipeline.py

│   ├── schema\_documentation.md

│   ├── business\_queries.sql

│   └── data\_quality\_report.txt

├── part2-nosql/

│   ├── nosql\_analysis.md

│   ├── mongodb\_operations.js

│   └── products\_catalog.json

├── part3-datawarehouse/

│   ├── star\_schema\_design.md

│   ├── warehouse\_schema.sql

│   ├── warehouse\_data.sql

│   └── analytics\_queries.sql

└── README.md





---



\## Technologies Used



\- Python 3.x (pandas, mysql-connector-python)  

\- MySQL 8.0 / PostgreSQL 14  

\- MongoDB 6.0  

\- SQL, JSON, JavaScript (MongoDB Shell)



---



\## Setup Instructions



\### Database Setup



```bash

\# Create databases

mysql -u root -p -e "CREATE DATABASE fleximart;"

mysql -u root -p -e "CREATE DATABASE fleximart\_dw;"



\# Run Part 1 - ETL Pipeline

python part1-database-etl/etl\_pipeline.py



\# Run Part 1 - Business Queries

mysql -u root -p fleximart < part1-database-etl/business\_queries.sql



\# Run Part 3 - Data Warehouse

mysql -u root -p fleximart\_dw < part3-datawarehouse/warehouse\_schema.sql

mysql -u root -p fleximart\_dw < part3-datawarehouse/warehouse\_data.sql

mysql -u root -p fleximart\_dw < part3-datawarehouse/analytics\_queries.sql





\### MongoDB Setup



mongosh < part2-nosql/mongodb\_operations.js





\## Key Learnings



This project strengthened my understanding of relational schema design, ETL workflows, and data quality validation. I gained hands‑on experience modeling semi‑structured data in MongoDB and designing a star schema optimized for analytics. I also improved my ability to write efficient SQL queries for both operational reporting and warehouse‑level insights.





\## Challenges Faced



1\) Maintaining schema consistency across ETL transformations — resolved by adding validation checks and documenting field mappings clearly.

2\) Handling nested JSON structures in MongoDB — addressed by restructuring documents and using aggregation pipelines to simplify analysis.



