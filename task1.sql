-- Use the database
USE suguna;

-- Create the users table
CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY, -- Use IDENTITY for auto-increment
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

select * from users;

-- Describe the table structure (In SQL Server, you can use this command)
EXEC sp_help 'users';  -- This command provides details about the table structure

-- Add a new column gender
ALTER TABLE users ADD gender VARCHAR(10);

-- Drop the column gender
ALTER TABLE users DROP COLUMN gender;

-- Insert data into the users table
INSERT INTO users (username, email, password) 
VALUES 
    ('ramana', 'ramana@gmail.com', 'password2'),
    ('alice', 'alice@example.com', 'password5'),
    ('bob', 'bob@example.com', 'password6'),
    ('charlie', 'charlie@example.com', 'password7'),
    ('david', 'david@example.com', 'password8'),
    ('frank', 'frank@example.com', 'password10'),
    ('suguna', 'suguna2@gmail.com', 'ass123');

-- Select all records from users
SELECT * FROM users;

-- Drop the users table
DROP TABLE users;

-- Delete a user where username is "bob"
DELETE FROM users WHERE username = 'bob';

-- Update username from "david" to "dravida"
UPDATE users SET username = 'dravida' WHERE username = 'david';
