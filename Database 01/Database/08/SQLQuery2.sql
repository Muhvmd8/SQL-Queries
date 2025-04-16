------------- DML + Views 

-- View Selects from one table 

Create or alter  View ALexStudentView 
as 
	select S.St_Id Id , S.St_Fname Name , s.St_Address Address
	 from student s 
	 where s.St_Address = 'Alex'
	 with check option 


go
select * from  ALexStudentView


Insert into ALexStudentView
values (22, 'Mona' , 'Alex')


Insert into ALexStudentView
values (24, 'Khaled' , 'Alex')


-------- Update 


Update ALexStudentView
set Address = 'Cairo'
where Id = 24 


---------------
delete from  ALexStudentView
where Id = 24


-----------------

go
Create or alter View StudentDepartmentView 
as 
	Select S.St_Id StudentId , S.St_Fname StudentName , 
	D.Dept_Id DepartmentId  , D.Dept_Name DepartmentName
	from Student S , Department D
	where S.Dept_Id = D.Dept_Id


go
select * from StudentDepartmentView


--delete
delete from StudentDepartmentView
where StudentId = 1


--- Insert 
insert into StudentDepartmentView(StudentId ,StudentName)
values (29 , 'Ahmed')


---------------------  SP Stored Procedure ------------------------

go
--Sp_help 'StudentDepartmentView'
Create or alter  Proc  SP_GetStudentNameAndAge   @Address varchar(50) 
as  
	Select S.St_Fname , s.St_Age , S.St_Address
	from Student S
	where S.St_Address = @Address 




go
SP_GetStudentNameAndAge 'Cairo'

Create Table StudentData
(
	Name varchar(20),
	Age int , 
	Address Varchar(50)
)

go
insert into StudentData
Exec SP_GetStudentNameAndAge 'Cairo'


Declare @value int 
exec @value = SP_GetStudentNameAndAge 'Cairo'
----------------

go
Create or alter  proc DeleteStudent @id int 
as
	begin try 


		Delete from Student
		where st_id = @id 

	end Try
	Begin Catch 
	-- Error Logging 
	--Print @@Error
	--print Error_Message()
	--print Error_Severity()
	--declare @state int =  Error_State()
	--RaisError('Something wen wrong ',11, 1)
	return @@Error
	end Catch




	go
	declare @value  int 
exec @value =	DeleteStudent 1
print @value



----------------- 
go

Create or alter  proc GetStudentAgeAndName 
@Name varchar(max) out ,
@data int out
as 
	select @Name = S.St_Fname ,@data = s.St_Age
	from Student S
	where S.St_Id = @data


go
declare @StuName varchar(max)   , @Stuage int  = 10
exec GetStudentAgeAndName @data = @Stuage out   , @Name = @StuName out 
print Concat_ws(' ' ,@stuName ,@Stuage)


---------------------- Triggers 
--- DML [Insert , Update , Delete ]
-- after |for  , Instead of 



--DLL Triggers [Server  , Database] 
-- Logon Trigger 


go
Create Trigger TR_Student_HelloAfterInsert2
on Student
after Insert 
as 
	print 'Hello!!'



go

Insert into Student (St_Id , St_Fname , St_Age)
values (53, 'Medhat',30)


go 
Create or alter Trigger TR_Student_AduitAfterUpdate
on student 
after update
as 
	Print Concat_ws(' ' , 'User ',System_user ,'Time ' , GetDate() )


go

update Student 
set St_Address = 'Tanta'
where St_Id = 10 


go
create or alter Trigger TR_Student_DisableDelete
on Student 
instead of delete
as 
	select CONCAT_ws(' ', 'You Can''t delete ',St_Fname,'from this table ')
	from Deleted


	delete from Student


-------------
alter table Student 
disable trigger TR_Student_DisableDelete

delete from StudentDepartmentView 
where StudentId =  10


go 
Create Trigger TR_StudentDepartmentView 
on 	StudentDepartmentView
instead of  delete 
as 
	Delete From Student
	where st_id = (select D.StudentId from Deleted D )

