USE sales_analytics;

CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    CustomerSegment VARCHAR(50)
    );


CREATE TABLE Products(
	ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2),
    UnitCost DECIMAL(10,2)

);

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
    CustomerID INT,
    Orderdate DATE,
    FOREIGN KEY (CustomerID)
		REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails(
	OrderID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    Discount DECIMAL(10,2),
    UnitPrice DECIMAL(10,2),
    UnitCost DECIMAL(10,2),
    Revenue DECIMAL(12,2),
    Profit DECIMAL(12,2),
    FOREIGN KEY (OrderID)
		REFERENCES Orders(OrderID),
	FOREIGN key (ProductID)
		REFERENCES Products(ProductID)

);


SHOW TABLES;
    
    