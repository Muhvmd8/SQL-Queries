Create Table Department
(
	DeptNo VarChar(5) Primary Key,
	DeptName VarChar(max) Not Null,
	Location VarChar(max) Not Null
)

Insert Into Department
Values ('d1', 'Research', 'NY'),
       ('d2', 'Accounting', 'Ds'),
	   ('d3', 'Markting', 'KW');


Create Table Employee (
    EmpNo int primary key,
    EmpFname NVarChar(50) Not Null,
    EmpLname NVarChar(50) Not Null,
	DeptNumber VarChar(5),
    Salary Decimal(10, 2) Unique,
    Foreign Key (DeptNumber) References Department(DeptNo)
);

Select * from Department

Insert into Employee
Values
(25348, 'Mathew','Smith' ,'d3', 2500),
(10102, 'Ann','Jones' ,'d3', 3000),
(18316, 'John','Barrymore' ,'d1', 2400),
(29346, 'James', 'James', 'd2', 2800),
(9031,  'Lisa', 'Bertoni', 'd2', 4000),
(2581,  'Elisa', 'Hansel', 'd2', 3600 ),
(28559, 'Sybl', 'Moser',  'd1', 2900);


Insert into Employee
Values
(11111, 'Mohamed','Anwer' ,'d3', 5000)


-- Add Default Constraint Over Column Enter_Date in  Works_On Table

Alter Table YourTable
Add Enter_Date DateTime Not Null Default GetDate();


-- Add TelephoneNumber column
Alter Table Employee
Add TelephoneNumber NVarChar(15);  

-- Drop it
Alter Table Employee
Drop Column TelephoneNumber; 

/*

	2- Create the following schema and transfer the following tables to it 
	Company Schema 
	Department table 
	Project table 
	Human Resource Schema
	  Employee table 
*/

go
Create Schema Company;

go
Create Schema HumanResources;


Alter Schema Company Transfer dbo.Department

Alter Schema Company Transfer dbo.Project

Alter Schema HumanResources Transfer dbo.Employee

-- 3 

Update P
Set Budget = 1.10 * Budget
from Project P 
Inner Join Works_on W
On w.ProjectNo = P.ProjectNo
Where w.EmpNo = 10102;

-- 4 

Update Department
Set DeptName = 'Sales'
Where DeptNo = 
(
	Select e.DeptNumber from RouteCompany.HumanResources.Employee e 
	Where e.EmpFname = 'James' 
)

-- Another Way 

Update D
Set DeptName = 'Sales'
From Company.Department D, Employee E
Where D.DeptNo = E.DeptNumber
And E.EmpFname = 'James'



-- 5 

Update W
Set Enter_Date = 2007/12/12
From Employee e, Works_on W, Project P
Where e.EmpNo = w.EmpNo
and P.ProjectNo = w.ProjectNo
and P.ProjectNo = 'P1'
and e.DeptNumber =   -- We Can create new inner join between Department and Employee
(Select d.DeptNo from Department d Where d.DeptName = 'Sales')

-- 6 

Delete W From Works_On W
Inner Join dbo.Employee e
On w.EmpNo = e.EmpNo
Join Company.Department d On e.DeptNumber = d.DeptNo 
Where  d.Location = 'KW';
