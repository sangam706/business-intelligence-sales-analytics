##1
SELECT ProductID, Productname, UnitPrice
FROM products
WHERE UnitPrice > (SELECT AVG(UnitPrice) from Products);


##2
SELECT ProductID, Productname, UnitPrice
FROM products
WHERE UnitPrice < (SELECT AVG(UnitPrice) from Products);


##3 
SELECT CustomerID, CustomerName
FROM customers 
WHERE CustomerID  IN (SELECT CustomerID FROM Orders);

##4
SELECT CustomerID, CustomerName
FROM customers 
WHERE CustomerID NOT IN (SELECT CustomerID FROM Orders);

##5
SELECT p.ProductID, p.ProductName, x.TotalRevenue
FROM Products p
JOIN (
	select productid, sum(revenue) as totalrevenue
    from orderdetails 
    group by productid
) x on p.productid = x.productid
ORDER BY x. totalrevenue DESC 
LIMIT 1;


##6 

WITH ProductSales AS(
	SELECT ProductID, sum(Revenue) as TotalRevenue
    FROM OrderDetails 
    GROUP BY Productid
)
SELECT * FROM ProductSales 
ORDER BY TotalRevenue DESC;


##7

WITH customersales AS(
	select o.customerid, sum(od.revenue) as TotalRevenue
    from orders o
    join orderdetails od ON o.orderid = od.orderid
    GROUP BY o.customerid
)
select c.customername, cs.TotalRevenue
from customersales cs
join customers c on cs.customerid = c.customerid 
where cs.TotalRevenue > 50000;


##8
WITH Productsales AS(
	select Productid, sum(Revenue) as TotalRevenue
    from orderdetails
    GROUP BY ProductID
    
)
select * from productSales
Where TotalRevenue > (select avg(TotalRevenue) from ProductSales);




## 9
with MonthlySales as (
	select date_format(o.orderdate, '%Y-%m') as salesmonth,
		sum(od.revenue) as TotalRevenue 
	from orders o
    join orderdetails od on o.orderid = od.orderid
    group by date_format(o.orderdate, '%Y-%m')
)
select * from MonthlySales
order by salesmonth;


##10

with customersales as (
	select o.customerid , sum(od.revenue) as TotalRevenue
    from orders o 
    join orderdetails od on o.orderid = od.orderid
    group by o.customerid
)
select c.customername , cs.totalrevenue
from customersales cs
join customers c on cs.customerid = c.customerid
order by cs.totalrevenue DESC;
