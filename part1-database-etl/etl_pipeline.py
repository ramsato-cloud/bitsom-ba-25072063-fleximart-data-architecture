# etl_pipeline.py
# FlexiMart ETL Pipeline
# Extract → Transform → Load with surrogate key mapping

import pandas as pd
import pymysql
from datetime import datetime

print("DEBUG: Running the correct ETL script")

# ---------------------------------------------------------
# MySQL Connection Config
# ---------------------------------------------------------
db_config = {
    'host': '127.0.0.1',
    'user': 'root',
    'password': 'Harini@2022',
    'database': 'fleximart'
}

# ---------------------------------------------------------
# File Paths
# ---------------------------------------------------------
customers_file = r"C:\Users\ramsa\OneDrive\Desktop\bitsom-ba-25072063-fleximart-data-architecture\data\customers_raw.csv"
products_file = r"C:\Users\ramsa\OneDrive\Desktop\bitsom-ba-25072063-fleximart-data-architecture\data\products_raw.csv"
sales_file = r"C:\Users\ramsa\OneDrive\Desktop\bitsom-ba-25072063-fleximart-data-architecture\data\sales_raw.csv"

# ---------------------------------------------------------
# Extract
# ---------------------------------------------------------
print("Extracting CSV files...")

customers_raw = pd.read_csv(customers_file)
products_raw = pd.read_csv(products_file)
sales_raw = pd.read_csv(sales_file)

print("Extraction complete.\n")

# ---------------------------------------------------------
# Data Quality Counters
# ---------------------------------------------------------
dq = {
    "customers_raw": len(customers_raw),
    "products_raw": len(products_raw),
    "sales_raw": len(sales_raw),
    "customers_duplicates_removed": 0,
    "products_duplicates_removed": 0,
    "sales_duplicates_removed": 0,
    "missing_emails_filled": 0,
    "missing_prices_filled": 0,
    "missing_stock_filled": 0,
    "missing_sales_ids_dropped": 0
}

# ---------------------------------------------------------
# Transform
# ---------------------------------------------------------
print("Transforming data...")

# ---------- CUSTOMERS ----------
customers = customers_raw.copy()
customers.rename(columns={'customer_id': 'customer_id_raw'}, inplace=True)

before = len(customers)
customers.drop_duplicates(inplace=True)
dq["customers_duplicates_removed"] = before - len(customers)

missing_email_mask = customers['email'].isna()
dq["missing_emails_filled"] = missing_email_mask.sum()
customers.loc[missing_email_mask, 'email'] = (
    customers.loc[missing_email_mask, 'customer_id_raw'].astype(str).str.lower() + "@unknown.fleximart"
)

customers['phone'] = customers['phone'].astype(str).str.replace(r'\D', '', regex=True)
customers['phone'] = customers['phone'].apply(
    lambda x: f"+91-{x[-10:]}" if x != 'nan' and len(x) >= 10 else None
)

customers['registration_date'] = pd.to_datetime(
    customers['registration_date'], errors='coerce'
)
customers['registration_date'] = customers['registration_date'].fillna(pd.Timestamp('2025-01-01'))

# ---------- PRODUCTS ----------
products = products_raw.copy()
products.rename(columns={'product_id': 'product_id_raw'}, inplace=True)

before = len(products)
products.drop_duplicates(inplace=True)
dq["products_duplicates_removed"] = before - len(products)

products['category'] = products['category'].str.title()
products['price'] = products['price'].fillna(0).astype(float)
products['stock_quantity'] = products['stock_quantity'].fillna(0).astype(int)

# ---------- SALES ----------
sales = sales_raw.copy()
sales.rename(columns={'customer_id': 'customer_id_raw',
                      'product_id': 'product_id_raw'}, inplace=True)

# ⭐ FIX: Add missing status column
sales['status'] = "Pending"

before = len(sales)
sales.drop_duplicates(inplace=True)
dq["sales_duplicates_removed"] = before - len(sales)

missing_ids_mask = sales['customer_id_raw'].isna() | sales['product_id_raw'].isna()
dq["missing_sales_ids_dropped"] = missing_ids_mask.sum()
sales = sales[~missing_ids_mask]

sales['quantity'] = sales['quantity'].fillna(0).astype(int)
sales['unit_price'] = sales['unit_price'].fillna(0).astype(float)
sales['subtotal'] = sales['quantity'] * sales['unit_price']

sales['transaction_date'] = pd.to_datetime(
    sales['transaction_date'], errors='coerce'
)
sales['transaction_date'] = sales['transaction_date'].fillna(pd.Timestamp.today())
sales.rename(columns={'transaction_date': 'order_date'}, inplace=True)

print("Transformation complete.\n")

# ---------------------------------------------------------
# Load
# ---------------------------------------------------------
print("Connecting to MySQL...")

try:
    conn = pymysql.connect(
        host=db_config['host'],
        user=db_config['user'],
        password=db_config['password'],
        database=db_config['database'],
        cursorclass=pymysql.cursors.Cursor
    )
    cursor = conn.cursor()
    print("Connected.\n")
except Exception as err:
    print("❌ MySQL Connection Error:", err)
    exit(1)

# ---------- LOAD CUSTOMERS ----------
customer_id_map = {}

try:
    print("Loading customers...")
    for _, row in customers.iterrows():
        cursor.execute("""
            INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (
            row['first_name'],
            row['last_name'],
            row['email'],
            row['phone'],
            row['city'],
            row['registration_date'].strftime('%Y-%m-%d')
        ))
        customer_id_map[row['customer_id_raw']] = cursor.lastrowid

    conn.commit()
    print(f"{len(customers)} customers inserted.\n")
except Exception as err:
    print("Error inserting customers:", err)
    conn.rollback()

# ---------- LOAD PRODUCTS ----------
product_id_map = {}

try:
    print("Loading products...")
    for _, row in products.iterrows():
        cursor.execute("""
            INSERT INTO products (product_name, category, price, stock_quantity)
            VALUES (%s, %s, %s, %s)
        """, (
            row['product_name'],
            row['category'],
            float(row['price']),
            int(row['stock_quantity'])
        ))
        product_id_map[row['product_id_raw']] = cursor.lastrowid

    conn.commit()
    print(f"{len(products)} products inserted.\n")
except Exception as err:
    print("Error inserting products:", err)
    conn.rollback()

# ---------- MAP RAW IDs ----------
sales['customer_id'] = sales['customer_id_raw'].map(customer_id_map)
sales['product_id'] = sales['product_id_raw'].map(product_id_map)
sales.dropna(subset=['customer_id', 'product_id'], inplace=True)

# ---------- LOAD ORDERS ----------
order_id_map = {}

try:
    print("Loading orders...")

    orders_unique = sales.groupby(
        ['customer_id', 'order_date', 'status'], as_index=False
    ).agg({'subtotal': 'sum'})

    orders_unique.rename(columns={'subtotal': 'total_amount'}, inplace=True)

    for _, row in orders_unique.iterrows():
        cursor.execute("""
            INSERT INTO orders (customer_id, order_date, total_amount, status)
            VALUES (%s, %s, %s, %s)
        """, (
            int(row['customer_id']),
            row['order_date'].strftime('%Y-%m-%d'),
            float(row['total_amount']),
            row['status']
        ))
        conn.commit()

        order_id_map[
            (int(row['customer_id']), row['order_date'].strftime('%Y-%m-%d'), row['status'])
        ] = cursor.lastrowid

    print(f"{len(orders_unique)} orders inserted.\n")
except Exception as err:
    print("Error inserting orders:", err)
    conn.rollback()

# ---------- LOAD ORDER ITEMS ----------
try:
    print("Loading order_items...")
    inserted_items = 0

    for _, row in sales.iterrows():
        key = (
            int(row['customer_id']),
            row['order_date'].strftime('%Y-%m-%d'),
            row['status']
        )
        order_id = order_id_map.get(key)

        if order_id:
            cursor.execute("""
                INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
                VALUES (%s, %s, %s, %s, %s)
            """, (
                order_id,
                int(row['product_id']),
                int(row['quantity']),
                float(row['unit_price']),
                float(row['subtotal'])
            ))
            inserted_items += 1

    conn.commit()
    print(f"{inserted_items} order_items inserted.\n")
except Exception as err:
    print("Error inserting order_items:", err)
    conn.rollback()

# ---------------------------------------------------------
# Close Connection
# ---------------------------------------------------------
cursor.close()
conn.close()

print("ETL Pipeline completed successfully!")

# ---------------------------------------------------------
# Generate Data Quality Report
# ---------------------------------------------------------
with open("data_quality_report.txt", "w") as f:
    for k, v in dq.items():
        f.write(f"{k}: {v}\n")

print("Data quality report generated: data_quality_report.txt")