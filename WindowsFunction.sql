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
	,RANK()OVER(PARTITION BY CategoryID ORDER BY UnitPrice) RankPrice
FROM
Products