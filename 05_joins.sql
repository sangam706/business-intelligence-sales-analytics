##CUSTOMER NAME WITH ORDER ID
SELECT c.CustomerName, o.OrderID 
FROM Customers c
INNER JOIN Orders o
	on c.CustomerID = o.CustomerID;


## PRODUCT NAME, QUANTITY AND REVENUE

SELECT  p.productname, od.Quantity, od.revenue
from orderdetails od
inner join products p
	on od.productid = p.productid;

##ALL CUSTOMER, INCLUDING CUSTOMER WITH NO ORDERS
SELECT c.CustomerID, c.CustomerName, o.OrderID
FROM Customers c
LEFT JOIN Orders o
	ON c.CustomerID = o.CustomerID;


## ALL PRODUCT, INCLUDING UNSOLD PRODUCTS
SELECT p.ProductID, p.ProductName, od.OrderID
FROM orderdetails od
right join products p
	on od.ProductID = p.ProductID


## CUSTOMER, ORDER DATE AND REVENUE

SELECT c.CustomerName, o.Orderdate, od.Revenue
FROM customers c
INNER JOIN Orders o
	ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od
	ON o.orderid = od.orderid;

    


## TOTAL REVENUE PER CUSTOMER

SELECT c.CustomerID, c.CustomerName,
	SUM(od.revenue) AS TotalRevenue
FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRevenue DESC;

##QUANTITY PER PRODUCT
SELECT p.ProductName,
SUM(od.Quantity) AS totalQuantity
FROM Products p
INNER JOIN OrderDetails od ON p.ProductID = od.productid
group by p.productid , p.productname;


##REVENUE BY CATEGORY
SELECT p.Category,
	SUM(od.revenue) as TotalRevenue
FROM products p
inner join OrderDetails od ON p.productid = od.productid
group by p.category
order by TotalRevenue DESC;

##TOP 10 CUSTOMERS BY REVENUE

SELECT c.customerid, c.customername,
	sum(od.revenue) as totalrevenue
from customers c
join orders o on c.customerid = o.customerid
join orderdetails od on o.orderid = od.orderid
group by c.customerid, c.customername
order by totalrevenue DESC
LIMIT 10;

##PRODUCTS NEVER SOLD

SELECT p.productid , productname
from products p 
left join orderdetails od on p.productid = od.productid
where od.productid is null;

