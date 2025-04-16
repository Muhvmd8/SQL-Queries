
-------------------- Part 1 --------------------

use ITI;

-- 1 

Select Count(*) From Student;

Select Count(*) From Student S 
Where S.St_Age is not null;

-- 2

Select 
Count(Crs.Crs_Id) As CountOfCourses,
Topic.Top_Name

From Course Crs 
Inner Join Topic
On Crs.Top_Id = Topic.Top_Id

Group By Top_Name;


-- 3

Select 
S.St_Id As "Student ID",
StudentFullName = S.St_Fname + ' ' + IsNull(S.St_Lname , ''),
D.Dept_Name As "Department Name"

From  Student S, Department D
Where S.Dept_Id = D.Dept_Id;

-- 4

Select Ins.Ins_Name , ISNull(Ins.Salary , 0000.0000 )
From Instructor Ins

-- 5

Select
Supervisor.St_Id As SupervisorID,
Supervisor.St_Fname As FirstName,
Count(Stu.St_Id) As NumberOfSupervisedStu


From Student Supervisor , Student Stu
Where Supervisor.St_Id = Stu.St_super

Group By Supervisor.St_Fname , Supervisor.St_Id;

-- Or 

Select Count(Stu.St_Id),
Super.St_Fname As FirstName

From Student Stu
Inner Join Student Super
On Stu.St_super = Super.St_Id
Where Stu.St_super is Not Null

Group By Super.St_Fname;

-- 6
Select 
Min(I.Salary) As MinSalary,
Max(I.Salary) As MaxSalary 

From Instructor I ;

-- 7

Select Avg(I.Salary) As Avg
From Instructor I;

-- 8

Select I.* From Instructor I
Where Salary < (Select AVG(Salary) From Instructor);

-- 9

Select 
Top 1 I.Salary,
D.Dept_Name As DepartmentName
From  Instructor I , Department D

Where I.Dept_Id = D.Dept_Id and I.Salary is not null
Order By Salary Asc;

/*

 last executed keyword is the 'select'
 first the records will be ordered
 then select will retrieve the first record
 that has the minimum salary
 
*/

-- 10

Select distinct top 2 I.Salary 
From Instructor I
Where Salary is not null
order by Salary desc;

