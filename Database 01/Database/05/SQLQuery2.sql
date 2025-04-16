---------------- 
-- DML + JOin 

select s.St_Fname  , S.St_Address , Sc.Grade
from Student S , Stud_Course sc 
where s.St_Id = sc.St_Id
and s.St_Address = 'Mansoura'



-- greade = Grade + 10 => Grade += 10 
update sc
set Grade += 10 
from Student S , Stud_Course sc 
where s.St_Id = sc.St_Id
and s.St_Address = 'Mansoura'




delete from Stud_Course
from Student S , Stud_Course sc 
where s.St_Id = sc.St_Id
and s.St_Address = 'Mansoura'

------------------------- Functions ------ 
-- 1.Aggregate Functions 
-- 

select  Count(St_Id)  Count
from Student
where St_Address = 'Cairo'




select  Sum(Ins_Name)   Sum , AVG(Salary) Avg
from Instructor



select  Sum(Salary) /Count(Salary)  , AVG(Salary) Avg
from Instructor






select Max(St_Fname) , Min(St_Fname)
from Student

---------- 2. Null Finctions 

-- Isnull(EXP , Rep) 


select ISNULL(st_Lname ,St_Age)
from Student


select ISNULL(St_Age ,st_Lname )
from Student

select ISNULL(st_Lname ,ISnull(St_Address,'No Data'))
from Student


-- Coalesce 

select Coalesce(st_Lname , ISnull() ,'No Data ')
from Student 

 ------------- 3.  Casting | Conversion Functions 
 --- 1. Cast 


declare @value bigint = 1234
print @value
print Cast(@value as int)


-- 2.Convert 

go
declare @value date = GetDate()
print @value
print Convert(nvarchar , @value,130 )
print Convert(nvarchar , @value,106)


-- 3. Parse
go
declare @value varchar(20) = '15'
print @value
print Parse( @value as int )


go
declare @value varchar(20) = '15.6'

select Try_Parse( @value as int )


------------ 4.String Functions 


--- 1. Format 
go
declare @value dateTime2 = Getdate()
print Format(@value ,'dddd-MMMM-yyyy : HH:mm:ss:', 'ja')
print Format(@value ,'MMMM')

go
declare @value money = 90000
print @value
print Format(@value ,'C' ,'ja')

------- 2.Concat 

select St_Fname + ' ' + Cast(st_age as varchar)
from Student


select CONCAT(St_Fname,' ',St_Lname )
from Student

select CONCAT_WS('\',St_Fname,St_Lname , St_Age)
from Student


---
select LOWER(St_Fname) , Upper(St_Fname)
from Student 


select LOWER(St_Fname) , len(St_Fname)
from Student 

print Replace('Hello World' ,'o' ,'0' )


print SubString('Hello World',1, 5 )


declare @Name varchar(Max) = '           Hello World         '
print @Name
print Trim(@Name)
print LTrim(@Name)
print RTrim(@Name)


---------------5. Date & Time Functions 

-- 

print GetDate()

print GetUTCDate()

print Year(GetDate())
print datePart(year , Getdate())
print Month(GetDate())
print datePart(Month , Getdate())
print day(GetDate())
print datePart(day , Getdate())


print DateDiff(Day,'11-01-2000', GetDate())

-------------


Select * from Instructor

Select Max(Salary) MAX,MIN(Salary) MIn, Dept_Id
from Instructor
group by Dept_Id


select Count(*) , Dept_Id , St_Address
from Student
where Dept_Id is not null 
group by Dept_Id , St_Address



Select Max(Salary) [Max]  , Dept_Id
from Instructor
group by Dept_Id
having   Max(Salary) > 50000




select St_Age
from Student S
having  MAX(S.St_Age) > 4


select Max(sc.Grade) Grade  , C.Crs_Name 
from Student S , Course c, Stud_Course Sc 
where s.St_Id = sc.St_Id 
and sc.Crs_Id = c.Crs_Id
group by   C.Crs_Name