# schema_documentation.md

## 1. Entity–Relationship Description

### ENTITY: customers
**Purpose:** Stores personal and contact information about each customer.

**Attributes:**
- **customer_id** – Primary key, auto‑incremented unique identifier.
- **first_name** – Customer’s first name.
- **last_name** – Customer’s last name.
- **email** – Unique email address used for communication.
- **phone** – Standardized phone number (e.g., +91-9876543210).
- **city** – Customer’s city of residence.
- **registration_date** – Date the customer registered.

**Relationships:**
- **1 customer → MANY orders**  
  A customer can place multiple orders. Linked through `orders.customer_id`.

---

### ENTITY: products
**Purpose:** Stores details of all products available for sale.

**Attributes:**
- **product_id** – Primary key, auto‑incremented.
- **product_name** – Name of the product.
- **category** – Standardized product category (e.g., Electronics).
- **price** – Unit selling price.
- **stock_quantity** – Available stock (default 0).

**Relationships:**
- **1 product → MANY order_items**  
  A product can appear in many order lines.

---

### ENTITY: orders
**Purpose:** Represents a customer’s order at the header level.

**Attributes:**
- **order_id** – Primary key, auto‑incremented.
- **customer_id** – Foreign key referencing `customers.customer_id`.
- **order_date** – Date the order was placed.
- **total_amount** – Total value of the order.
- **status** – Order status (default: Pending).

**Relationships:**
- **1 order → MANY order_items**  
  Each order can contain multiple products.

---

### ENTITY: order_items
**Purpose:** Stores line‑level details for each product within an order.

**Attributes:**
- **order_item_id** – Primary key, auto‑incremented.
- **order_id** – Foreign key referencing `orders.order_id`.
- **product_id** – Foreign key referencing `products.product_id`.
- **quantity** – Quantity of the product ordered.
- **unit_price** – Price per unit at the time of purchase.
- **subtotal** – Line subtotal (quantity × unit_price).

**Relationships:**
- **MANY order_items → 1 order**  
- **MANY order_items → 1 product**

---

## 2. Normalization Explanation (3NF Justification)

The FlexiMart database schema is designed to follow Third Normal Form (3NF) to ensure data integrity, reduce redundancy, and avoid anomalies. Each table represents a single, well‑defined entity: customers, products, orders, and order_items. All non‑key attributes in each table depend solely on the primary key. For example, in the **customers** table, attributes such as first_name, last_name, email, phone, and city depend only on `customer_id`. There are no partial dependencies because each table uses a single‑column primary key.

Functional dependencies include:  
- `customer_id → first_name, last_name, email, phone, city, registration_date`  
- `product_id → product_name, category, price, stock_quantity`  
- `order_id → customer_id, order_date, total_amount, status`  
- `order_item_id → order_id, product_id, quantity, unit_price, subtotal`

The schema avoids **update anomalies** by ensuring that customer or product information is stored only once. For example, updating a product’s price requires modifying only the products table, not multiple order records. **Insert anomalies** are prevented because new customers or products can be added without requiring an order. **Delete anomalies** are avoided because deleting an order does not remove the underlying customer or product data. By separating orders and order_items, the design eliminates transitive dependencies and ensures that each table stores only attributes directly related to its primary key, satisfying 3NF.

---

## 3. Sample Data Representation

### customers

| customer_id | first_name | last_name | email                    | phone           | city     | registration_date |
|-------------|------------|-----------|--------------------------|-----------------|----------|-------------------|
| 1           | Raj        | Kumar     | raj.kumar@example.com    | +91-9876543210  | Chennai  | 2024-01-15        |
| 2           | Priya      | Sharma    | priya.sharma@example.com | +91-9123456789  | Mumbai   | 2024-02-10        |

---

### products

| product_id | product_name      | category     | price  | stock_quantity |
|------------|-------------------|--------------|--------|----------------|
| 1          | LED TV 42 Inch    | Electronics  | 32000  | 15             |
| 2          | Organic Rice 5kg  | Groceries    | 650    | 50             |

---

### orders

| order_id | customer_id | order_date | total_amount | status   |
|----------|-------------|------------|--------------|----------|
| 1        | 1           | 2024-01-20 | 32650.00     | Pending  |
| 2        | 2           | 2024-02-15 | 650.00       | Pending  |

---

### order_items

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|---------------|----------|------------|----------|------------|----------|
| 1             | 1        | 1          | 1        | 32000.00   | 32000.00 |
| 2             | 1        | 2          | 1        | 650.00     | 650.00   |