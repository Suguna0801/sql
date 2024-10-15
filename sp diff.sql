CREATE TABLE Students (
    ID INT IDENTITY(1,1) PRIMARY KEY,         -- Unique identifier for each student
    RollNo NVARCHAR(20) NOT NULL UNIQUE,     -- Unique roll number for the student
    Name NVARCHAR(100) NOT NULL,              -- Student's name
    PhoneNumber NVARCHAR(15),                 -- Student's phone number (optional)
    Email NVARCHAR(100) NOT NULL UNIQUE,      -- Unique email for the student
    Username NVARCHAR(50) NOT NULL UNIQUE     -- Unique username for the student
);

select * from Students;

CREATE OR ALTER PROCEDURE sp_ManageStudent
    @Type NVARCHAR(10),                  -- Operation type: 'INSERT', 'UPDATE', 'DELETE', 'SELECT'
    @RollNo NVARCHAR(20) = NULL,        -- Roll number for student (required for INSERT and UPDATE)
    @Name NVARCHAR(100) = NULL,         -- Name of the student (required for INSERT and UPDATE)
    @PhoneNumber NVARCHAR(15) = NULL,   -- Optional phone number
    @Email NVARCHAR(100) = NULL,        -- Email for the student (required for INSERT and UPDATE)
    @Username NVARCHAR(50) = NULL,      -- Username for the student (required for INSERT and UPDATE)
    @UserID INT = NULL                   -- UserID for identifying records in UPDATE and DELETE
AS
BEGIN
    -- Handle SELECT operation
    IF @Type = 'SELECT'
    BEGIN
        SELECT * FROM Students;
    END

    -- Handle INSERT operation
    ELSE IF @Type = 'INSERT'
    BEGIN
        -- Check if the RollNo already exists
        IF EXISTS (SELECT * FROM Students WHERE RollNo = @RollNo)
        BEGIN
            RAISERROR('Roll number already exists.',16,1);
            RETURN;
        END

        -- Check if the Email already exists
        IF EXISTS (SELECT * FROM Students WHERE Email = @Email)
        BEGIN
            RAISERROR('Email already exists.', 16, 1);
            RETURN;
        END

        -- Check if the Username already exists
        IF EXISTS (SELECT * FROM Students WHERE Username = @Username)
        BEGIN
            RAISERROR('Username already exists.', 16, 1);
            RETURN;
        END

        -- Insert the new student into the Students table
        INSERT INTO Students (RollNo, Name, PhoneNumber, Email, Username)
        VALUES (@RollNo, @Name, @PhoneNumber, @Email, @Username);

        PRINT 'Student registered successfully!';
    END

    -- Handle UPDATE operation
    ELSE IF @Type = 'UPDATE'
    BEGIN
        -- Update the student record
        UPDATE Students
        SET 
            RollNo = COALESCE(@RollNo, RollNo),  -- Only update if provided
            Name = COALESCE(@Name, Name),
            PhoneNumber = COALESCE(@PhoneNumber, PhoneNumber),
            Email = COALESCE(@Email, Email),
            Username = COALESCE(@Username, Username)
        WHERE ID = @UserID;

        PRINT 'Student updated successfully!';
    END

    -- Handle DELETE operation
    ELSE IF @Type = 'DELETE'
    BEGIN
        -- Check if the student exists
        IF NOT EXISTS (SELECT * FROM Students WHERE ID = @UserID)
        BEGIN
            RAISERROR('UserID not found.', 16, 1);
            RETURN;
        END

        -- Delete the student record
        DELETE FROM Students WHERE ID = @UserID;

        PRINT 'Student deleted successfully!';
    END
    ELSE
    BEGIN
        RAISERROR('Invalid operation type. Use INSERT, UPDATE, DELETE, or SELECT.', 16, 1);
    END
END;


EXEC sp_ManageStudent @Type = 'SELECT';
DROP TABLE IF EXISTS Students;


EXEC sp_ManageStudent 
    @Type = 'INSERT', 
    @RollNo = '2024-001', 
    @Name = 'John Doe', 
    @PhoneNumber = '123-456-7890', 
    @Email = 'john.doe@example.com', 
    @Username = 'johndoe';

EXEC sp_ManageStudent 
    @Type = 'INSERT', 
    @RollNo = '2022-001', 
    @Name = 'toe david', 
    @PhoneNumber = '123-456-7890', 
    @Email = 'toedavid@example.com', 
    @Username = 'toedavid';

EXEC sp_ManageStudent 
    @Type = 'INSERT', 
    @RollNo = '2020-001', 
    @Name = 'kamal', 
    @PhoneNumber = '123-456-7890', 
    @Email = 'kamal@example.com', 
    @Username = 'kamal';

EXEC sp_ManageStudent 
    @Type = 'INSERT', 
    @RollNo = '2025-001', 
    @Name = 'Kaviya', 
    @PhoneNumber = '123-456-7890', 
    @Email = 'kaviya@example.com', 
    @Username = 'kaviya';

EXEC sp_ManageStudent 
    @Type = 'UPDATE', 
    @UserID = 1, 
    @RollNo = '2024-002', 
    @Name = 'Jane Doe', 
    @Email = 'jane.doe@example.com';


EXEC sp_ManageStudent 
    @Type = 'DELETE', 
    @UserID = 2;  -- Provide the ID of the student to delete
