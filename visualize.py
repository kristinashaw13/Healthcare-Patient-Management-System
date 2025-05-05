import mysql.connector
import matplotlib.pyplot as plt

# Connect to the database
conn = mysql.connector.connect (
    host = "localhost",
    user = "NULL", # NULL for security
    password = "NULL", # NULL for security
    database = "healthcare_db"
)

cursor = conn.cursor()

# Query patient age distribution
cursor.execute("""
    SELECT YEAR(CURDATE()) - YEAR(dob) AS age
    FROM patients
""")
ages = [row[0] for row in cursor.fetchall()]

# Plot histogram
plt.figure(figsize=(8, 6))
plt.hist(ages, bins=10, edgecolor='black', color='skyblue')
plt.title('Patient Age Distribution')
plt.xlabel('Age')
plt.ylabel('Number of Patients')
plt.grid(True)
plt.savefig('patient_age_distribution.png')

# Cleanup
cursor.close()
conn.close()
