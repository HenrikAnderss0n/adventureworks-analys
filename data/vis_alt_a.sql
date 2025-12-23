-- Note: A1/A3 använder TotalDue (inkl skatt+frakt). A2/A4 använder LineTotal (varuvärde).


-- Alt A1: KPI per region (översikt)
SELECT
    st.Name AS Region,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(DISTINCT soh.SalesOrderID) AS OrderCount,
    COUNT(DISTINCT soh.CustomerID) AS UniqueCustomers,
    SUM(soh.TotalDue) / COUNT(DISTINCT soh.SalesOrderID) AS AvgOrderValue,
    SUM(soh.TotalDue) / COUNT(DISTINCT soh.CustomerID) AS SalesPerCustomer
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC;



-- Alt A2: Försäljning per region och produktkategori (underlag till heatmap)
SELECT
    st.Name AS Region,
    pc.Name AS CategoryName,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
JOIN Sales.SalesOrderDetail sod
    ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p
    ON sod.ProductID = p.ProductID
JOIN Production.ProductSubcategory psc
    ON p.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc
    ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY st.Name, pc.Name
ORDER BY st.Name, pc.Name;



-- Alt A3: Försäljning per region och månad (underlag till säsongsmönster)
SELECT
    st.Name AS Region,
    DATEFROMPARTS(YEAR(soh.OrderDate), MONTH(soh.OrderDate), 1) AS MonthStart,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name, DATEFROMPARTS(YEAR(soh.OrderDate), MONTH(soh.OrderDate), 1)
ORDER BY MonthStart, st.Name;



-- Alt A4: Top 3 kategorier per region (för tydliga jämförelser)
WITH rc AS (
    SELECT
        st.Name AS Region,
        pc.Name AS CategoryName,
        SUM(sod.LineTotal) AS TotalSales
    FROM Sales.SalesOrderHeader soh
    JOIN Sales.SalesTerritory st
        ON soh.TerritoryID = st.TerritoryID
    JOIN Sales.SalesOrderDetail sod
        ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Production.Product p
        ON sod.ProductID = p.ProductID
    JOIN Production.ProductSubcategory psc
        ON p.ProductSubcategoryID = psc.ProductSubcategoryID
    JOIN Production.ProductCategory pc
        ON psc.ProductCategoryID = pc.ProductCategoryID
    GROUP BY st.Name, pc.Name
)
SELECT Region, CategoryName, TotalSales, CategoryRank
FROM (
    SELECT
        Region,
        CategoryName,
        TotalSales,
        DENSE_RANK() OVER (PARTITION BY Region ORDER BY TotalSales DESC) AS CategoryRank
    FROM rc
) x
WHERE CategoryRank <= 3
ORDER BY Region, CategoryRank;




/* Extra kontroll (används ej i notebooken)
SELECT
    t.Name AS Region,
    SUM(sod.LineTotal) AS TotalSales
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Sales.SalesTerritory t ON soh.TerritoryID = t.TerritoryID
WHERE t.Name IN ('Southwest', 'Germany')
GROUP BY t.Name;
*/
