print("Starting test...")

import mysql.connector

print("Import successful")

try:
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Harini@2022"
    )
    print("Connected successfully")
except Exception as e:
    print("Error:", e)