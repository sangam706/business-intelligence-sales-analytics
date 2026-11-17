
##1
select sum(Revenue) as TotalRevenue,
	sum(Profit) as TotalProfit,
    sum(Quantity) as TotalQuantitySold
from orderdetails;

##2
select date_format(o.orderdate, '%Y-%m') as SalesMonth,
	sum(od.revenue) as MonthlyRevenue
FROM orders o join orderdetails od on o.orderid = od.OrderID
where o.orderdate >= '2025-01-01'
	and o.orderdate < '2026-01-01'
group by date_format(o.orderdate,'%Y-%m')
order by SalesMonth;


##3
select p.category,
	sum(od.revenue) as TotalRevenue,
	sum(od.Profit) as TotalProfit
from products p join orderdetails od on p.productid = od.productid
group by p.category
order by TotalRevenue DESC;

##4
select p.productid, p.productname,
	sum(od.revenue) as TotalRevenue
from products p join orderdetails od on p.productid = od.productid
group by p.productid, p.productname
order by TotalRevenue DESC
limit 5;

##5
select c.customerid, c.customername,
	sum(od.revenue) as TotalRevenue
from customers c join orders o on c.customerid = o.customerid
join orderdetails od on o.orderid = od.orderid
group by c.customerid, c.customername
order by TotalRevenue DESC
limit 10;


# #6
select c.customerid, c.customername,
	count(distinct o.orderid) as TotalOrders
from customers c left join orders o on c.customerid = o.customerid
group by c.customerid, c.customername
order by TotalOrders DESC;

##7
select c.customerid, c.customername,
	sum(od.revenue) as TotalRevenue
from customers c  join orders o on c.customerid = o.customerid
join orderdetails od on o.orderid = od.orderid
group by c.customerid, c.customername
having sum(od.revenue)>50000
order by TotalRevenue DESC;

##8
select c.Region, sum(od.revenue) as TotalRevenue
From customers c join orders o on c.customerid = o.customerid
join orderdetails od on o.orderid = od.orderid
group by c.Region
order by TotalRevenue DESC
limit 1;

##9
select sum(Revenue) / count(distinct orderid) as AverageOrderValue
from OrderDetails;

##10
select c.customerid, c.customerName
from customers c left join orders o on c.customerid = o.orderid
where o.orderid is null;

##11
with productsales as(
	select productid , sum(Revenue) as TotalRevenue
    from orderdetails group by productid
)
select productid , TotalRevenue,
	dense_rank() over (order by TotalRevenue DESC) as RevenueRank
from productsales;

##12

with CustomerOrders as(
	SELECT o.CustomerID, o.OrderID, od.Revenue,
		ROW_NUMBER() OVER (PARTITION BY o.CustomerID ORDER BY od.Revenue DESC ) AS rn
	FROM Orders o JOIN OrderDetails od ON o.orderID = od.OrderID
)
select CustomerID, OrderID, Revenue
FROM CustomerOrders
WHERE rn = 1;



##13
WITH MonthlySales AS(
	SELECT DATE_FORMAT(o.OrderDate, 'Y%-m%') AS SalesMonth,
		SUM(od.Revenue) AS MonthlyRevenue
	FROM Orders o JOIN OrderDetails od ON o.OrderID = od.Orderid
    GROUP BY DATE_FORMAT(o.OrderDate, 'Y%-m%')
)
SELECT SalesMonth, MonthlyRevenue,
	SUM(MonthlyRevenue) OVER (ORDER BY SalesMonth) AS CumulativeRevenue
FROM MonthlySales
ORDER BY SalesMonth;


##14
WITH MonthlySales AS(
	SELECT DATE_FORMAT(o.OrderDate, 'Y%-m%') AS SalesMonth,
		SUM(od.Revenue) AS MonthlyRevenue
	FROM Orders o JOIN OrderDetails od ON o.OrderID = od.Orderid
    GROUP BY DATE_FORMAT(o.OrderDate, 'Y%-m%')
)
SELECT SalesMonth, MonthlyRevenue,
	LAG(MonthlyRevenue) OVER ( ORDER BY SalesMonth) AS PreviousMonthRevenue,
    MonthlyRevenue - LAG(MonthlyRevenue) OVER (ORDER BY SalesMonth) AS RevenueChange
FROM MonthlySales 
ORDER BY SalesMonth;


##15
SELECT p.ProductID, p.ProductName,
	SUM(od.Profit) AS TotalProfit
FROM Products p join OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
HAVING SUM(od.Profit) < 0
ORDER BY TotalProfit; 

