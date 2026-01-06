------------------------------------------------------------
-- DIMENSION: dim_date (30 dates: Jan–Feb 2024)
------------------------------------------------------------

INSERT INTO dim_date (date_key, full_date, day_of_week, day_of_month, month, month_name, quarter, year, is_weekend) VALUES
(20240101, '2024-01-01', 'Monday', 1, 1, 'January', 'Q1', 2024, FALSE),
(20240102, '2024-01-02', 'Tuesday', 2, 1, 'January', 'Q1', 2024, FALSE),
(20240103, '2024-01-03', 'Wednesday', 3, 1, 'January', 'Q1', 2024, FALSE),
(20240104, '2024-01-04', 'Thursday', 4, 1, 'January', 'Q1', 2024, FALSE),
(20240105, '2024-01-05', 'Friday', 5, 1, 'January', 'Q1', 2024, FALSE),
(20240106, '2024-01-06', 'Saturday', 6, 1, 'January', 'Q1', 2024, TRUE),
(20240107, '2024-01-07', 'Sunday', 7, 1, 'January', 'Q1', 2024, TRUE),
(20240108, '2024-01-08', 'Monday', 8, 1, 'January', 'Q1', 2024, FALSE),
(20240109, '2024-01-09', 'Tuesday', 9, 1, 'January', 'Q1', 2024, FALSE),
(20240110, '2024-01-10', 'Wednesday', 10, 1, 'January', 'Q1', 2024, FALSE),

(20240111, '2024-01-11', 'Thursday', 11, 1, 'January', 'Q1', 2024, FALSE),
(20240112, '2024-01-12', 'Friday', 12, 1, 'January', 'Q1', 2024, FALSE),
(20240113, '2024-01-13', 'Saturday', 13, 1, 'January', 'Q1', 2024, TRUE),
(20240114, '2024-01-14', 'Sunday', 14, 1, 'January', 'Q1', 2024, TRUE),
(20240115, '2024-01-15', 'Monday', 15, 1, 'January', 'Q1', 2024, FALSE),

(20240201, '2024-02-01', 'Thursday', 1, 2, 'February', 'Q1', 2024, FALSE),
(20240202, '2024-02-02', 'Friday', 2, 2, 'February', 'Q1', 2024, FALSE),
(20240203, '2024-02-03', 'Saturday', 3, 2, 'February', 'Q1', 2024, TRUE),
(20240204, '2024-02-04', 'Sunday', 4, 2, 'February', 'Q1', 2024, TRUE),
(20240205, '2024-02-05', 'Monday', 5, 2, 'February', 'Q1', 2024, FALSE),

(20240206, '2024-02-06', 'Tuesday', 6, 2, 'February', 'Q1', 2024, FALSE),
(20240207, '2024-02-07', 'Wednesday', 7, 2, 'February', 'Q1', 2024, FALSE),
(20240208, '2024-02-08', 'Thursday', 8, 2, 'February', 'Q1', 2024, FALSE),
(20240209, '2024-02-09', 'Friday', 9, 2, 'February', 'Q1', 2024, FALSE),
(20240210, '2024-02-10', 'Saturday', 10, 2, 'February', 'Q1', 2024, TRUE),

(20240211, '2024-02-11', 'Sunday', 11, 2, 'February', 'Q1', 2024, TRUE),
(20240212, '2024-02-12', 'Monday', 12, 2, 'February', 'Q1', 2024, FALSE),
(20240213, '2024-02-13', 'Tuesday', 13, 2, 'February', 'Q1', 2024, FALSE),
(20240214, '2024-02-14', 'Wednesday', 14, 2, 'February', 'Q1', 2024, FALSE),
(20240215, '2024-02-15', 'Thursday', 15, 2, 'February', 'Q1', 2024, FALSE);

------------------------------------------------------------
-- DIMENSION: dim_product (15 products, 3 categories)
------------------------------------------------------------

-- Electronics
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('ELEC001', 'Samsung Galaxy S21', 'Electronics', 'Mobile', 79999),
('ELEC002', 'Apple iPhone 14', 'Electronics', 'Mobile', 99999),
('ELEC003', 'Dell Inspiron 15', 'Electronics', 'Laptop', 65000),
('ELEC004', 'Sony WH-1000XM5', 'Electronics', 'Audio', 34999),
('ELEC005', 'HP Pavilion Gaming', 'Electronics', 'Laptop', 72000);

-- Home Appliances
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('HOME001', 'Philips Air Fryer', 'Home Appliances', 'Kitchen', 8999),
('HOME002', 'LG Washing Machine', 'Home Appliances', 'Cleaning', 32000),
('HOME003', 'Prestige Mixer Grinder', 'Home Appliances', 'Kitchen', 4500),
('HOME004', 'Dyson Vacuum Cleaner', 'Home Appliances', 'Cleaning', 55000),
('HOME005', 'Bajaj Microwave Oven', 'Home Appliances', 'Kitchen', 12000);

-- Footwear
INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('SHOE001', 'Nike Air Max 270', 'Footwear', 'Sports', 15000),
('SHOE002', 'Adidas Ultraboost', 'Footwear', 'Sports', 18000),
('SHOE003', 'Puma Running Shoes', 'Footwear', 'Casual', 12000),
('SHOE004', 'Reebok Classic Leather', 'Footwear', 'Casual', 11000),
('SHOE005', 'Skechers Go Walk', 'Footwear', 'Casual', 9500);

------------------------------------------------------------
-- DIMENSION: dim_customer (12 customers, 4 cities)
------------------------------------------------------------

-- Mumbai
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST001', 'John Doe', 'Mumbai', 'Maharashtra', 'Regular'),
('CUST002', 'Priya Sharma', 'Mumbai', 'Maharashtra', 'Premium'),
('CUST003', 'Amit Verma', 'Mumbai', 'Maharashtra', 'Regular');

-- Delhi
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST004', 'Rohit Singh', 'Delhi', 'Delhi', 'Regular'),
('CUST005', 'Neha Kapoor', 'Delhi', 'Delhi', 'Premium'),
('CUST006', 'Arjun Mehta', 'Delhi', 'Delhi', 'Corporate');

-- Bangalore
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST007', 'Kiran Rao', 'Bangalore', 'Karnataka', 'Regular'),
('CUST008', 'Sneha Iyer', 'Bangalore', 'Karnataka', 'Premium'),
('CUST009', 'Vikram Nair', 'Bangalore', 'Karnataka', 'Corporate');

-- Chennai
INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('CUST010', 'Lakshmi Narayan', 'Chennai', 'Tamil Nadu', 'Regular'),
('CUST011', 'Suresh Kumar', 'Chennai', 'Tamil Nadu', 'Premium'),
('CUST012', 'Meena Raghavan', 'Chennai', 'Tamil Nadu', 'Corporate');

------------------------------------------------------------
-- FACT TABLE: fact_sales (40 transactions)
-- Weekend sales slightly higher, varied quantities
------------------------------------------------------------

INSERT INTO fact_sales (date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
-- Weekday sales
(20240102, 1, 1, 1, 79999, 0, 79999),
(20240103, 2, 4, 1, 99999, 5000, 94999),
(20240104, 3, 7, 2, 65000, 0, 130000),
(20240105, 4, 10, 1, 34999, 0, 34999),
(20240108, 5, 2, 1, 72000, 2000, 70000),

-- Weekend spike
(20240106, 6, 3, 3, 8999, 0, 26997),
(20240107, 7, 5, 1, 32000, 0, 32000),
(20240113, 8, 8, 2, 4500, 0, 9000),
(20240114, 9, 11, 1, 55000, 5000, 50000),
(20240106, 10, 12, 2, 12000, 0, 24000),

-- More weekday sales
(20240109, 11, 6, 1, 15000, 0, 15000),
(20240110, 12, 9, 1, 18000, 0, 18000),
(20240111, 13, 1, 2, 12000, 0, 24000),
(20240112, 14, 4, 1, 11000, 0, 11000),
(20240115, 15, 7, 1, 9500, 0, 9500),

-- February sales
(20240201, 1, 2, 1, 79999, 0, 79999),
(20240202, 2, 3, 1, 99999, 10000, 89999),
(20240203, 3, 5, 2, 65000, 0, 130000),
(20240204, 4, 8, 1, 34999, 0, 34999),
(20240205, 5, 11, 1, 72000, 0, 72000),

-- Weekend spike
(20240203, 6, 6, 3, 8999, 0, 26997),
(20240204, 7, 9, 1, 32000, 0, 32000),
(20240210, 8, 12, 2, 4500, 0, 9000),
(20240211, 9, 1, 1, 55000, 5000, 50000),
(20240210, 10, 4, 2, 12000, 0, 24000),

-- Remaining weekday sales
(20240206, 11, 7, 1, 15000, 0, 15000),
(20240207, 12, 10, 1, 18000, 0, 18000),
(20240208, 13, 2, 2, 12000, 0, 24000),
(20240209, 14, 5, 1, 11000, 0, 11000),
(20240212, 15, 8, 1, 9500, 0, 9500),

-- Additional transactions to reach 40
(20240102, 1, 3, 1, 79999, 0, 79999),
(20240105, 2, 6, 1, 99999, 5000, 94999),
(20240109, 3, 9, 1, 65000, 0, 65000),
(20240112, 4, 12, 1, 34999, 0, 34999),
(20240214, 5, 11, 1, 72000, 0, 72000);
