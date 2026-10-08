import time
from google import genai
from google.genai import types

import os
import streamlit as st

def answer_with_rag(user_question, api_key):
    # 1. Read directly from your project's README.md file
    try:
        with open("README.md", "r", encoding="utf-8") as f:
            context = f.read()
    except FileNotFoundError:
        return "ERROR: README.md file not found in the project folder!"

    client = genai.Client(
        api_key=api_key,
        http_options=types.HttpOptions(timeout=120000)
    )
    
    prompt = f"""
    You are a business assistant for Brewing Insights Coffee.
    Answer the user's question using ONLY the context provided below.
    If the answer is not explicitly stated in the context, state that you do not have that information.

    Documentation Context:
    {context}

    User Question: {user_question}
    """

    max_attempts = 3
    for attempt in range(max_attempts):
        try:
            print(f"📡 Querying README Knowledge Base (Attempt {attempt + 1}/3)...")
            response = client.models.generate_content(
                model="gemini-3.5-flash-lite",
                contents=prompt
            )
            return response.text.strip()
            
        except Exception as e:
            print(f"⚠️ Network delay: {e}")
            time.sleep(2)

    return "ERROR: Could not fetch response after 3 attempts."

if __name__ == "__main__":
    # ⚠️ Replace with your actual Gemini API Key
    API_KEY = st.secrets.get("GEMINI_API_KEY", os.getenv("GEMINI_API_KEY", "YOUR_GEMINI_API_KEY"))
    
    # Test with a question answered inside your README.md
    test_question = "What store locations or dataset date ranges are documented?"
    
    print(f"❓ Question: {test_question}\n")
    answer = answer_with_rag(test_question, API_KEY)
    
    print("📖 RAG Answer:")
    print("-" * 40)
    print(answer)
    print("-" * 40)
