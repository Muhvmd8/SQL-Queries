------ DML [Insert - Update -Delete - Merge - Truncate]

--- insert 

use Iti

insert into Student 
values (30 ,'Khaled' , 'Ali' , 'Cairo' ,28,30,5)


insert into Student 
values (30 ,'Khaled' , 'Ali' , 'Cairo' ,28,30,5)


insert into Student 
values ('Omar' , 'Hossam' , 'Cairo' ,28,30,5)


insert into Student(St_Fname , St_Address  , St_Age) 
values ('Tarek' , 'Alex'  , 36)


insert into Student 
values ('Omar' , 'Hossam' , 'Cairo' ,28,30,5),
		('Omar' , 'Hossam' , 'Cairo' ,28,30,5),
		('Omar' , 'Hossam' , 'Cairo' ,28,30,5)


-- Update 

-- where Expression => bool => True | False 
Update Instructor
set Salary = Salary * 1.2  
where Dept_Id = 20 

--- Delete 

delete 
from Student
where St_Id = 9838


--------- DQL => Data Query Language 
-- Display => Return Result 
-- Result => Table 
-- Select 

-- * => All Col 


select *
from Student



select  S.St_Fname  , S.St_Lname , S.St_Age
from Student  S 


select   S.St_Fname +' '+    S.St_Lname  As FUllName
from Student S


-- 9 + 4  => 13 | 94


select   S.St_Fname +' '+    S.St_Lname  As FUllName  , S.St_Age Age
from Student S
where S.St_Age >= 24  and   S.St_Age <=30


select   S.St_Fname +' '+    S.St_Lname  As FUllName  , S.St_Age Age
from Student S
where S.St_Age  between 24 and 30



-- = Null | != null =>  is null | is not null 
-- <> => !=
select   S.St_Fname +' '+    S.St_Lname  As FUllName  , S.St_Age Age
from Student S
where S.St_Age   < >  28

select   S.St_Fname +' '+    S.St_Lname  As FUllName  , s.St_Address 
from Student S
where s.St_Address = 'Cairo' or s.St_Address = 'Alex'


select   S.St_Fname +' '+    S.St_Lname  As FUllName  , s.St_Address 
from Student S
where s.St_Address != 'Cairo' and s.St_Address != 'Alex'


select   S.St_Fname +' '+    S.St_Lname  As FUllName  , s.St_Address 
from Student S
where s.St_Address not in ('Cairo' , 'Alex' , 'Tanta')



--- Like 
-- _ => one Char 
-- % => Zero Or More Char 

select St_Fname
from Student
where St_Fname like 'A%'

select St_Fname
from Student
where St_Fname like '%A_'

select St_Fname
from Student
where St_Fname like '_A%'

select St_Fname
from Student
where St_Fname like '%A%'


select St_Fname
from Student
where St_Fname  like '[^a-h]%'

----- 
select  Distinct St_Fname  , St_Lname
from Student
---
-- Order by 

--declare @value Date = '01-01-2000'
--Print Year(GetDate())- Year(@value)

select   St_Fname  , St_Lname  , St_Age as Age
from Student 
order by 3 desc , St_Fname desc



--- Joins 


-- Student Name , Department Name 

-- Cross Join 
select S.St_Fname  , D.Dept_Name
from Student S , Department D


select S.St_Fname  , D.Dept_Name
from Student S cross join Department D




--- Inner Join 


select S.*  , D.*
from Student S , Department D
where D.Dept_Id = s.Dept_Id 
and s.St_Age >25


select S.*  , D.*
from Student S Inner Join  Department D
on D.Dept_Id = s.Dept_Id
where  s.St_Age >25


select S.*  , D.*
from Student S full outer Join  Department D
on D.Dept_Id = s.Dept_Id
order by s.Dept_Id

select  * 
 from Student
 where Dept_Id is null 



 ----------------


 -- Super Name , Student Name 


select   Stu.St_Fname StudentName , Super.St_Fname  SuperName
from Student Stu left join  Student Super 
on  super.St_Id = stu.St_super




select S.St_Fname , C.Crs_Name , sc.Grade
 from Student S , Course C , Stud_Course Sc 
 where s.St_Id = Sc.St_Id and c.Crs_Id = sc.Crs_Id
and sc.Grade > 70


select S.St_Fname , C.Crs_Name , sc.Grade
from Student S left  join    Stud_Course Sc 
on s.St_Id = Sc.St_Id left join Course C
on c.Crs_Id = sc.Crs_Id 
