use MyCompany;


--------- Part 1 ---------

-- 1
Select * from Employee;

-- 2
Select Fname , Lname , Salary, Dno from Employee; 

-- 3
Select Pname , Pnumber, Plocation, D.Dname 
from Project P, Departments D
Where D.Dnum = P.Dnum;

-- 4
Select
FullName = Fname + ' ' + Lname ,
MonthlySalary = Salary,  
YearlySalary = Salary*12,
annualCommission  = ((Salary * 12) * 0.1 ) 
from Employee; 

-- 5
Select SSN, Fname + ' ' + Lname as FullName from Employee
Where Salary > 1000;

-- 6
Select SSN, FullName = Fname + ' ' + Lname, YearlySalary = Salary * 12 from Employee
Where  Salary * 12 > 10000;

-- 7
Select FullName = Fname + ' ' + Lname, Salary from Employee
Where Sex = 'F';

-- 8
Select Dnum , Dname from Departments
Where MGRSSN = 968574;

-- 9
Select Pname , Pnumber, Plocation from Project
Where Dnum = 10;
