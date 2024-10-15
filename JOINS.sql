-- Create the branch table
CREATE TABLE branch (
    branch_id INT PRIMARY KEY ,  -- Use IDENTITY for auto-increment
    br_name VARCHAR(30) NOT NULL,
    addr VARCHAR(200)
);
drop table branch;
-- Create the employee table
CREATE TABLE employee (
    emp_id INT PRIMARY KEY ,  -- Use IDENTITY for auto-increment
    ename VARCHAR(30) NOT NULL,
    job_desc VARCHAR(20),
    salary INT,
    branch_id INT,
    CONSTRAINT FK_branchId FOREIGN KEY(branch_id) REFERENCES branch(branch_id)
);
drop table employee;

-- Insert data into the branch table
INSERT INTO branch (branch_id, br_name, addr) 
VALUES 
    (1, 'Chennai', '16 ABC Road'),
    (2, 'Coimbatore', '120 15th Block'),
    (3, 'Mumbai', '25 XYZ Road'),
    (4, 'Hyderabad', '32 10th Street');

-- Drop the branch table (Uncomment to execute)
-- DROP TABLE branch;

-- Insert data into the employee table
INSERT INTO employee (emp_id, ename, job_desc, salary, branch_id) 
VALUES
    (1, 'Ram', 'ADMIN', 1000000, 2),
    (2, 'Harini', 'MANAGER', 2500000, 2),
    (3, 'George', 'SALES', 2000000, 1),
    (4, 'Ramya', 'SALES', 1300000, 2),
    (5, 'Meena', 'HR', 2000000, 3),
    (6, 'Ashok', 'MANAGER', 3000000, 1),
    (7, 'Abdul', 'HR', 2000000, 1),
    (8, 'Ramya', 'ENGINEER', 1000000, 2),
    (9, 'Raghu', 'CEO', 8000000, 3),
    (10, 'Arvind', 'MANAGER', 2800000, 3),
    (11, 'Akshay', 'ENGINEER', 1000000, 1),
    (12, 'John', 'ADMIN', 2200000, 1),
    (13, 'Abinaya', 'ENGINEER', 2100000, 2),
    (14, 'Vidya', 'ADMIN', 2200000, NULL),
    (15, 'Ranjani', 'ENGINEER', 2100000, NULL);

-- Drop the employee table (Uncomment to execute)
-- DROP TABLE employee;

-- Select all records from employee
SELECT * FROM employee;

-- Select all records from branch
SELECT * FROM branch;

-- Inner join: only matching rows
SELECT employee.emp_id, employee.ename, employee.job_desc, branch.br_name
FROM employee
INNER JOIN branch
ON employee.branch_id = branch.branch_id
ORDER BY employee.emp_id;

-- Same result without using JOIN keyword
SELECT employee.emp_id, employee.ename, employee.job_desc, branch.br_name
FROM employee, branch
WHERE employee.branch_id = branch.branch_id
ORDER BY employee.emp_id;

-- Using table name alias
SELECT e.emp_id, e.ename, e.job_desc, b.br_name
FROM employee AS e
INNER JOIN branch AS b
ON e.branch_id = b.branch_id
ORDER BY e.emp_id;

-- Right join: matched rows + all other rows in right table
SELECT employee.emp_id, employee.ename, employee.job_desc, branch.br_name
FROM employee
RIGHT JOIN branch
ON employee.branch_id = branch.branch_id
ORDER BY employee.emp_id;

-- Left join: matched rows + all other rows in left table
SELECT employee.emp_id, employee.ename, employee.job_desc, branch.br_name
FROM employee
LEFT JOIN branch
ON employee.branch_id = branch.branch_id
ORDER BY employee.emp_id;

-- Cross join: joins each row of first table with every other row of second table
SELECT employee.emp_id, employee.ename, employee.job_desc, branch.br_name
FROM employee
CROSS JOIN branch;

-- Display the employee count in each branch
SELECT b.br_name, COUNT(e.emp_id) AS EmployeeCount
FROM branch AS b
LEFT JOIN employee AS e ON b.branch_id = e.branch_id
GROUP BY b.branch_id, b.br_name;
