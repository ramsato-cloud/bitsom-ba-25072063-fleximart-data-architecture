# FlexiMart NoSQL Analysis Report

**Student Name:** Ramanathan Sathappan  
**Student ID:** bitsom_ba_25072063  
**Email:** ramsato@gmail.com  
**Date:** 2025-12-28  

---

## Section A: Limitations of RDBMS

Relational databases are highly structured and enforce a fixed schema for all tables. For FlexiMart’s diverse product catalog, an RDBMS can struggle in several ways:

1. **Diverse Attributes:** Products like laptops, shoes, and furniture have different attribute sets (RAM, size, color, material). Storing these in a fixed schema requires many nullable columns or multiple tables, complicating queries.

2. **Frequent Schema Changes:** Adding new product types with unique attributes often requires altering the table schema, which can lead to downtime and data migration challenges.

3. **Nested Data:** Customer reviews with multiple fields and arrays are difficult to represent efficiently in relational tables. Maintaining relationships across multiple tables increases query complexity.

These limitations make RDBMS less flexible for fast‑evolving product catalogs.

---

## Section B: NoSQL Benefits

MongoDB, a document‑oriented NoSQL database, provides several solutions:

1. **Flexible Schema:** Each product can have a unique document structure, allowing different attributes per product without altering the database schema.

2. **Embedded Documents:** Reviews and specifications can be embedded directly within a product document, simplifying queries and reducing joins.

3. **Horizontal Scalability:** MongoDB supports sharding, allowing the database to scale across multiple servers seamlessly to handle large volumes of product and transaction data.

These features make MongoDB ideal for storing diverse and nested product data while keeping queries efficient and the system scalable.

---

## Section C: Trade-offs

While MongoDB is flexible, there are trade-offs compared to MySQL:

1. **Consistency:** MongoDB prioritizes availability and partition tolerance, so strong transactional consistency may require extra effort.

2. **Complex Joins:** Performing complex joins across collections is harder and often less efficient than in relational databases.

Understanding these trade-offs helps in choosing the right database for different use cases.
