

 --Single Line Comment 
/*
Multiline 
Comment 
========
========
*/
--select  Name , /*Age*/ , Salary 
--from 
--where 


print @@ServerName
print @@Version 

-- decimal => decimal(18,0)
Declare @Value nVarchar(max) = N'احمد' 
Print @Value



--------- DDL Create -----
-- DataBase 
Create DataBase CompanyG03Db

use CompanyG03Db


--- Col  data type => key | Constraint  
Create Table Employees 
(
	Id int Primary Key Identity, -- Not Null & UNique   | Identity => default Identity(1,1)
	FirstName nvarchar(20) not null , 
	LastName nvarchar(20) not null ,
	Address  varchar(50) ,
	Gender char ,
	Salary money ,
	BirthDate Date,
	SupervisorId int References Employees(Id) ,
	DepartmentNumber int
)

create Table Departments 
(
	Number int Primary Key Identity(10,10),
	Name varchar(50) unique not null, 
	ManagerId int References Employees(Id),
	HiringDate Date 
)

Create Table Departmentocations
(
	Location Varchar(50) ,
	DepartmentNumber int references Departments(Number),
	Primary Key (Location, DepartmentNumber)
)

Create Table Projects 
(
	Number int Primary Key Identity(100,100),
	Name varchar(50) unique not null, 
	DepartmentNumber int references Departments(Number),
	Location Varchar(50) not null,
	City Varchar(20) default 'Cairo'
)

Create Table EmployeeProjects
(
	ProjectNumber int References PRojects(Number),
	EmployeeId int  References Employees(Id),
	NumberOfHours int ,
	Primary Key (ProjectNumber ,EmployeeId)
)


Create Table Dependents
(
	Name nvarchar(20) ,
	BirthDate Date,
	Gender char ,
	EmployeeId int  References Employees(Id),
	Primary Key (Name ,EmployeeId)
)

-- add Key 
alter table Employees 
add Foreign key (DepartmentNumber) References Departments(Number)


alter table Employees 
add Age int not null 

alter table Employees 
add Unique(Age)



alter table Employees 
alter column Age bigint  

alter table Employees 
drop column DepartmentNumber


alter table Employees 
drop FK__Employees__Depar__5629CD9C


drop table Departmentocations 