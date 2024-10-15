create database suguna;
use suguna;
create table sales(
name varchar(50),
India int,
USA int,
UK int
);
select * from sales;

insert into sales values('sugu',98,99,94), ('kavi',99,95,91);

select name,country,amount from sales
UNPIVOT
(
amount 
for country in (India,USA,UK)
)As unpivotexa


CREATE TABLE sales_unpivoted (
    name VARCHAR(50),
    country VARCHAR(50),
    amount INT
);

INSERT INTO sales_unpivoted VALUES
('sugu', 'India', 98),
('sugu', 'USA', 99),
('sugu', 'UK', 94),
('kavi', 'India', 99),
('kavi', 'USA', 95),
('kavi', 'UK', 91);

SELECT name, 
       [India], 
       [USA], 
       [UK]
FROM sales_unpivoted
PIVOT (
    MAX(amount) 
    FOR country IN ([India], [USA], [UK])
) AS piv;
