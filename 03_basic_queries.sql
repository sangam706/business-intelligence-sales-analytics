##1. DISPLAY all customer

SELECT * FROM customers;

##DISPLAY CUSTOMER NAMES AND REGION

SELECT CustomerName, Region FROM Customers;


##LIST UNIQUE REGIONS

SELECT DISTINCT Region FROM Customers;


## FIND CUSTOMERS IN NORTH REGION

SELECT * FROM Customers 
WHERE Region = 'North';

## APPLY AND CONDITION

SELECT * FROM Customers 
WHERE Region = 'North' AND CustomerSegment = 'Consumer';


## APPLY OR CONDITION
SELECT * FROM Customers 
WHERE Region = 'North'OR Region = 'South' ;


##USE IN 
SELECT * FROM Customers 
WHERE Region  IN ('North','South', 'East');

## USE BETWEEN ON PRODUCT PRICE

select * FROM products
WHERE UnitPrice BETWEEN 500 and 2000;

## SEARCH PRODUCT NMAES WITH LIKE

SELECT * FROM products 
WHERE ProductName LIKE '%Product_1%';


## SORT AND LIMIT PRODUCTS

SELECT ProductName, Unitprice FROM products
ORDER BY UnitPrice DESC LIMIT 5;
