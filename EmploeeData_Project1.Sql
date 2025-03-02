--DATA MANIPULATION LANGUAGE (DML)

--SELECT STATEMENT 

--Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’.

SELECT [EmpId],
       [FullName]
FROM [dbo].[Employee_Details$]
WHERE [ManagerId] = '986'

--Write an SQL query to fetch the different projects available from the EmployeeSalary table.

SELECT [Project]
FROM [dbo].[Employee_Salary$]

--Write an SQL query to fetch the count of employees working in project ‘P1’

SELECT COUNT(*) AS EmployeeCount
FROM [dbo].[Employee_Salary$]
WHERE [Project] = 'P1'

--Write an SQL query to find the maximum, minimum, and average salary of the employees.
SELECT MIN(SALARY) AS MINSALARY,
       MAX(SALARY) AS MAXSALARY,
	   AVG(SALARY) AS AVGSALARY
FROM [dbo].[Employee_Salary$]

--Write an SQL query to find the employee id whose salary lies in the range of 9000 and 15000

SELECT [EmpId]
FROM [dbo].[Employee_Salary$]
WHERE SALARY BETWEEN 9000 AND 15000

--Write an SQL query to fetch those employees who live in Toronto and work under the manager with ManagerId – 321.

SELECT *
FROM [dbo].[Employee_Details$]
WHERE [City] = 'TORONTO' AND [ManagerId] = '321'

--Write an SQL query to fetch all the employees who either live in California or work under a manager with ManagerId – 321

SELECT *
FROM [dbo].[Employee_Details$]
WHERE [City] = 'CALIFORNIA' OR [ManagerId] = '321'

--Write an SQL query to fetch all those employees who work on Projects other than P1

SELECT *
FROM [dbo].[Employee_Salary$]
WHERE [Project] != 'P1'

--Write an SQL query to display the total salary of each employee adding the Salary with Variable value.

SELECT 
      (SALARY + VARIABLE) AS TOTALSALARY
FROM [dbo].[Employee_Salary$]

--Write an SQL query to fetch the employees whose name begins with any two characters, followed by a text “hn” and ends with 
--any sequence of characters.

SELECT *
FROM [dbo].[Employee_Details$]
WHERE [FullName] LIKE ('__HN%')

--Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.

SELECT [EmpId]
FROM [dbo].[Employee_Details$]

UNION

SELECT [EmpId]
FROM [dbo].[Employee_Salary$]

--Write a query to fetch the EmpFname from the EmployeeInfo table in the upper case and use the ALIAS name as EmpName.

SELECT UPPER([EmpFname])
FROM [dbo].['Employee Info$']

--Write a query to fetch the number of employees working in the department ‘HR’.

SELECT COUNT(*) AS [Department]
FROM [dbo].['Employee Info$']
WHERE [Department] = 'HR'

--Write a query to get the current date.

SELECT GETDATE() AS DATE 

--Write a query to retrieve the first four characters of  EmpLname from the EmployeeInfo table.

SELECT SUBSTRING([EmpLname], 1,4) AS FIRSTFOURCHARS
FROM [dbo].['Employee Info$']

--Write a query to fetch only the place name(string before brackets) from the Address column of EmployeeInfo table.

SELECT SUBSTRING([Address], 1, CHARINDEX('(',[Address]) -1) AS [Address]
FROM [dbo].['Employee Info$']
WHERE CHARINDEX('(',[Address]) >0

--Write a query to create a new table that consists of data and structure copied from the other table.

SELECT *
INTO MyWay
FROM [dbo].[Employee_Details$]

DROP TABLE MyWay

--Write a query to find all the employees whose salary is between 50000 to 100000.

SELECT *
FROM [dbo].['Employee position$']
WHERE SALARY BETWEEN 50000 AND 100000

--Write a query to find the names of employees that begin with ‘S’

SELECT *
FROM [dbo].['Employee Info$']
WHERE [EmpFname] LIKE ('S%')

--Write a query to fetch top N records.

SELECT TOP 2 [Salary]
FROM [dbo].['Employee position$']

--Write a query to retrieve the EmpFname and EmpLname in a single column as “FullName”. The first name and 
--the last name must be separated with space.

SELECT CONCAT([EmpFname], ' ', [EmpLname]) AS FullName
FROM [dbo].['Employee Info$']

--Write a query find number of employees whose DOB is between 02/05/1970 to 31/12/1995 and are grouped according to gender

SELECT [Gender], COUNT(*) AS EmployeeCount
FROM [dbo].['Employee Info$']
WHERE [DOB] BETWEEN '1970-05-02' AND '1995-12-31' 
GROUP BY [Gender]

--Write a query to fetch all the records from the EmployeeInfo table ordered by EmpLname in descending order 
--and Department in the ascending order.

SELECT [EmpLname],
       [Department]
FROM [dbo].['Employee Info$']
ORDER BY [EmpLname] DESC, [Department] ASC

--Write a query to fetch details of employees whose EmpLname ends with an alphabet ‘A’ and contains five alphabets.

SELECT *
FROM [dbo].['Employee Info$']
WHERE [EmpLname] LIKE ('____A')

--Write a query to fetch details of all employees excluding the employees with first names, “Sanjay” and “Sonia” 
--from the EmployeeInfo table.

SELECT *
FROM [dbo].['Employee Info$']
WHERE [EmpFname] <> 'SANJAY' AND [EmpFname] != 'SONIA'

--Write a query to fetch details of employees with the address as “DELHI(DEL)”

SELECT *
FROM [dbo].['Employee Info$']
WHERE [Address] = 'DELHI(DEL)'

--Write a query to fetch all employees who also hold the managerial position.

SELECT *
FROM [dbo].['Employee position$']
WHERE [EmpPosition] = 'MANAGER'

--Write a query to fetch the department-wise count of employees sorted by department’s count in ascending order

SELECT [Department], COUNT(*) AS EmployeeCount
FROM [dbo].['Employee Info$']
GROUP BY [Department]
ORDER BY [Department] ASC

--Write a query to fecth Male employees in HR department

SELECT *
FROM [dbo].['Employee Info$']
WHERE [Gender] = 'M' AND [Department] = 'HR'

--Write a SQL query to retrieve employee details from EmployeeInfo table who have a date of joining in the EmployeePosition table

SELECT EI.*
FROM [dbo].['Employee Info$'] EI
INNER JOIN [dbo].['Employee position$'] EP
ON EI.EmpID = EP.EmpID
WHERE [DateOfJoining] IS NOT NULL 

--Write a query to retrieve two minimum and maximum salaries from the EmployeePosition table

WITH MINSALARY AS (
      SELECT TOP 2 [Salary]
	  FROM [dbo].['Employee position$']
	  ORDER BY [Salary] ASC
	  ),
	  MAXSALARY AS (
	  SELECT TOP 2 [Salary]
	  FROM [dbo].['Employee position$']
	  ORDER BY [Salary] DESC
	  )
SELECT [Salary] FROM MINSALARY

UNION 

SELECT [Salary] FROM MAXSALARY 
