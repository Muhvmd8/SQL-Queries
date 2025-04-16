----------  Part 2 ----------

Restore Database ITI
from Disk = 'D:\db_restore\ITI.bak';

Use ITI;

-- 1

Select Distinct Ins_Name As InstructorName from Instructor; -- Without 

-- 2 

Select Ins_Name As InstructorName , Dept_Name from Instructor
Left Join Department
On Instructor.Dept_Id = Department.Dept_Id;  -- retrieve all instructor

Select Count(*) as NumberOfInstructor From Instructor;     

-- 3

Select Count(*) from Stud_Course;  

Select Count(*) from Stud_Course
Where Grade is Not NULL;  


Select
St_Fname + ' ' + St_Lname As FullName,
Crs_Name, Grade 
from Student 
Inner Join Stud_Course
On Student.St_Id = Stud_Course.St_Id 
Inner Join Course
On Course.Crs_Id = Stud_Course.Crs_Id

Where Grade is Not NULL 

-- 4 

Select 
Stu.St_Fname,
Supervisor.* 
From Student Stu 
Inner Join Student Supervisor
On Stu.St_super = Supervisor.St_Id;


-- 5 

Select 
St_ID As StudentID,
St_Fname + ' ' + St_Lname As FullName,
Dept_Name 
from Student
Inner Join Department
On Student.Dept_Id = Department.Dept_Id; 

-- Bonus

select @@VERSION;

/*

    it returns some details about sql server 
	like database engine version number

	MS SQL SERVER 2022

*/

select @@SERVERNAME;

/*

	 returns the local server name information

*/