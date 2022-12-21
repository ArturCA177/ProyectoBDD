--CONSULTAS PROYECTO DE FRAGMENTACION

--Credenciales de Acceso

EXEC master.dbo.sp_addlinkedserver
    @server = N'salesAW', 
    @srvproduct=N'', 
    @provider=N'SQLNCLI', 
    @provstr=N'DRIVER={SQL Server};Server=MSI; Initial Catalog=AdventureWorks2019;uid=sa;pwd=@Drackmaster_12;'

EXEC master.dbo.sp_addlinkedserver
    @server = N'productionAW', 
    @srvproduct=N'', 
    @provider=N'SQLNCLI', 
    @provstr=N'DRIVER={SQL Server};Server=MSI; Initial Catalog=AdventureWorks2019;uid=sa;pwd=@Drackmaster_12;'

EXEC master.dbo.sp_addlinkedserver
    @server = N'otrosAW', 
    @srvproduct=N'', 
    @provider=N'SQLNCLI', 
    @provstr=N'DRIVER={SQL Server};Server=MSI; Initial Catalog=AdventureWorks2019;uid=sa;pwd=@Drackmaster_12;'

--a. Determinar el total de las ventas de los productos de la categoría que se provea 
--	 como argumento de entrada en la consulta, para cada uno de los territorios 
--	 registrados en la base de datos o para cada una de las regiones (atributo group
--	 de SalesTerritory) según se especifique como argumento de entrada.

create or alter procedure CA @idCategoria int as
select soh.TerritoryID, sum(t.LineTotal) as Total_Ventas
from salesAW.AdventureWorks2019.Sales.SalesOrderHeader soh
inner join
(select salesorderid, productid, orderqty, linetotal
from salesAW.AdventureWorks2019.Sales.SalesOrderDetail sod
where ProductID in (
	select ProductID
	from productionAW.AdventureWorks2019.Production.Product
	where ProductSubcategoryID in (
		select ProductSubcategoryID
		from productionAW.AdventureWorks2019.Production.ProductSubcategory
		where ProductCategoryID in(
			select ProductCategoryID
			from productionAW.AdventureWorks2019.Production.ProductCategory	
			where ProductCategoryID = @idCategoria
		)
	)
)) as T
on soh.SalesOrderID = t.SalesOrderID
group by soh.TerritoryID
order by soh.TerritoryID




--c. Actualizar el stock disponible en un 5% de los productos de la categoría que se 
--provea como argumento de entrada, en una localidad que también se provea 
--como argumento de entrada en la instrucción de actualización.

create or alter procedure CC @idCategoria int, @idLocation int as
begin
	if not exists(select B.ProductID, C.[Name], A.[Name] as Localidad, B.Quantity as Stock from (
	(select * from productionAW.AdventureWorks2019.Production.[Location] where LocationID = @idLocation) as A
	inner join
	(select * from productionAW.AdventureWorks2019.Production.ProductInventory) as B
	on B.LocationID = A.LocationID
	inner join
	(select * from productionAW.AdventureWorks2019.Production.Product) as C
	on B.ProductID = C.ProductID
	inner join
	(select * from productionAW.AdventureWorks2019.Production.ProductSubcategory where ProductCategoryID = @idCategoria) as D
	on D.ProductSubcategoryID = C.ProductSubcategoryID))
		begin
			print 'Error: No se encontró la categoria ingresada en esa localidad'
		end
	else
	begin
		update productionAW.AdventureWorks2019.Production.ProductInventory
		set Quantity = floor(Quantity*1.05)
		where LocationID = @idLocation 
		and ProductID in (	select ProductID
				from productionAW.AdventureWorks2019.Production.Product
				where ProductSubcategoryID in (select ProductSubcategoryID
												from productionAW.AdventureWorks2019.Production.ProductSubcategory
												where ProductCategoryID=@idCategoria))
			select * from productionAW.AdventureWorks2019.Production.ProductInventory 
			where LocationID = @idLocation 
			and ProductID in (	select ProductID
								from productionAW.AdventureWorks2019.Production.Product
								where ProductSubcategoryID in (select ProductSubcategoryID
																from productionAW.AdventureWorks2019.Production.ProductSubcategory
																where ProductCategoryID=@idCategoria))
	end
end


/*d. Determinar si hay clientes de un territorio que se especifique como argumento 
de entrada, que realizan ordenes en territorios diferentes al que se encuentran. */

create or alter procedure CD as
begin
	if not exists(
	select A.CustomerID as Cliente, A.TerritoryID as Direccion_Cliente, C.TerritoryID as Direccion_Pedido from (
	(select * from salesAW.AdventureWorks2019.Sales.Customer) as A
	inner join
	(select * from salesAW.AdventureWorks2019.Sales.SalesTerritory) as B
	on A.TerritoryID = B.TerritoryID
	inner join
	(select * from salesAW.AdventureWorks2019.Sales.SalesOrderHeader) as C
	on B.TerritoryID = C.TerritoryID)
	where A.TerritoryID != C.TerritoryID)
		print 'No existen clientes que hayan realizado pedidos en territorios distintos'
	else
		print 'Si existen'
		select * from salesAW.AdventureWorks2019.Sales.Customer
end
        
        
        
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
	
	
	
	
	
	
/*h. Determinar el empleado que atendió más ordenes por territorio/región.*/

CREATE PROCEDURE CH AS
BEGIN
	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 1 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory1  INNER JOIN Person.Person as P ON territory1.SalesPersonID = P.BusinessEntityID

	UNION 

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 2 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory2  INNER JOIN Person.Person as P ON territory2.SalesPersonID = P.BusinessEntityID

	UNION

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 3 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory3  INNER JOIN Person.Person as P ON territory3.SalesPersonID = P.BusinessEntityID

	UNION 

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 4 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory4  INNER JOIN Person.Person as P ON territory4.SalesPersonID = P.BusinessEntityID

	UNION

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 5 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory5  INNER JOIN Person.Person as P ON territory5.SalesPersonID = P.BusinessEntityID

	UNION 

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 6 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory6  INNER JOIN Person.Person as P ON territory6.SalesPersonID = P.BusinessEntityID

	UNION

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 7 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory7  INNER JOIN Person.Person as P ON territory7.SalesPersonID = P.BusinessEntityID

	UNION 

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 8 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory8  INNER JOIN Person.Person as P ON territory8.SalesPersonID = P.BusinessEntityID

	UNION

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 9 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory9  INNER JOIN Person.Person as P ON territory9.SalesPersonID = P.BusinessEntityID

	UNION 

	SELECT TerritoryID,SalesPersonID, P.FirstName, P.LastName, Total_Pedidos FROM
	(SELECT TOP 1 * FROM (
	SELECT TerritoryID, SalesPersonID, count(*) as Total_Pedidos
	FROM Sales.SalesOrderHeader WHERE SalesPersonID IS NOT NULL AND TerritoryID = 10 GROUP BY SalesPersonId, TerritoryID ) 
	AS pedidos ORDER BY TerritoryID, Total_Pedidos DESC) AS territory10  INNER JOIN Person.Person as P ON territory10.SalesPersonID = P.BusinessEntityID

END
