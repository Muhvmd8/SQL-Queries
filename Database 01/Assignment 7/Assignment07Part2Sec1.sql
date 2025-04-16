--------------- Part 2 > Views ---------------

------ Section 1 ------

-- 1 

Create View StudentCourseVW
as 
	Select Concat(' ' , s.St_Fname, s.St_Lname), c.Crs_Name 
	from Student s, Course c, Stud_Course sc
	Where s.St_Id = sc.St_Id
	and c.Crs_Id = sc.Crs_Id

-- 2

Create View IstructorTopic 
With Encryption
as
	Select distinct i.Ins_Name , t.Top_Name 
	from Instructor i, Topic t, Course c, Ins_Course ic
	Where i.Ins_Id = ic.Ins_Id and c.Crs_Id = ic.Crs_Id
	and c.Top_Id = t.Top_Id

-- 3 

Create View InstructorDepartmentView
With SchemaBinding

as 
	Select i.Ins_Name, d.Dept_Name
	From Instructor i, Department d
	Where i.Dept_Id = d.Dept_Id
	and d.Dept_Id in ('SD', 'Java')

-- 4

create view v1
as
	Select * from Student s 
	Where s.St_Address in ('Cairo' , 'Alex')

-- 5 

Create view NumberofEmployeeInProjects
as 
	Select p.Pname As ProjectName, Count(e.SSN)  As NumberOfEmployees 
	from Project p, Employee e, Works_for wf
	Where wf.ESSn = e.SSN
	and wf.Pno = p.Pnumber
	Group by p.Pname





