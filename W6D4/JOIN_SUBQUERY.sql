USE AdventureWorksDW;

SELECT * FROM dimproduct;

SELECT * FROM dimproductsubcategory;

-- Esercizio n° 1 di pagina 2

SELECT 
DP.ProductKey,
DP.EnglishProductName,
DPSUB.ProductSubcategoryKey,
DPSUB.EnglishProductSubcategoryName
FROM dimproduct DP
LEFT JOIN dimproductsubcategory DPSUB ON DP.ProductSubcategoryKey = DPSUB.ProductSubcategoryKey;

SELECT * FROM dimproductcategory;

-- Esercizio n° 2 di pagina 2

SELECT 
DP.ProductKey,
DP.EnglishProductName,
DPSUB.ProductSubcategoryKey,
DPSUB.EnglishProductSubcategoryName,
DPCAT.ProductCategoryKey,
DPCAT.EnglishProductCategoryName
FROM dimproduct DP
INNER JOIN dimproductsubcategory DPSUB ON DP.ProductSubcategoryKey = DPSUB.ProductSubcategoryKey
INNER JOIN dimproductcategory DPCAT ON DPCAT.ProductCategoryKey = DPSUB.ProductCategoryKey;

-- Esercizio n° 3 di pagina 2

SELECT DISTINCT DP.* FROM dimproduct DP INNER JOIN factresellersales FRS ON DP.ProductKey = FRS.ProductKey;

-- Esercizio n° 4 di pagina 2

SELECT DP.ProductKey, DP.EnglishProductName 
FROM dimproduct DP
LEFT JOIN factresellersales FRS
ON DP.ProductKey = FRS.ProductKey
WHERE DP.FinishedGoodsFlag = 1
AND FRS.ProductKey IS NULL;

-- Esercizio n° 5 di pagina 2

SELECT FRS.SalesOrderNumber, FRS.OrderQuantity, FRS.SalesAmount, DP.EnglishProductName 
FROM factresellersales FRS 
INNER JOIN dimproduct DP ON FRS.ProductKey = DP.ProductKey;

-- Esercizio n° 1 di pagina 3

SELECT 
FRS.SalesOrderNumber, 
FRS.OrderQuantity, 
FRS.SalesAmount, 
DP.EnglishProductName, 
DPC.EnglishProductCategoryName
FROM factresellersales FRS  
INNER JOIN dimproduct DP 
ON FRS.ProductKey = DP.ProductKey
INNER JOIN dimproductsubcategory DPSUB 
ON DP.ProductSubcategoryKey = DPSUB.ProductSubcategoryKey
INNER JOIN dimproductcategory DPC 
ON DPSUB.ProductCategoryKey = DPC.ProductCategoryKey;

-- Esercizio n° 2 di pagina 3

SELECT * FROM dimreseller;

DESCRIBE dimreseller;

-- Esercizio n° 3 di pagina 3

SELECT * FROM dimgeography;

SELECT 
DR.ResellerKey, 
DR.ResellerName, 
COALESCE(DG.City, 'N/A') AS City,
COALESCE(DG.StateProvinceName, 'N/A') AS State,
COALESCE(DG.EnglishCountryRegionName, 'N/A') AS Country
FROM dimreseller DR
LEFT JOIN dimgeography DG 
ON DR.GeographyKey = DG.GeographyKey;

-- Esercizio n° 4 di pagina 3

SELECT 
FRS.SalesOrderNumber AS OrderNumber,
FRS.SalesOrderLineNumber AS LineNumber,
FRS.OrderDate,
FRS.OrderQuantity AS Quantity, 
FRS.UnitPrice, 
FRS.TotalProductCost, 
DP.EnglishProductName AS ProductName, 
DPC.EnglishProductCategoryName AS CategoryName,
DR.ResellerName,
DG.City, 
DG.StateProvinceName AS State, 
DG.EnglishCountryRegionName AS Country
FROM factresellersales FRS  
INNER JOIN dimproduct DP 
ON FRS.ProductKey = DP.ProductKey
INNER JOIN dimproductsubcategory DPSUB 
ON DP.ProductSubcategoryKey = DPSUB.ProductSubcategoryKey
INNER JOIN dimproductcategory DPC 
ON DPSUB.ProductCategoryKey = DPC.ProductCategoryKey
INNER JOIN dimreseller DR
ON DR.ResellerKey = FRS.ResellerKey
INNER JOIN dimgeography DG
ON DR.GeographyKey = DG.GeographyKey;

-- Simulazione di una soluzione alternativa che prevede l'uso di FULL OUTER JOIN con LEFT JOIN + RIGHT JOIN

SELECT 
    FRS.SalesOrderNumber, 
    FRS.SalesOrderLineNumber, 
    FRS.OrderDate, 
    FRS.OrderQuantity, 
    FRS.UnitPrice, 
    FRS.TotalProductCost, 
    DP.EnglishProductName, 
    DPC.EnglishProductCategoryName,
    DR.ResellerName,
    DG.City, 
    DG.StateProvinceName, 
    DG.EnglishCountryRegionName
FROM factresellersales FRS  
LEFT JOIN dimproduct DP 
    ON FRS.ProductKey = DP.ProductKey
LEFT JOIN dimproductsubcategory DPSUB 
    ON DP.ProductSubcategoryKey = DPSUB.ProductSubcategoryKey
LEFT JOIN dimproductcategory DPC 
    ON DPSUB.ProductCategoryKey = DPC.ProductCategoryKey
LEFT JOIN dimreseller DR
    ON DR.ResellerKey = FRS.ResellerKey
LEFT JOIN dimgeography DG
    ON DR.GeographyKey = DG.GeographyKey

UNION

SELECT 
    FRS.SalesOrderNumber, 
    FRS.SalesOrderLineNumber, 
    FRS.OrderDate, 
    FRS.OrderQuantity, 
    FRS.UnitPrice, 
    FRS.TotalProductCost, 
    DP.EnglishProductName, 
    DPC.EnglishProductCategoryName,
    DR.ResellerName,
    DG.City, 
    DG.StateProvinceName, 
    DG.EnglishCountryRegionName
FROM factresellersales FRS  
RIGHT JOIN dimproduct DP 
    ON FRS.ProductKey = DP.ProductKey
RIGHT JOIN dimproductsubcategory DPSUB 
    ON DP.ProductSubcategoryKey = DPSUB.ProductSubcategoryKey
RIGHT JOIN dimproductcategory DPC 
    ON DPSUB.ProductCategoryKey = DPC.ProductCategoryKey
RIGHT JOIN dimreseller DR
    ON DR.ResellerKey = FRS.ResellerKey
RIGHT JOIN dimgeography DG
    ON DR.GeographyKey = DG.GeographyKey;