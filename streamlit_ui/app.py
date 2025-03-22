import streamlit as st
import mysql.connector
import pandas as pd

# MySQL Connection
def get_connection():
    return mysql.connector.connect(
        host="localhost",   # Change this to your MySQL host
        user="root",   # Change this to your MySQL username
        password="Rocklight@123", # Change this to your MySQL password
        database="gym"
    )

# Function to fetch data
def fetch_data(query):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(query)
    data = cursor.fetchall()
    column_names = [desc[0] for desc in cursor.description]
    conn.close()
    return pd.DataFrame(data, columns=column_names)

# Function to execute queries (Insert, Update, Delete)
def execute_query(query, values=None):
    conn = get_connection()
    cursor = conn.cursor()
    if values:
        cursor.execute(query, values)
    else:
        cursor.execute(query)
    conn.commit()
    conn.close()

# Sidebar Navigation
st.sidebar.title("Gym Management System")
page = st.sidebar.radio("Go to", ["Home", "Members", "Trainers", "Classes", "Payments", "Feedback", "Run SQL Query"])

# Home Page
if page == "Home":
    st.title(" Gym Management Dashboard")
    st.write("Welcome to the Gym Management System. Use the sidebar to navigate.")

# Members Page
elif page == "Members":
    st.title(" Member Management")

    # Fetch members
    members = fetch_data("SELECT M_id, M_name, M_age, M_gender, M_contact_info, M_status FROM Member")
    st.dataframe(members)

    # Add new member
    st.subheader(" Add New Member")
    name = st.text_input("Name")
    age = st.number_input("Age", min_value=10, max_value=100)
    gender = st.selectbox("Gender", ["Male", "Female", "Other"])
    contact = st.text_input("Contact")
    status = st.selectbox("Status", ["Active", "Inactive"])
    if st.button("Add Member"):
        execute_query("INSERT INTO Member (M_name, M_age, M_gender, M_contact_info, M_status) VALUES (%s, %s, %s, %s, %s)", 
                      (name, age, gender, contact, status))
        st.success("Member added successfully!")

# Trainers Page
elif page == "Trainers":
    st.title(" Trainer Management")
    trainers = fetch_data("SELECT T_id, T_name, T_specialization, T_experience, T_availability FROM Trainer")
    st.dataframe(trainers)

# Classes Page
elif page == "Classes":
    st.title(" Class Schedule")
    classes = fetch_data("SELECT C_id, C_name, C_date, C_time, C_location FROM Class_Schedule")
    st.dataframe(classes)

# Payments Page
elif page == "Payments":
    st.title(" Payment History")
    payments = fetch_data("SELECT P_id, M_id, P_amount, P_date, P_method FROM Payment")
    st.dataframe(payments)

# Feedback Page
elif page == "Feedback":
    st.title(" Member Feedback")
    feedback = fetch_data("SELECT M_id, T_id, FR_rating, FR_comments FROM Feedback_Review")
    st.dataframe(feedback)

# Run SQL Query Page
elif page == "Run SQL Query":
    st.title(" Run SQL Query")
    query = st.text_area("Enter your SQL query:")
    
    if st.button("Execute Query"):
        try:
            if query.strip().lower().startswith("select"):
                # If it's a SELECT query, fetch and display results
                result = fetch_data(query)
                st.dataframe(result)
            else:
                # For other queries (INSERT, UPDATE, DELETE)
                execute_query(query)
                st.success("Query executed successfully!")
        except Exception as e:
            st.error(f"Error: {e}")
