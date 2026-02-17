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