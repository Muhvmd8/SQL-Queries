-------------
-- Set operators [union , union all , intersect , except]

-- Order2020 , Order2021


-- select * from Orders2020
-- select * from Orders2021

select i.Ins_Name Name  from Instructor I
union all
select  s.St_Fname  from Student S


select  s.St_Fname  from Student S
except 
select i.Ins_Name Name  from Instructor I



-------------- DDL => Select into 

go
select * INTO StudentBackup 
from Student S


select *  from StudentBackup


select S.St_Fname StudentName , D.Dept_Name DepartmentName 
into StudentDepartment 
from Department D , Student S
where D.Dept_Id = s.Dept_Id


select * from StudentDepartment

select S.St_Fname  , S.St_Address into CairoSutdents
from Student S
where s.St_Address = 'Cairo'


select * from CairoSutdents


select * into Employees
from MyCompany.dbo.Employee
where 1!=1
---------- Insert Based on Select 

insert into Employees(Fname , Salary , SSN)
select Ins_Name , Salary ,Ins_Id 
from Instructor
-----------------

-- IF , else , While   
--if c
--else if c


--while C 
--begin 
--end 


--declare @value int= 0

--while @value < 10
--begin
--print @value
--Set @value+= 1 
--end 

-------------------- UDF 
-- Scaler Function  => single Value 



go
--Create Function GetStudentNameById(@id int)
--returns varchar(50)
--as
--begin 
--declare @Name varchar(50)
--select @Name =  s.St_Fname
--from Student S
--where S.St_Id = @id
--return @Name
--end 
go
select DBO.GetStudentNameById(St_Id)
from Student


---\
go
Create or alter  Function GetDepartmentManagerName(@departmentName varchar(20))
returns varchar(20)
begin
declare @Name varchar(20)
select @Name=  E.Fname
from Departments D  , Employee E
where E.SSN = D.MGRSSN
and D.Dname = @departmentName
return @name
end

go
select DBO.GetDepartmentManagerName('DP1')


-- Table Valued FUnction 
-- linlie 


select *
from Instructor I
where I.Dept_Id = 10
go
Create or alter  Function GetInstByDeptId(@Id int )
returns table as
return (select i.Ins_Id Id , CONCAT_WS(' ' ,Ins_Name ,i.Ins_Degree) FullName
from Instructor I
where I.Dept_Id = @Id)


go

select * from GetInstByDeptId(20)

------------- Table 
--- 'First' , 'Last' , 'Full'
go
Create Function GetStudentData(@format varchar(30))
returns @tbl Table 
			(
				Id int , 
				Name VarChar(50),
				Address VarChar(50),
				Age int 
			)
begin 
if @format = 'First'
insert into @tbl 
select S.St_Id  , S.St_Fname , S.St_Address , S.St_Age
from Student S
else if @format = 'Last'
insert into @tbl 
select S.St_Id  , S.St_Lname , S.St_Address , S.St_Age
from Student S
else if @format = 'Full'
insert into @tbl 
select S.St_Id  , CONCAT(S.St_Fname,' ',S.St_Lname) , S.St_Address , S.St_Age
from Student S
return 
end 







go

select * from GetStudentData('First')



----------------- Views -------------------


--1. statndard 
--2. Partitioned view 
--3. Indexed View 

-- Select * from Table 
go
Create View StudentsVw
as 
select *
from Student


select * from StudentsVw


update Student
set St_super = 1 
where St_Id = 6


create View InstructorsVw
as 
	select i.Ins_Name  , I.Ins_Id
	from Instructor I


select * from 	InstructorsVw

go
create View CairoStudentsView
as 
	select *
	from Student 
	where St_Address ='Cairo'

go
select  * from CairoStudentsView

go
create or Alter  View studentDepartmentView(StudentName , Address ,DepartmentName)
with Encryption
As 
	select S.St_Fname , S.St_Address , D.Dept_Name
	from Student S , Department D
	where S.Dept_Id = D.Dept_Id


	select * from studentDepartmentView

	go
	SP_HelpText 'studentDepartmentView'