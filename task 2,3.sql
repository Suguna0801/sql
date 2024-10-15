-- Use the database
USE suguna;

-- Create the emp table
CREATE TABLE emp (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Use IDENTITY for auto-increment
    name VARCHAR(50),
    salery INT,
    native VARCHAR(30)
);

-- Describe the emp table (Using sp_help to show table structure)
EXEC sp_help 'emp'; 

-- Insert data into the emp table
INSERT INTO emp (name, salery, native) VALUES
    ('suguna', 20000, 'chennai'),
    ('ramana', 30000, 'salem'),
    ('Brindha', 25000, 'sivakasi'),
    ('mahesh', 15000, 'Tuty');

-- Select all records from emp
SELECT * FROM emp;

-- Select the second highest salary
SELECT TOP 1 salery 
FROM (
    SELECT TOP 2 salery 
    FROM emp 
    ORDER BY salery DESC
) AS OrderedSalaries
ORDER BY salery ASC;  -- Get the second highest salary by ordering ascending

-- Create the empo table
CREATE TABLE empo (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Use IDENTITY for auto-increment
    name VARCHAR(50),
    salery INT,
    native VARCHAR(30),
    dept VARCHAR(10)
);

-- Describe the empo table
EXEC sp_help 'empo'; 

-- Insert data into the empo table
INSERT INTO empo (name, salery, native, dept) VALUES
    ('suguna', 20000, 'chennai', 'CSE'),
    ('ramana', 30000, 'salem', 'BSMS'),
    ('Brindha', 25000, 'sivakasi', 'CSE'),
    ('mahesh', 15000, 'Tuty', 'EEE'),
    ('janani', 39000, 'Tenkasi', 'CSE'),
    ('nikitha', 40000, 'Kovilpatti', 'BSMS'),
    ('Anisha', 12000, 'Nagercoil', 'EEE'),
    ('Pavi', 35000, 'Kovai', 'BSMS'),
    ('Remy', 20000, 'Tvl', 'CSE');

-- Select all records from empo
SELECT * FROM empo;

-- Count the number of employees in department CSE
SELECT COUNT(*) AS CSE 
FROM empo 
WHERE dept = 'CSE';

-- Group by department and count the number of employees in each department
SELECT dept, COUNT(*) AS num_of_employees
FROM empo
GROUP BY dept;
