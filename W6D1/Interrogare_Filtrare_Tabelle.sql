USE AdventureWorksDW;

SELECT * FROM dimproduct;

SELECT ProductKey AS Chiave_Prodotto, ProductAlternateKey AS Chiave_Prodotto_Alternata, EnglishProductName AS Nome_Prodotto_Inglese, Color AS Colore, StandardCost AS Costo_Standard, FinishedGoodSFlag AS Contrassegno_Prodotti_Finiti FROM dimproduct;

SELECT ProductKey AS Chiave_Prodotto, ProductAlternateKey AS Chiave_Prodotto_Alternata, EnglishProductName AS Nome_Prodotto_Inglese, Color AS Colore, StandardCost AS Costo_Standard, FinishedGoodSFlag AS Contrassegno_Prodotti_Finiti FROM dimproduct where FinishedGoodsFlag = 1;

SELECT ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, Listprice FROM dimproduct where ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%';

SELECT ProductKey, ProductAlternateKey, EnglishProductName, StandardCost, Listprice, Listprice - StandardCost AS Markup FROM dimproduct where ProductAlternateKey like 'FR%' or ProductAlternateKey like 'BK%';

SELECT EnglishProductName, Listprice FROM dimproduct where ListPrice >= 1000 AND ListPrice <= 2000 AND FinishedGoodSFlag = 1;

SELECT * FROM dimemployee;

SELECT * FROM dimemployee where SalesPersonFlag = 1;

SELECT * FROM factresellersales;

SELECT * FROM factresellersales WHERE OrderDate >= (2020-01-01) and ProductKey IN (597,598,477,214);

SELECT SalesAmount - TotalProductCost AS Profitto, factresellersales.* FROM factresellersales WHERE OrderDate >= (2020-01-01) and ProductKey IN (597,598,477,214);