------------- Part 2 Section 2 -------------

Use IKEA_Company
 
-- 1

Create View v_clerk
As 
	Select e.EmpNo , p.ProjectName, wo.Job, wo.Enter_Date
	from HR.employee e, Hr.Project p, Works_on wo
	Where wo.EmpNo = e.EmpNo and wo.ProjectNo = p.ProjectNo
	and wo.Job = 'Clerk'

-- 2 

Create View v_without_budget
as 
	select p.Budget from hr.Project p 
	Where p.Budget is Null

-- 3 

Create View v_count 
as 
	select p.ProjectName, count(wo.Job) As CountOfJobs
	from hr.Project p , Works_on wo
	group by p.ProjectName

-- 4

Create View v_project_p2
as 
	select v.ProjectName As p2, v.EmpNo from v_clerk v


-- 5
Alter View v_without_budget
as
Select *
from hr.Project p
WHERE p.ProjectNo IN ('P1', 'P2');

-- 6 

drop view if exists v_clerk
drop view if exists v_count

select e.* from HR.Employee e 

-- 7 

Create View EmployeeDepartment
As 
	Select e.EmpNo, e.EmpLname from HR.Employee e, Department d
	Where e.DeptNo = d.DeptName
	and d.DeptNo = 'd2'

-- 8 

Create View View7
As 
Select  e.EmpLname from EmployeeDepartment e
Where e.EmpLname like '%J%'

-- 9 

Create View v_dept 
as 
	Select  d.DeptName, d.DeptNo from Department d











	