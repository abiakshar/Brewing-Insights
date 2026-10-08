import re
import time
import snowflake.connector
from google import genai
from google.genai import types

import os
import streamlit as st

SEMANTIC_CONTEXT = """
Database Table: COFFEE_SHOP_SALES
Columns:
- transaction_id (INT): Unique order identifier.
- transaction_date (VARCHAR): Date string stored in 'DD-MM-YYYY' format (Range: 01-01-2023 to 30-06-2023). ALWAYS use TO_DATE(transaction_date, 'DD-MM-YYYY') when filtering or grouping by date.
- transaction_time (TIME): Time of sale.
- transaction_qty (INT): Quantity of item sold.
- store_id (INT): Store numerical ID.
- store_location (VARCHAR): Location name (e.g., Astoria, Hell's Kitchen, Lower Manhattan).
- product_id (INT): Product identifier.
- unit_price (FLOAT): Price per item.
- product_category (VARCHAR): Broad category (e.g., Coffee, Tea, Bakery).
- product_type (VARCHAR): Specific type (e.g., Gourmet brewed coffee).
- product_detail (VARCHAR): Item name (e.g., Large Latte).

Calculated Metrics:
- Revenue = transaction_qty * unit_price
- Total Revenue = SUM(transaction_qty * unit_price)
- Transaction Count = COUNT(DISTINCT transaction_id)
- Average Order Value (AOV) = SUM(transaction_qty * unit_price) / COUNT(DISTINCT transaction_id)

Rules:
1. Generate ONLY a single executable Snowflake SELECT statement.
2. ALWAYS use SINGLE QUOTES ('...') for string values (e.g., 'Astoria'). NEVER use double quotes ("...") for string values.
3. Escape single quotes in string values by doubling them (e.g., use 'Hell''s Kitchen' instead of "Hell's Kitchen").
4. Do NOT use non-existent columns.
5. Return ONLY the SQL code block inside ```sql ... ```.
6. To get the day of the week, ALWAYS use DAYNAME(TO_DATE(transaction_date, 'DD-MM-YYYY')).
7. EXECUTIVE SUMMARY RULE: For open-ended questions asking "when", "top", "best", or identifying trends, ALWAYS sort the data and append "LIMIT 5" to the query to keep the output concise.
"""
def generate_sql(user_question, api_key):
    # Increased timeout to 45 seconds (45000 ms)
    client = genai.Client(
        api_key=api_key,
        http_options=types.HttpOptions(timeout=120000) 
    )
    prompt = f"{SEMANTIC_CONTEXT}\n\nUser Question: {user_question}\nGenerate a valid Snowflake SQL query inside a markdown code block."
    
    max_attempts = 4
    for attempt in range(max_attempts):
        try:
            print(f"📡 Sending request to AI (Attempt {attempt + 1}/4)...")
            response = client.models.generate_content(
                model="gemini-3.5-flash-lite",
                contents=prompt
            )
            
            sql_match = re.search(r"```sql\n(.*?)\n```", response.text, re.DOTALL | re.IGNORECASE)
            if sql_match:
                return sql_match.group(1).strip()
            return response.text.strip()
            
        except Exception as e:
            # 🚨 THIS WILL PRINT THE EXACT REASON IT IS FAILING
            print(f"⚠️ Error details: {e}")
            print(f"🔄 Retrying in 2 seconds...\n")
            time.sleep(2)
            
    return "ERROR: Could not connect to AI after 4 attempts."

def run_snowflake_query(sql_query):
    conn = snowflake.connector.connect(
        user=st.secrets.get("SNOWFLAKE_USER", os.getenv("SNOWFLAKE_USER", "AbiramiBaskaran")),
        password=st.secrets.get("SNOWFLAKE_PASSWORD", os.getenv("SNOWFLAKE_PASSWORD", "")),
        account=st.secrets.get("SNOWFLAKE_ACCOUNT", os.getenv("SNOWFLAKE_ACCOUNT", "YPTVHMT-PBB01852")),
        warehouse=st.secrets.get("SNOWFLAKE_WAREHOUSE", os.getenv("SNOWFLAKE_WAREHOUSE", "COMPUTE_WH")),
        database=st.secrets.get("SNOWFLAKE_DATABASE", os.getenv("SNOWFLAKE_DATABASE", "BREWING_INSIGHTS")),
        schema=st.secrets.get("SNOWFLAKE_SCHEMA", os.getenv("SNOWFLAKE_SCHEMA", "PUBLIC"))
    )
    cursor = conn.cursor()
    cursor.execute(sql_query)
    results = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]
    conn.close()
    return columns, results

if __name__ == "__main__":
    # ⚠️ Replace with your actual Gemini API Key
    API_KEY = st.secrets.get("GEMINI_API_KEY", os.getenv("GEMINI_API_KEY", "YOUR_GEMINI_API_KEY"))
    
    test_question = "What was the total revenue for Astoria in March 2023?"
    
    print(f"❓ Question: {test_question}")
    
    sql = generate_sql(test_question, API_KEY)
    
    if "ERROR" in sql:
        print(f"❌ Failed to generate SQL.")
    else:
        print(f"\n⚡ Generated SQL Query:\n{sql}\n")
        print("⏳ Executing query in Snowflake...")
        try:
            cols, rows = run_snowflake_query(sql)
            print("✅ Query Result from Snowflake:")
            print(" | ".join(cols))
            print("-" * 35)
            for row in rows:
                print(" | ".join(str(val) for val in row))
        except Exception as e:
            print(f"❌ Execution Error: {e}")
