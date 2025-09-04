--1.Create a new database named "CompanyDB."
CREATE DATABASE CompanyDB
GO
USE CompanyDB
GO

--2.Create a schema named "Sales" within the "CompanyDB" database.
CREATE SCHEMA Sales
GO

--3.Create a table named "employees" with columns: 
 CREATE sequence Sales.Employeesq
START WITH 1 
INCREMENT BY 1;

CREATE TABLE Sales.Employees
(
    employee_id INT PRIMARY KEY DEFAULT (NEXT VALUE FOR Sales.EmployeeSeq),
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    salary DECIMAL(10,2)
);
--4.Alter the "employees" table to add a new column named "hire_date" with the data type DATE.
ALTER TABLE Sales.Employees 
ADD hire_date DATE

--5.Add mock data to this table using Mockaroo.
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (1, 'Minni', 'Mollindinia', 1587);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (2, 'Laurel', 'Kyrkeman', 1701);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (3, 'Moses', 'Bickerstasse', 2078);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (4, 'Gary', 'Mangeon', 2629);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (5, 'Sheelah', 'Lent', 2737);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (6, 'Wandis', 'Mandrier', 1874);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (7, 'Katrine', 'Tidy', 2319);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (8, 'Dniren', 'Managh', 2095);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (9, 'Ramonda', 'Largen', 2513);
insert into Sales.Employees (employee_id, first_name, last_name, Salary ) values (10, 'Kain', 'Labrum', 2978);

--DATA MANIPULATION Exercises:
--1.Select all columns from the "employees" table.
SELECT *
FROM  Sales.Employees

--2.Retrieve only the "first_name" and "last_name" columns from the "employees" table.
SELECT first_name , last_name 
FROM  Sales.Employees
WHERE employee_id=1

--3.Retrieve "full name" as a one column from "first_name" and "last_name" columns from the "employees" table.
SELECT first_name + ' ' + last_name AS full_name
FROM Sales.Employees;
WHERE employee_id=1

--4.Show the average salary of all employees. (Use AVG() function)
SELECT AVG(salary) AS average_salary
FROM  Sales.Employees

--5.Select employees whose salary is greater than 50000.
SELECT *
FROM  Sales.Employees
WHERE salary > 50000

--6.Retrieve employees hired in the year 2020.
SELECT *
FROM  Sales.Employees
WHERE YEAR (hire_date)=2020

--7.List employees whose last names start with 'S'.
SELECT *
FROM  Sales.Employees
WHERE last_name LIKE 'S%';

--8.Display the top 10 highest-paid employees.
SELECT TOP (10) *
FROM Sales.Employees
ORDER BY salary DESC;


--9.Find employees with salaries between 40000 and 60000.
SELECT *
FROM  Sales.Employees
WHERE  salary BETWEEN 40000 AND 60000

--10.Show employees with names containing the substring 'man'.
SELECT *
FROM  Sales.Employees
WHERE first_name LIKE '%man%' OR last_name LIKE '%man%';

--11.Display employees with a NULL value in the "hire_date" column.
SELECT *
FROM  Sales.Employees
WHERE  hire_date IS NULL

--12.Select employees with a salary in the set (40000, 45000, 50000).
SELECT *
FROM  Sales.Employees
WHERE  salary IN (40000, 45000, 50000)

--13.Retrieve employees hired between '2020-01-01' and '2021-01-01'.
SELECT *
FROM  Sales.Employees
WHERE hire_date BETWEEN '2020-01-01' AND '2021-01-01';

--14.List employees with salaries in descending order.
SELECT TOP (5) *
FROM Sales.Employees
ORDER BY salary DESC;

--15.Show the first 5 employees ordered by "last_name" in ascending order.
SELECT top(5)
FROM  Sales.Employees
order by last_name 

--16.Display employees with a salary greater than 55000 and hired in 2020.
SELECT *
FROM employees
WHERE salary > 55000
  AND YEAR(hire_date) = 2020

--17.Select employees whose first name is 'John' or 'Jane'.
SELECT *
FROM  Sales.Employees
WHERE first_name IN ('John', 'Jane');

--18.List employees with a salary ≤ 55000 and a hire date after '2022-01-01'.
SELECT *
FROM Sales.Employees
WHERE salary <= 55000
  AND hire_date > '2022-01-01';

--19.Retrieve employees with a salary greater than the average salary.
SELECT *
FROM Sales.Employees
WHERE salary > (SELECT AVG(salary) FROM Sales.Employees);

--20.Display the 3rd to 7th highest-paid employees. (Use OFFSET and FETCH)
SELECT *
FROM Sales.Employees
ORDER BY salary DESC
OFFSET 2 ROWS     
FETCH NEXT 5 ROWS ONLY

--21.List employees hired after '2021-01-01' in alphabetical order.
SELECT *
FROM employees
WHERE hire_date > '2021-01-01'
ORDER BY first_name ASC;

--22.Retrieve employees with a salary > 50000 and last name not starting with 'A'.
SELECT *
FROM  Sales.Employees
WHERE salary > 50000 
AND last_name NOT LIKE 'A%';


--23.Display employees with a salary that is not NULL.
SELECT *
FROM  Sales.Employees
WHERE  salary IS NOT NULL

--24.Show employees with names containing 'e' or 'i' and a salary > 45000.
SELECT *
FROM Sales.Employees
WHERE (first_name LIKE '%[ei]%' OR last_name LIKE '%[ei]%')
  AND salary > 45000;

--JOIN-RELATED EXERCISES

--25.Create a new table named "departments" with columns:
CREATE TABLE Sales.departments 
(
department_id  INT Primary Key
department_name VARCHAR (50),
manager_id INT 
 FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
)
--26.Assign each employee to a department by creating a
--"department_id" column in "employees" and making it a foreign key referencing "departments".department_id.
ALTER TABLE Sales.Employees
ADD department_id INT CONSTRAINT fk_department
FOREIGN KEY (department_id) REFERENCES departments(department_id);


--27.Retrieve all employees with their department names (Use INNER JOIN).
SELECT * 
FROM Sales.Employees e
INNER JOIN Sales.Departments d
 ON e.department_id = d.department_id;

--28.Retrieve employees who don’t belong to any department (Use LEFT JOIN and check for NULL).
SELECT *
FROM Sales.Employees e
LEFT JOIN Sales.Departments d
ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

--29.Show all departments and their employee count (Use JOIN and GROUP BY).
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS employee_count
FROM Sales.Departments d
LEFT JOIN Sales.Employees e
       ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

--30.Retrieve the highest-paid employee in each department (Use JOIN and MAX(salary)).
SELECT d.department_id,
       d.department_name,
       MAX(e.salary) AS highest_salary
FROM Sales.Departments d
JOIN Sales.Employees e
     ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;


