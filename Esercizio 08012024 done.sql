USE AdventureWorksDW2020;

-- ESERCIZIO: esplora la tabella FactResellerSales
SELECT *
FROM FactResellerSales;

-- 1)esponi l'elenco degli ordini (SalesOrderNumber) e delle transazioni (SalesOrderLineNumber)

SELECT  SalesOrderNumber,SalesOrderLineNumber
FROM FactResellerSales;

-- 2)conta il numero di transazioni per ciascun ordine;

SELECT SalesOrderNumber, 
Count (*) as NTransakion
FROM FactResellerSales
GROUP BY SalesOrderNumber

/* 3)arricchisci il risultato precedente della quantità totale venduta (OrderQuantity) per ordine e
della somma dell'importo (SalesAmount) */

SELECT SalesOrderNumber, 
Count (*) as NTransakion,
Sum (SalesAmount) as TotalSales
FROM FactResellerSales
GROUP BY SalesOrderNumber

-- ESERCIZIO: esistono codici prodotti (ProductKey) che hanno il medesimo nome prodotto (EnglishProductName)?
SELECT   EnglishProductName,
Count (*) as NProductsamename
FROM DimProduct
Group By EnglishProductName;
-- si esistono 

/* ESERCIZIO: analisi prodotti. 
Calcola il fatturato totale, la quantità totale, il numero di transazioni e la media del prezzo di vendita per ciascun prodotto.*/

SELECT s.ProductKey, p.EnglishProductName,
Sum (SalesAmount) as TotalSales,
Sum  (OrderQuantity) as Totalquantity, 
Count (*) As Ntransaction,
AVG (UnitPrice) As AvgPrice 
FROM FactResellerSales as s 
INNER JOIN DimProduct as p 
ON p.ProductKey = s.ProductKey
GROUP BY s.ProductKey, p.EnglishProductName
ORDER BY s.ProductKey,p.EnglishProductName;

/* esistono prodotti mai venduti?*/

Select ProductKey, EnglishProductName
From DimProduct
where ProductKey not in (Select ProductKey From FactResellerSales)

-- esistono 272 prodotti mai venduti.
