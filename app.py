import os
import streamlit as st
import pandas as pd
from google import genai
from google.genai import types

# Import the engines you already built!
from text_to_sql import generate_sql, run_snowflake_query
from rag_engine import answer_with_rag

# ⚠️ Paste your API Key here
API_KEY = st.secrets.get("GEMINI_API_KEY", os.getenv("GEMINI_API_KEY", "YOUR_GEMINI_API_KEY"))

def route_question(question):
    """Determines if the question needs SQL data or Document RAG."""
    client = genai.Client(api_key=API_KEY)
    prompt = f"""
    You are a strict routing assistant for a coffee shop database. 
    Analyze the user's question and choose the correct engine.

    Reply ONLY with the word "SQL" if the question:
    - Asks for numbers, revenue, sales, quantities, or top items.
    - Asks about peak hours, busiest times, or when to schedule/arrange staff (since this requires calculating historical transaction volumes).
    
    Reply ONLY with the word "RAG" if the question:
    - Asks about static business rules, return policies, loyalty programs, store opening/closing times, or dataset documentation.
    
    User Question: {question}
    """
    response = client.models.generate_content(
        model="gemini-3.5-flash-lite",
        contents=prompt
    )
    return response.text.strip().upper()

# --- STREAMLIT WEB UI ---
st.set_page_config(page_title="Brewing Insights AI", page_icon="☕", layout="wide")

# Build a Sidebar for Branding and Context
# --- Sidebar: Dataset Quick Reference ---
with st.sidebar.expander("📊 Dataset Quick Reference", expanded=True):
    st.markdown("""
    **Locations:**
    * Astoria
    * Hell's Kitchen
    * Lower Manhattan
    
    **Popular Categories:**
    * Coffee
    * Tea
    * Bakery
    * Drinking Chocolate
    
    **Try asking:**
    * *"What were the top 5 products in Lower Manhattan?"*
    * *"Show me the daily revenue trends for Astoria."*
    * *"What is the return policy?"*
    """)
# Main Page Header
st.title("☕ Welcome to Brewing Insights")
st.markdown("Enter your query below. The AI will automatically route it to the Snowflake database or our internal Knowledge Base.")

# Chat Input
user_question = st.text_input("How can I help you analyze the business today?", placeholder="e.g., What was the total revenue in Astoria?")


if st.button("Ask AI") and user_question:
    with st.spinner("Analyzing intent..."):
        route = route_question(user_question)
    
    if "SQL" in route:
        st.info("🧠 AI routed this question to the Snowflake Database (SQL Path)")
        with st.spinner("Writing and executing SQL..."):
            sql_code = generate_sql(user_question, API_KEY)
            
            if "ERROR" in sql_code:
                st.error("Failed to generate SQL. Try again.")
            else:
                with st.expander("View Generated SQL Code"):
                    st.code(sql_code, language="sql")
                try:
                    cols, rows = run_snowflake_query(sql_code)
                    df = pd.DataFrame(rows, columns=cols)
                    st.success("✅ Query Successful!")
                    
                    # If the result is a single summary number (1 row, 1 column)
                    if df.shape == (1, 1):
                        val = df.iloc[0, 0]
                        # Format as currency if it's a dollar metric
                        if isinstance(val, (int, float)):
                            st.metric(label=cols[0], value=f"${val:,.2f}")
                        else:
                            st.write(f"**Answer:** {val}")
                    else:
                        # Display clean table without row index numbers
                        st.dataframe(df, hide_index=True)
                        
                        # NEW: Automatically generate a visual chart if there are multiple rows
                        if len(df) > 1 and len(cols) >= 2:
                            st.write("### 📊 Visual Trend")
                            # Sets the first column (e.g., Day/Hour) as X-axis and the last metric as Y-axis
                            st.bar_chart(data=df, x=cols[0], y=cols[-1])
                        
                except Exception as e:
                    st.error(f"Execution Error: {e}")
                    
    elif "RAG" in route:
        st.info("🧠 AI routed this question to the Knowledge Base (RAG Path)")
        with st.spinner("Searching documents..."):
            answer = answer_with_rag(user_question, API_KEY)
            st.success("✅ Answer Found!")
            st.write(answer)
