##1
SELECT OrderID, Revenue,
	ROW_NUMBER() OVER (ORDER BY Revenue DESC) as RowNum
FROM OrderDetails;

##2

with ProductSales AS(
	SELECT ProductID, SUM(Revenue) AS TotalRevenue
    from orderdetails group by ProductID
)
SELECT productid, totalrevenue,
	rank() OVER (ORDER BY TotalRevenue DESC) as RevenueRank
From ProductSales;


##3
with ProductSales AS(
	SELECT ProductID, SUM(Revenue) AS TotalRevenue
    from orderdetails group by ProductID
)
SELECT productid, totalrevenue,
	dense_rank() OVER (ORDER BY TotalRevenue DESC) as RevenueRank
From ProductSales;

##4
select productid, orderid , revenue,
	RANK() OVER ( partition by productid order by revenue desc) as productrank
from orderdetails;


##5
with RankOrders as(
	select productid, orderid , revenue,
    row_number() over ( partition by productid order by revenue desc) as rn 
    from orderdetails
)

select productid, orderid, revenue
from RankOrders

where rn = 1;


##6
select OrderID, Revenue,
	SUM(revenue) over (order by orderid) as RunningRevenue
from orderdetails;


##7
select OrderID, Revenue,
	LAG(revenue) over (order by orderid) as PreviousRevenue
from orderdetails;

##8
select OrderID, Revenue,
	LEAD(revenue) over (order by orderid) as NextRevenue
from orderdetails;

##9
select OrderID, Revenue,
	LAG(revenue) over() as OverallAverageRevenue
from orderdetails;

##10
with CustomerSales as (
	select o.CustomerID, sum(od.revenue) as totalRevenue
	From Orders o join orderdetails od on  o.orderid = od.orderid
	group by o.customerid)

select customerid , totalrevenue, 
	rank() over (order by totalrevenue DESC) as CustomerRank
from customersales;