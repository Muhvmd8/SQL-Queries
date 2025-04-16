
--------- Part 4 ---------

-- DQL --

-- 1
Select 
Fname , Lname, Pname, Dnum
from Employee e
Inner Join Works_for w
On w.ESSn = e.SSN
Inner join Project p
On p.Pnumber = w.Pno

Order By p.Dnum, Fname, Lname; 

-- 2
Update Employee
Set Salary = Salary * 1.3
Where Dno = (
			 Select P.Dnum from Project p
			 Where p.Pname = 'Al Rabwah'
			);

Update E
Set Salary += Salary * .3
From Employee E, Project P, Works_for W
Where E.SSN = W.ESSn And P.Pnumber = W.Pno
And P.Pname = 'Al Rabwah';

Select 
Salary 
From Employee E, Project P, Works_for W
Where E.SSN = W.ESSn And P.Pnumber = W.Pno
And P.Pname = 'Al Rabwah';

-- DML --

-- 1
insert Into Departments
values 
('Dept IT', 100, 112233, 1-11-2006);

-- 2 
Select * from Employee E
Where E.SSN = 968574;

-- Mrs. Oha Mohamed (SSN=968574) moved to be the manager of the new department (id = 100)
Update Departments
Set [MGRStart Date] = GETDATE(), MGRSSN = 968574
Where Dnum = 100; 

Select * from Departments
Where Dnum = 100;

-- and they give you (your SSN = 102672) her position (Dept. 20 manager)

-- i have to add new record that has ssn = 102672 into employee table
-- because it is not inserted

Insert  into employee (Fname, Lname, SSN, Bdate ,Sex, Address, Salary) 
values 
('Mohamed', 'Anwer', 102672, 4-4-2004 ,'M', 'Giza', 5000);

Update Departments
Set [MGRStart Date] = GETDATE(), MGRSSN = 102672
Where Dnum = 20; 

Select * from Departments
Where Dnum = 20;


-- Update the data of employee number = 102660 to be in your teamwork 
-- (he will be supervised by you) (your SSN =102672)

Insert  into employee (Fname, Lname, SSN, Bdate ,Sex, Address, Salary, Superssn, Dno) 
values 
('Ahmed', 'Ibraheem', 102660, 4-4-2004 ,'M', 'Giza', 10000, 102672, 20);


-- 3 
-- if (223344) supervises any employee 
Update Employee
Set Superssn = 102672
Where Superssn = 223344;

-- if (223344) Works in any project
delete from Works_for
Where ESSn = 223344;

-- if he has dependent
delete from Dependent
Where ESSN = 223344;

-- if he manages any dept
update Departments
Set MGRSSN = 102672
Where MGRSSN = 223344;

-- Now i can delete the record without referential integrity problem.

Delete from Employee
Where SSN = 223344;

