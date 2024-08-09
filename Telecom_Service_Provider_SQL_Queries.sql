-- Write a query to create Employee Table
CREATE TABLE employee (
    Employee_Id INT PRIMARY KEY NOT NULL,
    Employee_Name VARCHAR(20) NOT NULL,
    Age INT,
    Ssn INT,
    Salary_salary_Id1 INT,
    Department_Department_Id INT REFERENCES department(DepartmentId)
);

-- Write a query to create Worklocation Table
CREATE TABLE worklocation (
    Location_Id INT NOT NULL,
    LocationName VARCHAR(50),
    NumberOfEmployees INT
);

-- Write a query to create Salary Table
CREATE TABLE salary (
    salaryId INT PRIMARY KEY NOT NULL,
    Employee_name VARCHAR(30),
    DepartmentID INT,
    Salary INT,
    Employee_Id INT REFERENCES employee(Employee_Id)
);

-- Write a query to create Salesperson Table
CREATE TABLE salesperson (
    SalesPerson_Id INT PRIMARY KEY NOT NULL,
    Employee_Id INT REFERENCES employee(Employee_Id)
);

-- Write a query to create Customer Table
CREATE TABLE customer (
    Customer_Id INT PRIMARY KEY NOT NULL,
    Customer_Name VARCHAR(50),
    Sex CHAR(1),
    Age INT,
    SalesPerson_salesPerson_Id INT REFERENCES salesperson(SalesPerson_Id)
);

-- Write a query to create Orders Table
CREATE TABLE orders (
    OrderId INT PRIMARY KEY NOT NULL,
    OrderType VARCHAR(25),
    OrderStatus VARCHAR(50),
    Customer_CustomerId INT REFERENCES customer(Customer_Id)
);

-- Write a query to create Tracking Table
CREATE TABLE tracking (
    TrackingId INT PRIMARY KEY NOT NULL,
    TrackingStatus VARCHAR(50),
    Orders_ordersId INT REFERENCES orders(OrderId)
);

-- Write a query to create Billinginformation Table
CREATE TABLE billinginformation (
    BillNumber INT PRIMARY KEY NOT NULL,
    IncludedDate INT,
    DataUsed FLOAT,
    BalancedData FLOAT,
    Tax FLOAT
);

-- Write a query to create Phonenumber Table
CREATE TABLE phonenumber (
    AccountNumber INT PRIMARY KEY NOT NULL,
    PhoneNumber INT NOT NULL,
    BillingInformation_BillNumber INT NOT NULL REFERENCES billinginformation(BillNumber)
);

-- Write a query to create Callrecords Table
CREATE TABLE callrecords (
    CallId INT PRIMARY KEY NOT NULL,
    CallDuration DATE,
    CallStartTime DATE,
    CallEndTime DATE,
    PhoneNumber_AccountNumber INT NOT NULL REFERENCES phonenumber(AccountNumber)
);

-- Write a query to create Planinclusions Table
CREATE TABLE planinclusions (
    PlanID INT PRIMARY KEY NOT NULL,
    Date VARCHAR(40),
    TalkTime VARCHAR(40),
    TextMessage VARCHAR(45),
    PlanCost INT NOT NULL
);

-- Write a query to create Simdata Table
CREATE TABLE simdata (
    SimId INT PRIMARY KEY NOT NULL,
    SimType VARCHAR(30),
    Customer_CustomerId INT NOT NULL REFERENCES customer(Customer_Id),
    PhoneNumber_AccountNumber INT NOT NULL REFERENCES phonenumber(AccountNumber),
    Plans_PlanNumber INT NOT NULL REFERENCES plans(PlanNumber)
);

-- Write a query to list out all the ‘department’ details.
SELECT * FROM department;

-- Write a query to list out Employee_name, AGE from ‘employee’ table.
SELECT Employee_Name, Age FROM employee;

-- Write a query to display the details of the employee that starts with the EMPLOYEE_NAME ‘A’.
SELECT * FROM employee WHERE Employee_Name LIKE 'A%';

-- Write a query to display the details of the ‘employee’ whose Age is above 25.
SELECT * FROM employee WHERE Age > 25;

-- Write a query to display all the employees whose salary is between 20000 to 70000.
SELECT * FROM salary WHERE Salary BETWEEN 20000 AND 70000;

-- Write a query to display all the records from the employee table ordered by Employee Name in Ascending order.
SELECT * FROM employee ORDER BY Employee_Name;

-- Write a query to find the highest salary in the table ‘salary’.
SELECT MAX(Salary) FROM salary;

-- Write a query to find the second highest salary from the table ‘salary’.
SELECT MAX(Salary) FROM salary
WHERE Salary < (SELECT MAX(Salary) FROM salary);

-- Write a query to count employees whose age is more than 35 from the table employee.
SELECT COUNT(*) FROM employee WHERE Age > 35;

-- Write a query that displays employee names appear more than once in the ‘EMPLOYEE’ table.
SELECT Employee_Name FROM employee
GROUP BY Employee_Name HAVING COUNT(*) > 1;

-- Write a query to retrieve the names of employees and their respective departments using an INNER JOIN operation on the ‘employee’ and ‘department’ tables.
SELECT e.Employee_Name, d.DepartmentName
FROM employee e
INNER JOIN department d
ON e.Department_Department_ID = d.DepartmentId;

-- Write a query to retrieve all the information from the ‘employee’ table and the ‘department’ table for employees who work in the ‘CustomerCare’ department.
SELECT e.Employee_Id, e.Employee_Name, e.Age, e.Ssn, e.Salary_Salary_Id1, e.Department_Department_Id,
d.DepartmentId, d.DepartmentName
FROM employee e
INNER JOIN department d
ON e.Department_Department_ID = d.DepartmentId
AND d.DepartmentName = 'CustomerCare';

-- Write a query to retrieve the Employee ID, Work Location ID, Location Name and Number of Employees for all employees who have been assigned to a work location using the employee work location and work location tables.
SELECT e.Employee_Employee_Id, e.Work_Location_Location_Id,
w.LocationName, w.NumberOfEmployees
FROM employeeworklocation e
FULL JOIN worklocation w
ON e.Work_Location_Location_Id = w.Location_Id;

-- Write a query to retrieve all the columns from the customer and orders tables where the Customer_ID in the Customer tables matches the Customer_ID in the Orders table.
SELECT c.*, o.*
FROM customer c
FULL JOIN orders o
ON c.Customer_Id = o.Customer_CustomerId;

-- Write a query to retrieve all the columns from the customer and orders tables where the Order_Status in the orders tables is ‘Shipped’.
SELECT c.*, o.*
FROM customer c
FULL JOIN orders o
ON c.Customer_Id = o.Customer_CustomerId
AND o.OrderStatus = 'Shipped';

-- Write a query to display a list of all employees along with their respective employee ID, employee name, age, and department ID.
SELECT e.Employee_Id, e.Employee_Name, e.Age, d.DepartmentId
FROM employee e
LEFT JOIN department d
ON e.Department_Department_Id = d.DepartmentId;

-- Write a query to count employees in each department along with the department name.
SELECT d.DepartmentName, COUNT(e.Department_Department_Id)
FROM department d
INNER JOIN employee e
ON e.Department_Department_Id = d.DepartmentId
GROUP BY d.DepartmentId, DepartmentName;

-- Write a query to determine the total salary expense for each department along with the department name. Alias name => TOTAL_SALARY
SELECT d.DepartmentName, SUM(s.Salary) AS "TOTAL_SALARY"
FROM department d
INNER JOIN salary s
ON d.DepartmentId = s.DepartmentID
GROUP BY d.DepartmentId, DepartmentName;

-- Write a query to list all the employees along with their respective employee name, age, department name, and salary.
SELECT e.Employee_Name, e.Age, d.DepartmentName, s.Salary
FROM employee e
INNER JOIN department d
ON e.Department_Department_Id = d.DepartmentId
INNER JOIN salary s
ON e.Employee_ID = s.Employee_Id;

-- Write a query to display the department name and age of the employee with the name ‘Alpana Sharan’.
SELECT e.Employee_Name, e.Age, d.DepartmentName
FROM employee e
INNER JOIN department d
ON e.Department_Department_Id = d.DepartmentId
AND e.Employee_Name = 'Alpana Sharan';

-- Write a query to display the table ‘employee’ information whose salary is greater than 30000 and location=’Boston’
SELECT * FROM employee
WHERE Salary_Salary_Id1 IN
(SELECT SalaryId FROM salary WHERE Salary > 30000)
AND Employee_ID IN
(SELECT Employee_Employee_Id FROM employeeworklocation
WHERE Work_Location_Location_Id IN
(SELECT Location_Id FROM worklocation WHERE LocationName = 'Boston'));

-- Write a query to display the ‘employee’ information whose salary is greater than 25000 and location=’Boston’ and department=’InformationTechnology’
SELECT * FROM employee
WHERE Salary_Salary_Id1 IN
(SELECT SalaryId FROM salary WHERE Salary > 25000)
AND Employee_ID IN
(SELECT Employee_Employee_Id FROM employeeworklocation
WHERE Work_Location_Location_Id IN
(SELECT Location_Id FROM worklocation WHERE LocationName = 'Boston'))
AND Department_Department_Id IN
(SELECT DepartmentId FROM department WHERE DepartmentName = 'InformationTechnology');

-- Write a query to display the Employee_Name, Age from table ‘employee’ whose age is greater than 40 and department=’InformationTechnology’.
SELECT Employee_Name, Age
FROM employee
WHERE Age > 40
AND Department_Department_Id IN
(SELECT DepartmentId FROM department WHERE DepartmentName = 'InformationTechnology');

-- Write a query to display the ‘employee’ information whose age is above 30 and salary > 50000 using subquery.
SELECT * FROM employee
WHERE Age > 30
AND Employee_ID IN
(SELECT Employee_Id FROM salary WHERE Salary > 50000);

-- Write a query to count the ‘employees’ who are all working under department=’InformationTechnology’.
SELECT COUNT(*)
FROM employee
WHERE Department_Department_Id IN
(SELECT DepartmentId FROM department WHERE DepartmentName = 'InformationTechnology');




