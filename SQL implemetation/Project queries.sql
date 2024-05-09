-- Retrieves all columns for employees with team_email=L1_engineers@dma.com.
SELECT * FROM Employees where team_email='L1_engineers@dma.com';

-- Counts the number of tickets for each distinct resolution code in the Tickets table.
SELECT resolution_code, count(*) as resolution_count 
from tickets 
group by resolution_code 
order by resolution_count desc;

-- Retrieves the names of employees and their corresponding assignment group by 
-- joining the Employees and Team_PDL tables on the team_email.
SELECT Employees.emp_name, Team_PDL.assignment_group 
FROM Employees INNER JOIN Team_PDL 
ON Employees.team_email = Team_PDL.team_email;

-- Retrieves all employees' names and their associated knowledge article numbers, 
-- including those without an article, by performing a left join on the Employees and
--  Knowledge_Articles tables.
SELECT Employees.emp_name, Knowledge_Articles.article_number 
FROM Employees LEFT OUTER JOIN Knowledge_Articles 
ON Employees.emp_id = Knowledge_Articles.emp_id;

-- Selects the names of employees who are listed as L1 engineers by using a subquery 
-- within the WHERE clause.
SELECT emp_name 
FROM Employees 
WHERE emp_id IN (SELECT emp_id FROM L1_engineers);


-- For each employee, counts how many tickets are assigned to them using a correlated subquery.
SELECT emp_name, (SELECT COUNT(*) 
FROM Tickets WHERE Tickets.assigned_to = Employees.emp_name) 
AS num_tickets FROM Employees;



-- Selects the names of employees whose emp_id is greater than or equal to all emp_ids in the 
-- L1_engineers table.
SELECT emp_name FROM Employees WHERE emp_id >= ALL (SELECT emp_id FROM L1_engineers);

-- Selects the names of employees whose emp_id is greater than the emp_id of any engineer in the 
-- L1_engineers table.
SELECT emp_name FROM Employees WHERE emp_id > ANY (SELECT emp_id FROM L1_engineers);

-- Selects the names of employees who have at least one ticket assigned to them.
SELECT emp_name FROM Employees WHERE EXISTS (SELECT * FROM Tickets WHERE Tickets.assigned_to = Employees.emp_name);

-- Selects the names of employees who do not have any tickets assigned to them.
SELECT emp_name FROM Employees WHERE NOT EXISTS (SELECT * FROM Tickets WHERE Tickets.assigned_to = Employees.emp_name);

-- Selects all unique employee IDs from both L1 and Knowledge_articles tables.
SELECT emp_id FROM L1_engineers UNION SELECT emp_id FROM knowledge_articles;

-- For each employee, selects the name and uses a subquery to retrieve the corresponding 
-- assignment group from the Team_PDL table.
SELECT emp_name, (SELECT assignment_group FROM Team_PDL WHERE Team_PDL.team_email = Employees.team_email) as assignment_group FROM Employees;

-- Creates a derived table 'emp_info' with employee names and emails, and then selects from
-- this derived table.
SELECT emp_info.emp_name, emp_info.team_email FROM (SELECT emp_name, team_email FROM Employees) AS emp_info;

