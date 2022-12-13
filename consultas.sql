--CONSULTAS PROYECTO DE FRAGMENTACION

--a. Determinar el total de las ventas de los productos de la categoría que se provea 
--	 como argumento de entrada en la consulta, para cada uno de los territorios 
--	 registrados en la base de datos o para cada una de las regiones (atributo group
--	 de SalesTerritory) según se especifique como argumento de entrada.

CREATE PROCEDURE sp_consulta_A
(@cat nvarchar(100)) AS
BEGIN
IF(@cat >=1 AND @cat <= 4 )
	BEGIN
		select soh.TerritoryID, sum(sod.linetotal)
		from sales.SalesOrderDetail sod
		inner join sales.SalesOrderHeader soh
		on sod.SalesOrderID = soh.SalesOrderID
		where sod.ProductID in (
			select ProductID
			from Production.Product
			where ProductSubcategoryID in (
				 select ProductSubcategoryID
				 from Production.ProductSubcategory
				 where ProductCategoryID = @cat
			   )
			)
		group by soh.TerritoryID 
	END
END

EXECUTE sp_consulta_A @cat = 1




--c. Actualizar el stock disponible en un 5% de los productos de la categoría que se 
--provea como argumento de entrada, en una localidad que también se provea 
--como argumento de entrada en la instrucción de actualización.
GO
declare @cat as nvarchar(100)
declare @loc as nvarchar(100)

set @cat = 3
set @loc = 7

UPDATE Production.ProductInventory
SET quantity =  quantity * 1.05
WHERE locationId = @loc
AND productId IN ( 
		SELECT productId
		FROM Production.Product
		WHERE ProductSubcategoryId IN (	
				SELECT ProductSubcategoryId
				FROM Production.ProductSubcategory
				WHERE ProductCategoryId = @cat))
------ SIN ACTUALIZAR, SOLO SELECCIONANDO -------
GO
declare @cat as nvarchar(100)
declare @loc as nvarchar(100)

set @cat = 5
set @loc = 7

SELECT * FROM Production.ProductInventory
WHERE locationId = @loc
AND productId IN ( 
		SELECT productId
		FROM Production.Product
		WHERE ProductSubcategoryId IN (	
				SELECT ProductSubcategoryId
				FROM Production.ProductSubcategory
				WHERE ProductCategoryId = @cat))
        
        
        
--g. Actualizar el correo electrónico de una cliente que se reciba como argumento 
--en la instrucción de actualización
declare @fName nvarchar(100)
declare @lName nvarchar(100)
declare @correo nvarchar(300)

set @fName = 'Syed'
set @lName = 'Abbas'
set @correo = 'prueba@hotmail.com'

UPDATE Person.EmailAddress
SET EmailAddress = @correo
	WHERE BusinessEntityID in(
	SELECT BusinessEntityID FROM Person.Person as p
	WHERE p.FirstName=@fName AND p.LastName=@lName AND p.PersonType='SC')
