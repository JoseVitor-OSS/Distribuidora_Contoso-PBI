SELECT dad.OrderID,
     dad.NomeCliente
	  ,dad.TotalVenda
	  ,dad.CategoryName
	  ,dad.ProductName
	  ,dad.nomeFornecedor
	  ,dad.paisfornecedor
	  ,dad.regiaofornecedor
	  ,dad.UnitsOnOrder
	  ,dad.UnitPrice
	  ,dad.UnitsInStock
	  ,dad.Discontinued
	  ,dad.NomeFuncionario
	  ,dad.OrderDate
	  ,dad.RequiredDate
	  ,ship.CompanyName as nomeShipper
	  ,dad.ShipCity
	  ,dad.ShipCountry
	  ,dad.ShippedDate
	  ,dad.ShipRegion
	  
	  
  FROM (SELECT dados3.OrderID,
       dados3.NomeCliente
	  ,dados3.TotalVenda
	  ,dados3.CategoryName
	  ,dados3.ProductName
	  ,forn.nomeFornecedor
	  ,paisfornecedor
	  ,regiaofornecedor
	  ,dados3.UnitsOnOrder
	  ,dados3.UnitPrice
	  ,dados3.UnitsInStock
	  ,dados3.Discontinued
	  ,dados3.NomeFuncionario
	  ,dados3.OrderDate
	  ,dados3.RequiredDate
	  ,dados3.ShipVia
	  ,dados3.ShipCity
	  ,dados3.ShipCountry
	  ,dados3.ShippedDate
	  ,dados3.ShipRegion
	  
	  
  FROM (SELECT 
       dados2.OrderID          
      ,dados2.NomeCliente
	  ,dados2.TotalVenda
	  ,cat.CategoryName
	  ,dados2.ProductName
	  ,dados2.SupplierID
	  ,dados2.UnitsOnOrder
	  ,dados2.UnitPrice
	  ,dados2.UnitsInStock
	  ,dados2.Discontinued
	  ,dados2.NomeFuncionario
	  ,dados2.OrderDate
	  ,dados2.RequiredDate
	  ,dados2.ShipCity
	  ,dados2.ShipCountry
	  ,dados2.ShippedDate
	  ,dados2.ShipRegion
	  ,dados2.ShipVia
	  
  FROM (SELECT semp.OrderID  
      ,semp.NomeCliente
	  ,semp.TotalVenda
	  ,prod.CategoryID
	  ,prod.ProductName
	  ,prod.SupplierID
	  ,prod.UnitsOnOrder
	  ,prod.UnitPrice
	  ,prod.UnitsInStock
	  ,prod.Discontinued
	  ,semp.NomeFuncionario
	  ,semp.OrderDate
	  ,semp.RequiredDate
	  ,semp.ShipCity
	  ,semp.ShipCountry
	  ,semp.ShippedDate
	  ,semp.ShipRegion
	  ,semp.ShipVia
	  
  FROM (SELECT pedidos.OrderID
       ,pedidos.NomeCliente
	  ,(pedidos.Freight+(detail.Quantity*detail.UnitPrice)-Discount) as TotalVenda
	  ,[ProductID]
	  ,pedidos.NomeFuncionario
	  ,pedidos.OrderDate
	  ,pedidos.RequiredDate
	  ,pedidos.ShipCity
	  ,pedidos.ShipCountry
	  ,pedidos.ShippedDate
	  ,pedidos.ShipRegion
	  ,pedidos.ShipVia
	  
  FROM [distribuidora_contoso].[dbo].[Order Details] as detail
  LEFT JOIN (SELECT  [OrderID]
      ,dados.CompanyName as NomeCliente
      ,fun.Fullname as NomeFuncionario
      ,dados.[OrderDate]
      ,dados.[RequiredDate]
      ,dados.[ShippedDate]
      ,dados.[ShipVia]
      ,dados.[Freight]
      ,dados.[ShipCity]
      ,dados.[ShipRegion]
      ,dados.[ShipCountry]
  FROM (SELECT  [OrderID]
      ,cli.CompanyName
      ,[EmployeeID]
      ,[OrderDate]
      ,[RequiredDate]
      ,[ShippedDate]
      ,[ShipVia]
      ,[Freight]
      ,[ShipCity]
      ,[ShipRegion]
      ,[ShipCountry]
  FROM [distribuidora_contoso].[dbo].[Orders] as ord
  LEFT JOIN distribuidora_contoso.dbo.Customers as cli
  ON cli.CustomerID = ord.CustomerID) as dados
  LEFT JOIN (SELECT [EmployeeID]
	  ,(emp.FirstName +' '+ emp.LastName) as Fullname
      ,[Title]
      ,[BirthDate]
      ,[HireDate]
      ,[City]
      ,[Region]
      ,[Country]
      ,[Extension]
      ,[ReportsTo]
  FROM [distribuidora_contoso].[dbo].[Employees] as emp) as fun
  ON fun.EmployeeID = dados.EmployeeID) as pedidos
  ON pedidos.OrderID = detail.OrderID) as semp
  LEFT JOIN distribuidora_contoso.dbo.Products as prod
  ON prod.ProductID = semp.ProductID) as dados2
  LEFT JOIN (SELECT [CategoryID]
      ,[CategoryName]
  FROM [distribuidora_contoso].[dbo].[Categories]) as cat
  ON dados2.CategoryID = cat.CategoryID) as dados3
  LEFT JOIN (SELECT [SupplierID]
      ,[CompanyName] as nomeFornecedor
      ,[City] as fornecedor
      ,[Region] as regiaofornecedor
      ,[Country] as paisfornecedor
  FROM [distribuidora_contoso].[dbo].[Suppliers] as fornecedor) as forn
  ON forn.SupplierID = dados3.SupplierID) as dad
  LEFT JOIN (SELECT [ShipperID]
      ,[CompanyName]
  FROM [distribuidora_contoso].[dbo].[Shippers]) as ship
  ON ship.ShipperID = dad.ShipVia