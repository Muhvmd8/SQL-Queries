---- DDL Triggers => Database 
--- 

go
Create Trigger TR_PreventTableDrop
on Database
after DROP_TABLE 
AS	
		Declare @tableName varchar(50) =
		EventData().value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(50)')

		if @tableName = 'Stud_Course' 
		begin
		print 'Stud_Course table can''t be Dropped !!'
		Rollback
		end 

go 
drop table Ins_Course

go
Create Table SchemaChangesAudit
(
	EventTime SmallDateTime , 
	EventType varchar(50) , 
	ObjectType varchar(50),
	ObjectName varchar(50),
	UserName varchar(50)
)

go 

Create Trigger Tr_AuditSchemaChanges 
on database 
after CREATE_TABLE , ALTER_TABLE , DROP_TABLE ,
		CREATE_VIEW , ALTER_VIEW , DROP_VIEW,
		CREATE_PROCEDURE , ALTER_PROCEDURE , DROP_PROCEDURE
as	
	
	DECLARE @eventtype varchar(50) =
	EventData().value('(/EVENT_INSTANCE/EventType)[1]','varchar(50)'),
	@ObjectType varchar(50) = 
	EventData().value('(/EVENT_INSTANCE/ObjectType)[1]','varchar(50)'),
	@ObjectName varchar(50) = 
	EventData().value('(/EVENT_INSTANCE/ObjectName)[1]','varchar(50)'),
	@UserName  varchar(50) = SUser_Name()

	insert into SchemaChangesAudit 
	values (GETDATE() ,@eventtype , @ObjectType ,@ObjectName , @UserName)
	print 'Schema Changes Has been logged '


go 

Create Table TestTable (testColumn int)
go 
Create View TestView2
as 
	select * from Student

go 
 select * from SchemaChangesAudit

 go
 Create  or alter Trigger TR_BLockUser
 on All Server 
 for LOGON 
 as 
	declare @log varchar(50) = Original_Login() ,
	@Time Time = Getdate()
	if @log = 'Ahmed' and @time > '04:00:00'
	rollback


	---------------- Relationship rule ------------------

	Create Table x 
	(
		y int references Student(St_id)  on delete set default 
	)


	update Department
	set Dept_Id = 100 
	where Dept_Id = 20


delete from Department 
where Dept_Id = 10 


---------------------------	
--------------------------------  Index  ----------------------

-- Clustred  , Non Clustred  
-- Clustered INdex => Table Can Only Have one Clustered Index 
Go
-- Create Employee table
CREATE TABLE Employee (
    Id int  Primary Key ,
    Name NVARCHAR(100),
    Address NVARCHAR(255)  ,
    Age INT,
    Salary DECIMAL(18, 2)
);
-- Insert 20 random rows into Employee table


go
INSERT INTO Employee (Id, Name, Address, Age, Salary)
VALUES
(1, 'Medaht', '456 Oak St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(2, 'John Doe', '123 Elm St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(3, 'Linda Johnson', '101 Maple St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(4, 'Michael Brown', '789 Pine St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(5, 'Patricia Miller', '303 Birch St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(6, 'James Davis', '202 Cedar St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(7, 'Jennifer Taylor', '505 Cherry St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(8, 'Robert Wilson', '404 Ash St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(9, 'Elizabeth Harris', '707 Willow St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(13, 'Joseph Walker', '1010 Palm St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(14, 'Susan Hall', '1111 Elm St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(15, 'Thomas Allen', '1212 Oak St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(16, 'Karen Young', '1313 Pine St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(17, 'Daniel King', '1414 Maple St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(18, 'Nancy Wright', '1515 Cedar St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(19, 'Paul Scott', '1616 Birch St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(20, 'Jessica Green', '1717 Ash St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(10, 'William Lee', '606 Spruce St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(11, 'Mary Lewis', '909 Poplar St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000),
(12, 'Charles Clark', '808 Alder St', ABS(CHECKSUM(NEWID())) % 39 + 21, ABS(CHECKSUM(NEWID())) % 45001 + 5000)



select Name , Salary , Address   
from Employee
where Salary between 5000 and 50000


select * from Student where st_id between 10 and 20

sp_HelpIndex 'Employee'


go 
create NonClustered Index Idx_Salary
on Employee (salary)
include (Name , Address)

drop index Employee.Idx_Salary

-------------------- Indexed View 

go
Create or alter  View StudentDepartmentView
with schemabinding
as 
	select s.St_Id StudentId  , s.St_Fname StudentName ,
	D.Dept_Id DepartmentId , D.Dept_Name DepartmentName
	from DBO.Student S ,DBO.Department D 
	where S.Dept_Id = D.Dept_Id

go

Create unique Clustered Index IDX_StudentDeptView
on StudentDepartmentView (StudentId)



select * from StudentDepartmentView

drop index StudentDepartmentView.IDX_StudentDeptView


go 
alter schema Management 
transfer Instructor

go
alter table Student
add Constraint CHK_Age check (st_Age between 20 and  50)


update Student
set St_Age = 55
where st_id = 10 




select S.St_Fname , 
case 
when Sc.Grade between 50 and 59 then 'D'
else 'A'
end  Grade
from Student  S, Stud_Course SC 
where S.St_Id = sc.St_Id


if @@Error <> 0 
