create database suguna;
use suguna;
CREATE TABLE Product ( 
    ProductCode INT PRIMARY KEY,          -- Unique product code (assuming it's an integer)
    ProductName NVARCHAR(100),            -- Product name (up to 100 characters)
    Price DECIMAL(10, 2),                 -- Price with two decimal places
    Quantity INT,                         -- Quantity available in stock
    QuantitySold INT                      -- Quantity sold
);

DROP TABLE IF EXISTS Product;

-- Inserting products (you don't need to specify the SINO column)
INSERT INTO Product (ProductCode, ProductName, Price, Quantity, QuantitySold)
VALUES (102, 'Laptop', 12000, 6, 200);

-- Select all products
SELECT * FROM Product;


CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incrementing unique identifier for each order
    OrderDate INT NOT NULL,             -- Date and time when the order was placed
    ProductCode INT NOT NULL,                -- Foreign key reference to Product table (assumed integer)
    QuantityOrdered INT NOT NULL,            -- Quantity of the product ordered
    SalePrice DECIMAL(10, 2) NOT NULL,      -- Sale price with two decimal places
    FOREIGN KEY (ProductCode) REFERENCES Product(ProductCode)  -- Assuming ProductCode references the Product table
);

DROP TABLE IF EXISTS Orders;


-- Inserting values into the Orders table
INSERT INTO Orders (OrderDate, ProductCode, QuantityOrdered, SalePrice)
VALUES 
    (22/10/2020, 102, 2, 1200.50),  -- First order
    (24/10/2024, 102, 1, 600.00),    -- Second order
    (29/10/2023, 102, 3, 1200.50),   -- Third order
    (27/10/2021, 102, 5, 800.00);     -- Fourth order

SELECT * FROM Orders;

CREATE OR ALTER PROCEDURE pr_buy_products
AS
BEGIN
    DECLARE @v_product_code INT,        -- Assuming ProductCode is INT
            @v_price FLOAT;

    -- Retrieve the ProductCode and Price for the specified ProductName
    SELECT @v_product_code = ProductCode, @v_price = Price
    FROM Product
    WHERE ProductName = 'Laptop';        -- Use single quotes

    -- Insert the order into Orders table
    INSERT INTO Orders (OrderDate, ProductCode, QuantityOrdered, SalePrice)
    VALUES (22/02/2020, @v_product_code, 1, (@v_price *1));  -- No need for CAST here

    -- Update the Product table
    UPDATE Product
    SET Quantity = Quantity - 1,  -- Decrease quantity remaining
        QuantitySold = QuantitySold + 1  -- Increase quantity sold
    WHERE ProductCode = @v_product_code;

    PRINT 'Product Sold!';  -- Corrected message
END;

SELECT * FROM Product;
SELECT * FROM Orders;

EXEC pr_buy_products;


