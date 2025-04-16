------------------- Sub Query 
-- where , select , from , having 

select AVG(Salary)
from Instructor 

select *
from Instructor
where Salary < (select AVG(Salary)  
				from Instructor )


select  Dept_Name ,
		(select Avg(salary)  from Instructor i where I.Dept_Id = D.Dept_Id ) AvgPerDepartment

from Department D



select *
from (select CONCAT(s.St_Fname , ' ',s.St_Lname) FullName
		from Student s) NewTable
where FullName like '%a%'



update Stud_Course
set Grade += 10 
where St_Id in (select St_Id
				from Student
				where St_Address = 'Cairo')

select Dept_Name
from Department
where Dept_Id  in (select Dept_Id from Student)

---------------------

-- TOP(Number) col1  , col2 , col3  | number => number of rows in result 


select Top(16) *
from Instructor 
order by Salary desc



select Top(1) *
from Instructor 
where Salary is not null 
order by Salary asc


select top(8) with ties * 
from Student
where St_Age is not null 
order by St_Age desc
--------------------- Random Selection 

declare @value UniqueIdentifier = NewId()
print @value 

select top(5) *
from Student S
order by NewId()



----------------- Ranking Functions 

--- Row_Number() , Denes_Rank() , Rank()


select Ins_Name , Salary,Dept_Id,
	ROW_NUMBER() over(Partition by Dept_Id order by salary Desc) RN
from Instructor
where Salary is not null 



select St_Fname , St_Age,Dept_Id,
	ROW_NUMBER() over (Partition by Dept_Id order by st_age desc) RN,
	DENSE_RANK() over (Partition by Dept_Id order by st_age desc) DR,
	RANK()		 over (Partition by Dept_Id order by st_age desc) R
from Student
where St_Age is not null 



select MAX(salary)
from Instructor
where Salary < (select MAX(salary)
				from Instructor)



select *
from (select Ins_Name , Salary,
				ROW_NUMBER() over(order by salary Desc) RN
			from Instructor
			where Salary is not null ) newTable 
where  RN  = 2


select  distinct D.Dept_Name , 
AVG(Salary) over(Partition by i.Dept_Id )
from Department  D, Instructor I 
where D.Dept_Id = I.Dept_Id



select top(1) * 
from Instructor
where Salary not in (select Top(3) Salary
from Instructor
order by Salary desc)
order by Salary desc


-- NTile 

select Ins_Name , Salary,Dept_Id,
Ntile(5) over (order by Salary desc) N
from Instructor 
where Salary is not null


------------------- Query Execution Order 
-- 
select CONCAT(s.St_Fname , ' ',s.St_Lname) FullName
from Student s
--where FullName
order by FullName



-- From => Join => On => where => Group by => having => Select => Distinct => order by => Top 


-------------- 

select *
from Student

go
Create Schema Sales 
go
Create Table Sales.Department
(id int)

alter Schema sales 
transfer Student

drop table Sales.Department

drop schema Sales

alter schema DBO
Transfer Sales.student