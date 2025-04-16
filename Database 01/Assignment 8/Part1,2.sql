------------ Part 1 ------------

-- 1

Create Proc NOfStudentPerDepartment
As
	select Count(S.St_Id), S.Dept_Id from Student S
	Where S.Dept_Id is not Null
	Group By S.Dept_Id
	
go
NOfStudentPerDepartment

-- 2
go
Create or alter Proc CheckNOfEmployeesInProject
@id int
As

	if 
	(
		Select count(e.SSN)
		From Employee e, Project P, Works_For wf
		Where e.SSN = wf.ESSn and p.Pnumber = wf.Pno 
		and p.Pnumber = @id
	) > 3
		Print ('The number of employees in the project 100 is 3 or more');
	else
		Select 
		e.SSN Id, 
		e.Fname FirstName,
		e.Lname LastName
		From Employee e, Project P, Works_For wf
		Where e.SSN = wf.ESSn and p.Pnumber = wf.Pno 
		and p.Pnumber = @id

go

CheckNOfEmployeesInProject 100

-- 3

go
Create Proc UpdateEmployeeNum
@oldNum varchar(50),
@newNum varchar(50),
@projectNumber int
As 
	Update Works_for 
	Set ESSn = @newNum
	Where Pno = @projectNumber

------------ Part 2 -------------
-- 1 
go
Create or alter Proc GetSum @start int, @end int
As
	declare @sum int = 0
	While (@start <= @end) 
		Begin
			set @sum += @start
			set @start += 1
		End

	Select @sum

go
GetSum 1, 10 

-- 2 
go
Create Proc CalcAreaOfCircle 
@radius int
as 
	declare @const float = 3.14
	select @const * @radius * @radius

go 
CalcAreaOfCircle 5

-- 3 
go
Create Proc GetAgeCategory 
@Age int
As
	if @Age < 18 
		Print ('Category is Child')
	else if @Age >= 18 and @Age < 60
		Print ('Category is Adult')
	else 
		Print ('Category is Senior')

go
GetAgeCategory 18

-- 4 

-- Function to split string and stores the splited into new table 
go
Create Function Split(@InputString varchar(max), @delim varchar(5))
Returns @Numbers Table 
(
	Number VarChar(max)
)
As
Begin
	Declare @Pos int = 0,
	@Num VarChar(max),
	@SubString VarChar(max)

	Set @Pos = CharIndex(@delim, @InputString)

	While @Pos > 0
	Begin
		Set @SubString = SubString(@InputString, 1, @Pos - 1);
		Insert Into @Numbers Values (@SubString);
		Set @InputString = SubString(@InputString, @Pos + Len(@delim), Len(@InputString)) 
	End

	-- To ensure we took all of string
	Insert Into @Numbers Values (@InputString)
	Return;
End

---------- end of split function ----------

go
Create Or Alter Proc DetermineNumber
@Numbers VarChar(max),
@delim VarChar(max)
As
	-- Table that will store numbers from Split function

	Create Table #NumTable
	(
		Nums int
	);

	-- Insert Based On Select From Split Function 
	-- And Cast the Numbers to integer because it 
	-- is stored in Function as string numbers

	Insert Into #NumTable 
	Select Cast(s.Number As int) From dbo.Split(@Numbers, @delim) s

	-- Now we have the table that contains the list
	Select 
	Min(n.Nums) Min, 
	Max(n.Nums) Max,
	AVG(n.Nums) Avg
	From #NumTable n

	drop table #NumTable

go
Exec DetermineNumber '5, 10, 15, 20, 25', ','
