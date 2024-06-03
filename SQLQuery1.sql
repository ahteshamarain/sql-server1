create database Empdata;
use Empdata;

CREATE TABLE Department (
    DeptId INT PRIMARY KEY,
    DeptName VARCHAR(100),
    Location VARCHAR(100)
);


CREATE TABLE Employee (
    EmpId INT PRIMARY KEY,
    EmpName VARCHAR(100),
    DeptId INT,
    Designation VARCHAR(100),
    DOB DATE,
    Salary INT,
    Gender VARCHAR(10),
    FOREIGN KEY (DeptId) REFERENCES Department(DeptId)
);


INSERT INTO Department (DeptId, DeptName, Location) VALUES
(1, 'Human Resources', 'New York'),
(2, 'Finance', 'London'),
(3, 'IT', 'San Francisco'),
(4, 'Marketing', 'Chicago'),
(5, 'Sales', 'Boston'),
(6, 'Customer Service', 'Seattle'),
(7, 'Legal', 'Washington D.C.'),
(8, 'Research and Development', 'Austin'),
(9, 'Production', 'Detroit'),
(10, 'Logistics', 'Houston');

INSERT INTO Employee (EmpId, EmpName, DeptId, Designation, DOB, Salary, Gender) VALUES
(1, 'John Doe', 1, 'HR Manager', '1980-01-15', 75000, 'Male'),
(2, 'Jane Smith', 2, 'Finance Analyst', '1985-03-22', 68000, 'Female'),
(3, 'Alice Johnson', 3, 'IT Specialist', '1990-06-30', 85000, 'Female'),
(4, 'Robert Brown', 4, 'Marketing Coordinator', '1988-09-12', 62000, 'Male'),
(5, 'Michael Davis', 5, 'Sales Executive', '1983-11-05', 70000, 'Male'),
(6, 'Emily Wilson', 6, 'Customer Service Representative', '1992-02-20', 48000, 'Female'),
(7, 'David Garcia', 7, 'Legal Advisor', '1978-12-15', 92000, 'Male'),
(8, 'Sophia Martinez', 8, 'R&D Engineer', '1995-05-18', 78000, 'Female'),
(9, 'James Rodriguez', 9, 'Production Supervisor', '1981-08-23', 65000, 'Male'),
(10, 'Olivia Anderson', 10, 'Logistics Coordinator', '1987-07-07', 60000, 'Female');


INSERT INTO Department (DeptId, DeptName, Location) VALUES
(11, 'Quality Assurance', 'San Diego'),
(12, 'Public Relations', 'Miami');


ALTER TABLE Employee ADD HireDate DATE;

ALTER TABLE Employee ALTER COLUMN Salary FLOAT;

SELECT * FROM Department;

SELECT * FROM Employee;

SELECT * FROM Employee AS E INNER JOIN Department AS D ON E.DeptId = D.DeptId;

SELECT UPPER(E.EmpName), LOWER(E.Designation), E.*, D.DeptName, D.Location FROM Employee AS E JOIN Department AS D ON E.DeptId = D.DeptId;

SELECT EmpId, EmpName, Designation, DOB, Salary, Gender,  DOB AS Age FROM Employee;


UPDATE Employee
SET HireDate = '2023-09-20'
WHERE EmpId = 3;

UPDATE Employee
SET HireDate = '2022-01-5'
WHERE EmpId = 4;

UPDATE Employee
SET HireDate = '2022-03-25'
WHERE EmpId = 5;

UPDATE Employee
SET HireDate = '2020-07-5'
WHERE EmpId = 6;

UPDATE Employee
SET HireDate = '2023-02-11'
WHERE EmpId = 7;

UPDATE Employee
SET HireDate = '2021-12-28'
WHERE EmpId = 8;

UPDATE Employee
SET HireDate = '2022-10-12'
WHERE EmpId = 9;

UPDATE Employee
SET HireDate = '2021-04-20'
WHERE EmpId = 10;


SELECT * FROM Employee WHERE Designation != 'Manager';

SELECT * FROM Employee ORDER BY HireDate;

SELECT * FROM Employee AS E INNER JOIN Department AS D ON E.DeptId = D.DeptId WHERE D.DeptName IN ('Accounts', 'Purchases');

SELECT * FROM Employee WHERE Salary > 10000;

SELECT * FROM Employee WHERE Salary BETWEEN 50000 AND 100000;

SELECT * FROM Employee WHERE Designation = 'Manager';

SELECT D.DeptId, D.DeptName, D.Location , COUNT(E.EmpId) AS EmployeeCount FROM Department AS D LEFT JOIN Employee E ON D.DeptId = E.DeptId GROUP BY D.DeptId, D.DeptName, D.Location;

SELECT D.DeptId, D.DeptName, AVG(E.Salary) AS AverageSalary FROM Department AS D INNER JOIN Employee E ON D.DeptId = E.DeptId GROUP BY D.DeptId, D.DeptName;

SELECT * FROM Employee AS E INNER JOIN Department AS D ON D.DeptId = E.DeptId WHERE Salary = (SELECT MAX(Salary) FROM Employee);

SELECT * FROM Employee AS E INNER JOIN Department AS D ON D.DeptId = E.DeptId WHERE Salary = (SELECT MIN(Salary) FROM Employee);

SELECT * FROM Employee WHERE Salary > (SELECT AVG(Salary)FROM Employee);

SELECT * FROM Employee WHERE EmpName LIKE 'A%';

SELECT * FROM Employee WHERE DATEDIFF(YEAR, DOB, GETDATE()) > 40;

SELECT *
FROM Employee
WHERE YEAR(HireDate) = YEAR(GETDATE());

SELECT * FROM Employee WHERE Gender = 'Female';

SELECT * FROM Employee WHERE Gender = 'Female' AND Salary > 50000;

SELECT * FROM Employee WHERE DeptId NOT IN ( SELECT DeptId FROM Department WHERE DeptName IN ('Accounts', 'Human Resource'));

SELECT * FROM Employee WHERE LEN(EmpName) > 5 AND LEN(EmpName) < 10;

UPDATE Employee SET Salary = Salary * 1.1 WHERE Salary < 25000;

UPDATE Employee SET Salary = Salary * 1.1 WHERE DeptId = ( SELECT DeptId FROM Department WHERE DeptName = 'Marketing' );

UPDATE Employee SET Salary = 
    CASE 
        WHEN Salary < 10000 THEN Salary * 1.05
        WHEN Salary <= 50000 THEN Salary * 1.1
        ELSE Salary * 1.15
    END;

SELECT 
    EmpId,
    EmpName,
    Experience,
    CASE
        WHEN Experience < 1 THEN 'Nil'
        WHEN Experience <= 3 THEN 100
        WHEN Experience <= 5 THEN 200
        ELSE NULL -- Handle any other cases if needed
    END AS BonusShares
FROM (
    SELECT 
        EmpId,
        EmpName,
        DATEDIFF(YEAR, HireDate, GETDATE()) AS Experience
    FROM Employee
) AS EmpExperience;



























