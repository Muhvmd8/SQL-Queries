------------------ Part 2 ------------------

Use MyCompany;


--  1 

Select P.Pname,
Sum(WF.Hours) TotalHours

From Project P , Works_for WF
Where P.Pnumber = WF.Pno

Group by P.Pname;

-- 2 

Select D.Dname, 
Max(E.Salary) As MaxSalary,
Min(E.Salary) As MinSalary,
Avg(E.Salary) As AvgSalary
From Departments D , Employee E
Where E.Dno = D.Dnum
Group By Dname;

Select Sum(Salary) , Dname
From Employee , Departments
Where Employee.Dno = Departments.Dnum
Group By Dname;

-- 3

Select  
Top 1 Min(e.SSN) As SmallestEmployeeID,
Dname As DepartmentName
From Employee e , Departments d
Where e.Dno = d.Dnum

Group By Dname
Order By Min(e.SSN);

-- 4 

Select e.Lname , e.ssn from Employee e
left join Dependent d
On d.ESSN = e.SSN
Inner Join Departments s
On s.MGRSSN = e.SSN

where essn is null;

-- 5

-- select dept info 
-- if avgDepSalary is less than 
-- the avg of all employees

Select 
dname  As DepartmentName,
dnum   As DepartmentNumber,
MGRSSN As DepartmenManager,
Count(e.SSN) As NumberOfEmployee,
Avg(Salary)  As DeptSalaryAvg

from Employee e, Departments d
Where d.Dnum = e.Dno

group by dname , dnum , MGRSSN
Having Avg(Salary) < (Select Avg(Salary) from Employee)

-- 6 

Select e.SSN, e.Fname, e.Lname
From Employee e
Where EXISTS (    
    Select Top 1 e.*
    From Dependent d
    Where d.ESSN = e.SSN
);

Select

select distinct Fname , SSN
from Employee E , Dependent D
where D.ESSN = E.SSN  and  exists(select ESSN from Dependent)

-- Exists Usage -> is used to test for the existence of any record in a subquery.
--              -> Returns true if the subquery returns true  












