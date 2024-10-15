-- Create the branch table
CREATE TABLE branch (
    branch_id INT PRIMARY KEY IDENTITY(1,1),  -- Use IDENTITY for auto-increment
    br_name VARCHAR(30) NOT NULL,
    addr VARCHAR(200)
);
drop table branch;
-- Create the employee table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY IDENTITY(1,1),  -- Use IDENTITY for auto-increment
    ename VARCHAR(30) NOT NULL,
    job_desc VARCHAR(20),
    salary INT,
    branch_id INT,
    CONSTRAINT FK_branchId FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);
drop table employee;

-- Insert data into the branch table
INSERT INTO branch (br_name, addr) 
VALUES 
    ('Chennai', '16 ABC Road'),
    ('Coimbatore', '120 15th Block'),
    ('Mumbai', '25 XYZ Road'),
    ('Hyderabad', '32 10th Street');

-- Drop the branch table (Uncomment to execute)
-- DROP TABLE branch;

-- Insert data into the employee table
INSERT INTO employee (ename, job_desc, salary, branch_id) 
VALUES
    ('Ram', 'ADMIN', 1000000, 2),
    ('Harini', 'MANAGER', 2500000, 2),
    ('George', 'SALES', 2000000, 1),
    ('Ramya', 'SALES', 1300000, 2),
    ('Meena', 'HR', 2000000, 3),
    ('Ashok', 'MANAGER', 3000000, 1),
    ('Abdul', 'HR', 2000000, 1),
    ('Ramya', 'ENGINEER', 1000000, 2),
    ('Raghu', 'CEO', 8000000, 3),
    ('Arvind', 'MANAGER', 2800000, 3),
    ('Akshay', 'ENGINEER', 1000000, 1),
    ('John', 'ADMIN', 2200000, 1),
    ('Abinaya', 'ENGINEER', 2100000, 2),
    ('Vidya', 'ADMIN', 2200000, NULL),
    ('Ranjani', 'ENGINEER', 2100000, NULL);

-- Drop the employee table (Uncomment to execute)
-- DROP TABLE employee;

-- Select all records from employee
SELECT * FROM employee;

-- Select all records from branch
SELECT * FROM branch;

-- Displays employee list in Chennai Branch
SELECT * FROM employee
WHERE branch_id = (SELECT branch_id
                   FROM branch
                   WHERE br_name = 'Chennai');

-- Displays the employees with minimum salary
SELECT * FROM employee
WHERE salary = (SELECT MIN(salary)
                FROM employee);

-- Displays the branches containing at least one ADMIN
SELECT b.branch_id, b.br_name
FROM branch AS b
WHERE EXISTS 
(SELECT *
 FROM employee AS e 
 WHERE e.job_desc = 'ADMIN' AND b.branch_id = e.branch_id);

-- Displays the branch info in which any employee earns more than 2.5 million
SELECT b.branch_id, b.br_name
FROM branch AS b
WHERE b.branch_id IN
(SELECT e.branch_id FROM employee AS e
 WHERE e.salary > 2500000);

-- Displays employees not working in Chennai or Coimbatore
SELECT * FROM employee 
WHERE branch_id NOT IN (SELECT branch_id FROM branch
                         WHERE br_name IN ('Chennai', 'Coimbatore'));

-- Show indexes on employee table
-- SQL Server does not have a direct equivalent for "SHOW INDEX"; use the following command:
EXEC sp_helpindex 'employee';



-- Create an index on the employee's name
CREATE INDEX idx_name ON employee(ename);			

-- Create an index on the employee's salary
CREATE INDEX idx_salary ON employee(salary);

-- Drop the salary index (Uncomment to execute)
DROP INDEX idx_salary ON employee;
