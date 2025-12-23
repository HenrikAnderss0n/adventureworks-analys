-- VIS 3: Försäljningstrend över tid (data för linjediagram + analys)
SELECT
    DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1) AS MonthStart,
    COUNT(*) AS OrderCount,
    SUM(TotalDue) AS TotalSales,
    AVG(TotalDue) AS AvgOrderValue
FROM Sales.SalesOrderHeader
GROUP BY DATEFROMPARTS(YEAR(OrderDate), MONTH(OrderDate), 1)
ORDER BY MonthStart;




-- Drill-down: Produktmix (försäljning per kategori) i juni 2025
SELECT pc.Name AS CategoryName, SUM(sod.LineTotal) AS Sales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE soh.OrderDate >= '2025-06-01' AND soh.OrderDate < '2025-07-01'
GROUP BY pc.Name
ORDER BY Sales DESC;



-- Drill-down: Produktmix maj vs juni 2025
SELECT
    DATEFROMPARTS(YEAR(soh.OrderDate), MONTH(soh.OrderDate), 1) AS MonthStart,
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS Sales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE soh.OrderDate >= '2025-05-01' AND soh.OrderDate < '2025-07-01'
GROUP BY DATEFROMPARTS(YEAR(soh.OrderDate), MONTH(soh.OrderDate), 1), pc.Name
ORDER BY MonthStart, Sales DESC;


-- VIS 3 (säsong): Total försäljning per kalender-månad (jan–dec) över alla år
SELECT
    MONTH(OrderDate) AS MonthNo,
    DATENAME(MONTH, DATEFROMPARTS(2025, MONTH(OrderDate), 1)) AS MonthName,
    AVG(CAST(TotalDue AS float)) AS AvgOrderValue,
    SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY MONTH(OrderDate), DATENAME(MONTH, DATEFROMPARTS(2025, MONTH(OrderDate), 1))
ORDER BY MonthNo;

