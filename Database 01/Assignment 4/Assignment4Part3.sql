
--------- Part 3 ---------

-- 1

Select Dnum , Dname , SSN , FullName = Fname + ' ' + Lname 
from Departments D Inner Join Employee E
On D.MGRSSN = E.SSN;

-- 2

Select Dname , Pname from Departments D
Inner Join Project P
On P.Dnum = D.Dnum;

-- 3

Select D.Dependent_name , D.Bdate , D.Sex, D.ESSN, Fname + ' ' + Lname As FullName from Dependent D
Inner Join Employee E
On E.SSN = D.ESSN;

-- 4 

Select Pname , Pnumber, Plocation from Project 
Where City in ('Cairo', 'Alex'); -- we can use or operator

-- 5

Select * from project 
Where Pname like 'a%';  

-- 6

Select * from Employee 
Where ( Dno = 30 and Salary between 1000 and 2000); 

-- or 

Select * From Employee 
Where Dno = 30 and Salary >= 1000 and Salary <= 2000;

-- 7 

Select   E.SSN , FullName = Fname + ' ' + Lname , P.Pname, E.Dno, W.Hours From Employee E

Inner Join Works_for W
On W.ESSn = E.SSN
Inner Join Project P
On P.Pnumber = W.Pno

Where E.Dno = 10 and P.Pname = 'AL Rabwah' and W.Hours >= 10;

-- 8 

Select Emp.* From Employee Emp
Join Employee Supervisor 
On Supervisor.SSN  = Emp.Superssn

Where (Supervisor.Fname = 'Kamel' and Supervisor.Lname = 'Mohamed');

-- 9

Select SSN, FullName = Fname + ' ' + Lname from Employee e
Inner Join Departments d
On e.SSN = d.MGRSSN

-- 10 

Select FullName = Fname + ' ' + Lname, Pname 
from Employee e
Inner Join Works_for w
On e.SSN = w.ESSn
Inner Join Project p
On p.Pnumber = w.Pno
Order By Pname;   -- default -> Asc


-- 11

Select  Pname , Dname , Lname, e.Address, e.Bdate   from Project p
Inner Join Departments d
On d.Dnum = p.Dnum
Inner Join Employee e
On e.SSN = d.MGRSSN

Where City ='Cairo';

-- 12 

Select e.SSN , e.Fname , e.Lname , e.Address , e.Bdate , 
e.Salary, e.Dno , e.Sex, e.Superssn , d.Dependent_name , d.Bdate As DependentBD
, d.Sex As DependentSex

from Employee e 
Left Join Dependent d
On d.ESSN = e.SSN;

