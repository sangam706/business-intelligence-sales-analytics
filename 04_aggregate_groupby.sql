## TOTAL REVENUE
SELECT SUM(Revenue) AS TotalRevenue FROM orderdetails;

##TOTAL PROFIT
SELECT SUM(Profit) AS TotalProfit FROM orderdetails;

##AVERAGE REVENUE PER DETAIL ROW
SELECT AVG(Revenue) AS AverageRevenue FROM orderdetails;

## MINIMUM MAXIMUM PRODUCT PRICE
SELECT MIN(UnitPrice) AS MINIMUMPRICE,
	MAX(UnitPrice) AS MAXIMUMPRICE 
FROM Products;

##COUNT ALL ORDERS

SELECT COUNT(*) AS TotalOrders FROM Orders;

##CUSTOMER PER REGION

SELECT Region, COUNT(*) AS customerCount FROM customers
GROUP BY Region;

##REVENUE BY PRODUCT
SELECT ProductID, SUM(Revenue) AS TotalRevenue From OrderDetails
GROUP BY ProductID;

##QUANTITY BY PRODUCT 
SELECT ProductID, SUM(Quantity) AS TotalQuantity
FROM OrderDetails GROUP BY ProductID;


##PRODUCTS WITH REVENUE ABOVE 100000
SELECT ProductID, sum(Revenue) AS TotalRevenue
From OrderDetails GROUP BY ProductID
HAVING SUM(Revenue)> 100000;

##AVERAGE UNIT PRICE BY CATEGORY

SELECT Category, AVG(UnitPrice) AS AverageUnitPrice
FROM Products GROUP BY Category;





