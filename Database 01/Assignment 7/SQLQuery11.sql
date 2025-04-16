
------------------ User Defined Function ------------------

-- Scope   ===>   Begin = { ,   SQL Statements , End = }

-- All Functions Must Return 

-- Functions in SQL Returns => { Single Value (Scaler Function), Table } 

 -- 1- Scaler Function

 /*

	Function Signature

	Create Function FunctionName(@p1 dt, @pt dt)
	returns Return-DataType => int , dec varchar

	as 
	begin 
		body
	end


	> can not use DML Inside function body
 
 */



use MyCompany

Go 
Create Function GetDepartmentManagerNameByDName(@DeptName NvarChar(max))
Returns NVarChar(Max) 
As
Begin 
	declare @Name NVarChar(Max)
	Select @Name = e.Fname
	from Employee e, Departments d
	Where e.SSN = d.MGRSSN and d.Dname = @DeptName
	return @Name
End

 
-- Select DBO.GetStudentCByID(10);
go 
Select dbo.GetDepartmentManagerNameByDName('DP2');
