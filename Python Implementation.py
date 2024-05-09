import pymysql
import matplotlib.pyplot as plt

# Define the database connection
connection = pymysql.connect(host='localhost',
                             user='ani',
                             password='ani123',
                             database='dma_project2')

# Define the queries
query1 = "SELECT resolution_code, COUNT(*) as resolution_count FROM tickets GROUP BY resolution_code"
query2 = "SELECT emp_name, (SELECT COUNT(*) FROM tickets WHERE tickets.assigned_to = employees.emp_name) as ticket_count FROM employees"
query3 = "SELECT case_status, COUNT(*) as status_count FROM tickets GROUP BY case_status"
query4 = """
SELECT E.emp_id, COUNT(*) as ticket_count 
FROM tickets T
JOIN employees E ON T.assigned_to = E.emp_name
GROUP BY E.emp_id
"""

# Execute the queries and retrieve the results
try:
    with connection.cursor(pymysql.cursors.DictCursor) as cursor:
        cursor.execute(query1)
        result1 = cursor.fetchall()

        cursor.execute(query2)
        result2 = cursor.fetchall()

        cursor.execute(query3)
        result3 = cursor.fetchall()

        cursor.execute(query4)
        result4 = cursor.fetchall()

finally:
    connection.close()

# Process the data for each query
# Pie chart data
resolution_codes = [row['resolution_code'] for row in result1]
resolution_counts = [row['resolution_count'] for row in result1]

# Bar chart data
emp_names = [row['emp_name'] for row in result2]
ticket_counts = [row['ticket_count'] for row in result2]
emp_labels = ['E{}'.format(i+1) for i in range(len(emp_names))]

# Histogram data
case_statuses = [row['case_status'] for row in result3]
status_counts = [row['status_count'] for row in result3]

# Scatter plot data
emp_ids = [row['emp_id'] for row in result4]
resolved_ticket_counts = [row['ticket_count'] for row in result4]

# Pie chart
plt.figure(figsize=(8, 8))
plt.pie(resolution_counts, labels=resolution_codes, autopct='%1.1f%%')
plt.title('Ticket Count by Resolution Code')
plt.show()

# Bar chart with improved labeling
plt.figure(figsize=(12, 6))
plt.bar(emp_labels, ticket_counts, color='orange')
plt.title('Tickets Assigned to Each Employee')
plt.xlabel('Employee Label')
plt.ylabel('Number of Tickets Assigned')
plt.xticks(rotation=90, fontsize=6)
plt.grid(axis='y', linestyle='--', alpha=0.7)
plt.tight_layout()
plt.show()

# Histogram
plt.figure(figsize=(8, 6))
plt.hist(status_counts, bins=len(set(case_statuses)), color='green')
plt.title('Histogram of Tickets per Case Status')
plt.xlabel('Number of Tickets')
plt.ylabel('Frequency')
plt.tight_layout()
plt.show()

# Scatter plot with improved labeling
plt.figure(figsize=(10, 6))
plt.scatter(emp_ids, resolved_ticket_counts, color='red', s=10)  # Adjusted marker size
plt.title('Employee Performance')
plt.xlabel('Employee ID')
plt.ylabel('Number of Tickets Resolved')
plt.xticks(fontsize=8)
plt.yticks(fontsize=8)
plt.tight_layout()
plt.show()
