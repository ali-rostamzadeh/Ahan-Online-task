CREATE TABLE SaleTable (
    SalesID INT,
    OrderID INT,
    Customer VARCHAR(50),
    Product VARCHAR(50),
    Date INT,
    Quantity INT,
    UnitPrice INT
);

INSERT INTO SaleTable (SalesID, OrderID, Customer, Product, Date, Quantity, UnitPrice)
VALUES
    (1, 1, 'C1', 'P1', 1, 2, 100),
    (2, 1, 'C1', 'P2', 1, 4, 150),
    (3, 2, 'C2', 'P2', 1, 5, 150),
    (4, 3, 'C3', 'P4', 1, 3, 550),
    (5, 4, 'C4', 'P3', 1, 1, 300),
    (6, 4, 'C4', 'P6', 1, 6, 150),
    (7, 4, 'C4', 'P4', 1, 6, 550),
    (8, 5, 'C5', 'P2', 1, 3, 150),
    (9, 5, 'C5', 'P1', 1, 6, 100),
    (10, 6, 'C1', 'P6', 1, 3, 150),
    (11, 6, 'C1', 'P3', 1, 2, 300),
    (12, 7, 'C3', 'P5', 1, 4, 400),
    (13, 7, 'C3', 'P1', 1, 6, 100),
    (14, 7, 'C3', 'P3', 1, 1, 300),
    (15, 8, 'C5', 'P2', 1, 3, 150),
    (16, 8, 'C5', 'P5', 1, 4, 400),
    (17, 8, 'C5', 'P1', 1, 2, 100),
    (18, 9, 'C2', 'P3', 2, 1, 300),
    (19, 9, 'C2', 'P4', 2, 3, 550),
    (20, 9, 'C2', 'P5', 2, 6, 400),
    (21, 9, 'C2', 'P1', 2, 4, 100),
    (22, 10, 'C4', 'P6', 2, 3, 150),
    (23, 11, 'C6', 'P3', 2, 2, 300),
    (24, 11, 'C6', 'P4', 2, 3, 550),
    (25, 12, 'C7', 'P1', 2, 5, 100),
    (26, 12, 'C7', 'P2', 2, 3, 150),
    (27, 12, 'C7', 'P3', 2, 1, 300),
    (28, 13, 'C2', 'P1', 2, 4, 100),
    (29, 13, 'C2', 'P3', 2, 2, 300),
    (30, 14, 'C6', 'P2', 2, 6, 150),
    (31, 15, 'C4', 'P6', 2, 1, 150),
    (32, 16, 'C1', 'P4', 3, 6, 550),
    (33, 17, 'C2', 'P5', 3, 3, 400),
    (34, 18, 'C8', 'P1', 3, 6, 100),
    (35, 18, 'C8', 'P3', 3, 3, 300),
    (36, 18, 'C8', 'P5', 3, 5, 400),
    (37, 19, 'C9', 'P2', 3, 2, 150),
    (38, 20, 'C2', 'P3', 3, 3, 300),
    (39, 20, 'C2', 'P1', 3, 4, 100),
    (40, 20, 'C2', 'P2', 3, 1, 150);
	
	go

	-------------------------------------------------------------------------------

	CREATE TABLE SaleProfit (
    Product VARCHAR(50),
    ProfitRatio DECIMAL(5, 2)
	);

INSERT INTO SaleProfit (Product, ProfitRatio)
VALUES
    ('P1', 5),
    ('P2', 25),
    ('P3', 10),
    ('P4', 20),
    ('P5', 10)
    ;
     

	 go


	 DROP TABLE [SaleProfit]
	 ----------------------------------------------


	 CREATE TABLE OrganizationChart (
    Id INT,
    Name VARCHAR(50),
    Manager VARCHAR(50),
    ManagerId INT
);

INSERT INTO OrganizationChart (Id, Name, Manager, ManagerId)
VALUES
    (1, 'Ken', NULL, NULL),
    (2, 'Hugo', NULL, NULL),
    (3, 'James', 'Carol', 5),
    (4, 'Mark', 'Morgan', 13),
    (5, 'Carol', 'Alex', 12),
    (6, 'David', 'Rose', 21),
    (7, 'Michael', 'Markos', 11),
    (8, 'Brad', 'Alex', 12),
    (9, 'Rob', 'Matt', 15),
    (10, 'Dylan', 'Alex', 12),
    (11, 'Markos', 'Carol', 5),
    (12, 'Alex', 'Ken', 1),
    (13, 'Morgan', 'Matt', 15),
    (14, 'Jennifer', 'Morgan', 13),
    (15, 'Matt', 'Hugo', 2),
    (16, 'Tom', 'Brad', 8),
    (17, 'Oliver', 'Dylan', 10),
    (18, 'Daniel', 'Rob', 9),
    (19, 'Amanda', 'Markos', 11),
    (20, 'Ana', 'Dylan', 10),
    (21, 'Rose', 'Rob', 9),
    (22, 'Robert', 'Rob', 9),
    (23, 'Fill', 'Morgan', 13),
    (24, 'Antoan', 'David', 6),
    (25, 'Eddie', 'Mark', 4);


go

---------------------------------------------------------

----Question 1

SELECT SUM(Quantity * UnitPrice) AS TotalSales
FROM SaleTable;

go


------Question 2

SELECT COUNT(DISTINCT Customer) AS UniqueCustomers
FROM SaleTable;


go

------Question 3

SELECT Product, SUM(Quantity) AS TotalSold
FROM SaleTable
GROUP BY Product;

go

------Question 4

SELECT ST.Customer, SUM(Quantity * UnitPrice) AS TotalAmount, COUNT(DISTINCT ST.OrderID) AS TotalInvoices, SUM(Quantity) AS TotalItems
FROM SaleTable AS ST
JOIN (SELECT OrderID,Customer 
FROM SaleTable 
GROUP BY OrderID,Customer
HAVING SUM(Quantity * UnitPrice) > 1500) AS ST2
ON ST.Customer= ST2.Customer
GROUP BY ST.Customer;


go

--------Question 5

SELECT
SUM(Quantity * UnitPrice) AS TotalSales,
       SUM((CASE WHEN SP.ProfitRatio IS NULL THEN (Quantity * UnitPrice) * 0.1 ELSE (Quantity * UnitPrice) * SP.ProfitRatio / 100 END)) AS TotalProfit,
       SUM((CASE WHEN SP.ProfitRatio IS NULL THEN (Quantity * UnitPrice) * 0.1 ELSE (Quantity * UnitPrice) * SP.ProfitRatio / 100 END))/SUM(Quantity * UnitPrice) *100 AS Profitrates
FROM SaleTable as ST
 LEFT JOIN SaleProfit as SP ON ST.Product = SP.Product;
go

--------Question 6
SELECT SUM(CustomerCount) AS TotalCustomers
FROM (
  SELECT COUNT(DISTINCT Customer) AS CustomerCount
  FROM SaleTable
  GROUP BY date
) AS SQ;
go
--------------------------------------------------------------------------------------

--------Question B


WITH RecursiveChart as   (
    SELECT Id, Name, 1 AS Level, Manager, ManagerId, CAST(Name AS VARCHAR(MAX)) AS ChartPath
    FROM OrganizationChart
    WHERE Manager IS NULL

    UNION ALL

    SELECT c.Id, c.Name, rc.Level + 1, c.Manager, c.ManagerId, CONCAT(rc.ChartPath, ' > ', c.Name)
    FROM OrganizationChart as c
    INNER JOIN RecursiveChart as rc ON c.ManagerId = rc.Id
)

SELECT Id, Name, Level, Manager, ManagerId, ChartPath 
FROM RecursiveChart as rc
ORDER BY Level, Id;

go
-----------------------------
