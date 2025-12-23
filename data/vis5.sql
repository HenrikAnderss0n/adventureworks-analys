-- VIS 5: Top 10 produkter
SELECT TOP (10)
    p.ProductID,
    p.Name AS ProductName,
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderDetail sod
INNER JOIN Production.Product p 
    ON sod.ProductID = p.ProductID
LEFT JOIN Production.ProductSubcategory psc 
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc 
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.ProductID, p.Name, pc.Name
ORDER BY TotalSales DESC;
