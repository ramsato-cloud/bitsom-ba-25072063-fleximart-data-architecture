# Part 2 – NoSQL Database Analysis (FlexiMart)

This section of the project focuses on evaluating MongoDB as a suitable NoSQL database for FlexiMart’s expanding and diverse product catalog. It includes a theoretical justification report and basic MongoDB operations.

---

## 📌 Task 2.1 – NoSQL Justification Report

File: **NoSQL_analysis.md**

This report explains:

### **A. Limitations of RDBMS**
- Difficulty handling products with diverse attributes  
- Frequent schema changes when adding new product types  
- Inefficiency in storing nested data such as customer reviews  

### **B. Benefits of MongoDB**
- Flexible schema for varying product structures  
- Embedded documents for reviews and specifications  
- Horizontal scalability through sharding  

### **C. Trade-offs**
- Weaker multi-document transactional consistency  
- Limited support for complex joins compared to SQL  

This document provides a clear comparison between relational and NoSQL approaches and justifies why MongoDB is suitable for FlexiMart’s evolving catalog.

---

## 📌 Task 2.2 – MongoDB Operations

File: **nosql_operations.js** (or `.txt` depending on your submission format)

This file includes basic MongoDB operations such as:

### **1. Insert Operations**
- Insert a product with flexible attributes  
- Insert embedded customer reviews  

### **2. Query Operations**
- Find products by category  
- Retrieve products with embedded reviews  
- Filter products based on dynamic attributes  

### **3. Update Operations**
- Add new attributes to existing product documents  
- Push new reviews into embedded arrays  

### **4. Delete Operations**
- Remove products  
- Remove specific embedded reviews  

These operations demonstrate how MongoDB handles flexible schemas and nested structures.

---

## 📁 Folder Structure (Recommended)

```
Part2_NoSQL/
│
├── NoSQL_analysis.md
├── nosql_operations.js
└── README.md
```

---

## ✅ Learning Outcomes:

- Understand when NoSQL is preferable over relational databases  
- Demonstrate the ability to model flexible, schema-less product data  
- Use MongoDB CRUD operations effectively  
- Evaluate trade-offs between SQL and NoSQL systems  

