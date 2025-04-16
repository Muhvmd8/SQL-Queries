--------------------- Part 1 ---------------------

-- 1 

Select  * from (
Select I.Ins_Id,
I.Ins_Name,
I.Salary,
I.Dept_Id , 
Row_Number() over (partition by I.Dept_Id order by Salary desc) Rank
From Management.Instructor I
) D
Where Rank <= 2 and Dept_Id is not null;


-- 2

Select * From 
(
Select  
* , 
Row_Number() Over (Partition By Dept_Id Order By NewId()) Rank
From Student S
Where Dept_Id is not null
) R1
Where R1.Rank = 1

--------------------- Part 2 ---------------------
-- 1

Select 
soh.SalesOrderID,
soh.ShipDate
from AdventureWorks2012.Sales.SalesOrderHeader soh
Where OrderDate between '7/28/2002' and '7/29/2014'

-- 2 

Select P.Name , P.ProductID
From AdventureWorks2012.Production.Product P
Where P.StandardCost < 110

-- 3

Select P.Name , P.ProductID
From AdventureWorks2012.Production.Product P
Where P.Weight is null;

-- 4

Select P.Name , P.ProductID
From AdventureWorks2012.Production.Product P
Where P.Color in ('Silver', 'Black', 'Red')

-- 5

Select P.Name , P.ProductID
From AdventureWorks2012.Production.Product P
Where P.Color in ('Silver', 'Black', 'Red')

-- 6

UPDATE AdventureWorks2012.Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

Select *
From AdventureWorks2012.Production.ProductDescription a
Where a.Description like '%\_%' ESCAPE '\';

-- 7 

Select  distinct e.StartDate 
From AdventureWorks2012.HumanResources.EmployeeDepartmentHistory e

-- 8 

select  
P.Name + ' ' + Convert(NVARCHAR, P.ListPrice )
As "The [product name] is only! [List price]"
From AdventureWorks2012.Production.Product P
Where ListPrice between 100 and 120
