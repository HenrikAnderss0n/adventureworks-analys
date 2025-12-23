-- VIS 7: Genomsnittligt ordervärde per region och kundtyp
SELECT
    st.Name AS Region,
    CASE 
        WHEN s.BusinessEntityID IS NOT NULL THEN 'Store'
        ELSE 'Individual'
    END AS CustomerType,
    SUM(soh.TotalDue) / COUNT(DISTINCT soh.SalesOrderID) AS AvgOrderValue,
    SUM(soh.TotalDue) AS TotalSales,
    COUNT(DISTINCT soh.SalesOrderID) AS OrderCount
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.SalesTerritory st
    ON soh.TerritoryID = st.TerritoryID
INNER JOIN Sales.Customer c
    ON soh.CustomerID = c.CustomerID
LEFT JOIN Sales.Store s
    ON c.StoreID = s.BusinessEntityID
GROUP BY
    st.Name,
    CASE 
        WHEN s.BusinessEntityID IS NOT NULL THEN 'Store'
        ELSE 'Individual'
    END;
