CREATE TABLE Stud (
    StudentID INT IDENTITY(1,1) PRIMARY KEY, -- Auto-incrementing ID
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL
);

select * from Stud;


CREATE PROCEDURE ManageStudent
    @OperationType VARCHAR(10),  -- 'CREATE', 'READ', 'UPDATE', or 'DELETE'
    @StudentID INT = NULL,        -- NULL for CREATE, must be provided for UPDATE/DELETE
    @FirstName VARCHAR(50) = NULL, -- NULL for READ/DELETE
    @LastName VARCHAR(50) = NULL,  -- NULL for READ/DELETE
    @DateOfBirth DATE = NULL       -- NULL for READ/DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF @OperationType = 'CREATE'
    BEGIN
        INSERT INTO Stud (FirstName, LastName, DateOfBirth)
        VALUES (@FirstName, @LastName, @DateOfBirth);
    END
    ELSE IF @OperationType = 'READ'
    BEGIN
        SELECT StudentID, FirstName, LastName, DateOfBirth
        FROM Stud
        WHERE StudentID = @StudentID;
    END
    ELSE IF @OperationType = 'UPDATE'
    BEGIN
        UPDATE Stud
        SET FirstName = @FirstName,
            LastName = @LastName,
            DateOfBirth = @DateOfBirth
        WHERE StudentID = @StudentID;
    END
    ELSE IF @OperationType = 'DELETE'
    BEGIN
        DELETE FROM Stud
        WHERE StudentID = @StudentID;
    END
    ELSE
    BEGIN
        RAISERROR('Invalid operation type', 16, 1);
    END
END;

select * from Stud;

EXEC ManageStudent 'CREATE', NULL, 'John', 'Doe', '2000-01-01';
EXEC ManageStudent 'CREATE', NULL, 'Joe', 'David', '2010-01-01';
EXEC ManageStudent 'CREATE', NULL, 'Jebin', 'Rose', '2020-01-10';

EXEC ManageStudent 'READ', 2;  -- Assuming 1 is a valid StudentID

EXEC ManageStudent 'UPDATE', 1, 'John', 'Smith', '2000-01-01';

EXEC ManageStudent 'DELETE', 2;  -- Assuming 1 is a valid StudentID
