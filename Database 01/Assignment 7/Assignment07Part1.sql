

------------ Part 1 => Functions ------------

-- 1 

go
create function GetMonthName (@Date DATE)
returns NVarChar(50)
As
Begin
    declare @MonthName NVARCHAR(50);
    Set @MonthName = DATENAME(MONTH, @Date);
    return @MonthName;
End;
	


-- 2

go
Create Function GetValuesBetweenTwoIntegers(@N1 int, @N2 int)
Returns @tbl table ( Value int)
As
Begin 
	declare @Counter int = @N1
	While @Counter <= @N2
	Begin 
		Insert into @tbl values (@Counter) 
		Set @Counter += 1
	End
End

-- 3

go
Create Function GetStudentAndDepartmentName(@StudentID int)
Returns @Stud_Dept table 
(
	DepartmentName VarChar(max),
	StudentFullName  VarChar(max)
)
As
Begin 
	insert into @Stud_Dept
	Select D.Dept_Name, S.St_Fname + ' ' + S.St_Lname
	From Student S, Department D
	Where S.Dept_Id = D.Dept_Id
End

go 

-- 4 

Create Function Message(@StudentID int)
Returns VarChar(max)
As
Begin 
	Declare @Message VarChar(max)

	Declare @FirstName varChar(max) 
	Declare @LastName varChar(max) 

	Select @FirstName = s.St_Fname from Student s Where s.St_Id = @StudentID
	Select @LastName = s.St_Lname from Student s Where s.St_Id = @StudentID

	if @FirstName is NULL and @LastName is NULL
		Set @Message = 'FirstName & LastName are Null'

	else if @FirstName is NULL 
		Set @Message = 'FirstName is Null'

	else if @LastName is NULL 
		Set @Message = 'FirstName is Null'

	else 
		Set @Message = 'FirstName & LastName are not Null'

	Return @Message;

End

-- 5

go
Create Function HiringDateFormat(@N int)
Returns @ManagerData Table 
(
	DepartmentName VarChar(max),
	ManagerName VarChar(max),
	HiringDate Date
)
As
Begin 

	if @N = 1 
	insert into @ManagerData
	Select d.Dept_Name,
	i.Ins_Name ,
	Format(d.Manager_hiredate, 'dd/MM/yyyy') 
	From Department d , Instructor i
	
	if @N = 2
	insert into @ManagerData
	Select d.Dept_Name,
	i.Ins_Name ,
	CONVERT(VARCHAR(10), d.Manager_hiredate, 120)
	From Department d , Instructor i

	if @N = 3
	insert into @ManagerData
	Select d.Dept_Name,
	i.Ins_Name ,
	Format(d.Manager_hiredate, 'MMMM dd, yyyy') 
	From Department d , Instructor i

End


-- 6

go
Create Function GetStudentNameByFormat(@FormatName NVARCHAR(10))
Returns @Table Table
(
	Id int,
	Name NVarChar(Max),
	Address NVarChar(Max),
	Age int
)
As 
Begin
	if @FormatName = 'First'
	insert into @Table
	Select s.St_Id, isNull(s.St_Fname, 'Un Known'), s.St_Address, s.St_Age
	from Student s

	else if @FormatName = 'Last'
	insert into @Table
	select s.St_Id, isNull(s.St_Lname, 'Un Known'), s.St_Address, s.St_Age
	from Student s 

	else if @FormatName = 'Full'
	insert into @Table
	select s.St_Id, s.St_Fname + ' ' + isNull(s.St_Lname, ''), s.St_Address, s.St_Age
	from Student s
End

-- 7 

use MyCompany;

go
Create Function GetEmpInProject(@ProjectNum int)
Returns table
As
Return 
(
	Select e.*
	From Employee e , Project P, Works_for w
	Where e.SSN = w.ESSn
	and p.Pnumber = w.Pno
)
