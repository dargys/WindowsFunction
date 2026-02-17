/*1. Ta fram anställda och visa FullName, land och hur många som bor i respektive land. 
Detta ska ske utan Group By. Vad blir skillnaden jft med att ha en Group By med i frågan?*/
SELECT 
	CONCAT(FirstName,' ',LastName),
	Country,
	COUNT(EmployeeID)OVER(PARTITION BY Country)AntalPerLand
FROM Employees

-- Jag skulle inte kunna visa detaljerad information med GROUP BY. 

/*2. Visa för varje produkt:
ProductId
ProductName
CategoryId
UnitPrice
Rank av pris inom samma kategori (descending)
*/

SELECT
	ProductId
	,ProductName
	,CategoryId
	,UnitPrice
	,RANK()OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) RankPrice
FROM
Products

/*3. Lägg på fråga 2 till en ny kolumn med DENSE_RANK() istället för RANK(). Vad blir skillnaden i kolumnerna?*/

SELECT
	ProductId
	,ProductName
	,CategoryId
	,UnitPrice
	,RANK()OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) RankPrice
	,DENSE_RANK() OVER(PARTITION BY CategoryID ORDER BY UnitPrice DESC) DenseRankPrice
FROM
Products

--I DENSE_RANK() följer sin ordning medans RANK() följer en logisk ordning.

/*4. Visa för varje kund:
CustomerID
Land
Totalt antal beställningar
Ranking baserat på beställningar
Rank inom landet
Quartile inom landet
Sortera per land och sedan ranking i fallande ordning
*/

SELECT*
	--CustomerID
	--,Country
FROM
Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID

SELECT*FROM Orders

WITH OrderCount AS(
SELECT
	c.CustomerID
	,c.Country
	,COUNT(o.OrderID) AS TotalOrders
FROM
Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID,c.Country)
SELECT
	CustomerID,
	Country,
	TotalOrders,
	DENSE_RANK()OVER(ORDER BY TotalOrders DESC) GlobalRank,
	RANK()OVER(PARTITION BY Country ORDER BY TotalOrders DESC) CountryRank,
	NTILE(4) OVER(PARTITION BY Country ORDER BY TotalOrders DESC) CountryQuartile
FROM OrderCount
ORDER BY
Country,
GlobalRank DESC;

SELECT 
    c.CustomerID,
    c.Country,
    COUNT(o.OrderID) AS TotalOrders,
    RANK() OVER (ORDER BY COUNT(o.OrderID) DESC) AS OrderRank,
    RANK() OVER (PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) AS CountryRank,
    NTILE(4) OVER (PARTITION BY c.Country ORDER BY COUNT(o.OrderID) DESC) AS QuartileCountry
FROM 
    Customers c
    LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID,
    c.Country
ORDER BY 
    c.Country ASC,
    OrderRank DESC;