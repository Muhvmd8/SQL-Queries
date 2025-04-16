Restore Database Library
From Disk = 'D:\db_restore\Library.bak'

Use Library;

----------------------------------------------

-- 1 

Select 
CONCAT_WS(' ', e.Fname, e.Lname) As FullName
From Employee e
Where Len(e.Fname) > 3

-- 2

Select 
Count(b.Id) As 'NO OF PROGRAMMING BOOKS'
From Book b, Category c
Where b.Cat_id = c.Id
And c.Cat_name = 'Programming'

-- 3

Select Count(B.Id) As NO_OF_BOOKS
From  Book B, Publisher P
Where B.Publisher_id = P.Id
And P.Name = 'HarperCollins'

-- 4

Select U.SSN,
U.User_Name,
B.Borrow_date,
B.Due_date
From Users U, Borrowing B
Where U.SSN = B.User_ssn
And Due_date < '2022-7-1'

-- 5

Select 
Concat('[',B.Title,'] is written by ', '[', A.Name, ']') As AuthorName
From Book B, Author A, Book_Author BA
Where BA.Author_id = A.Id
And BA.Book_id = B.Id

-- 6

Select U.User_Name
From Users U
Where U.User_Name Like '%a%'

-- 7

Select 
Top (1) 
Count(B.Book_id) 'Number Of Borrowed Books',
User_ssn
From Borrowing B
Group By b.User_ssn
Order By Count(B.Book_id) desc

-- 8

Select 
B.User_ssn As UserID,
Sum(B.Amount) As 'Total Amount'
From Borrowing B
Group by B.User_ssn

-- 9

Select 
C.Id Cat_ID,
Sum(B.Amount) As 'Total Amount'
From Borrowing B, Category C, Book 
Where C.Id = Book.Cat_id
And B.Book_id = Book.Id
Group by c.Id

-- 10

Select * From Employee

Select 
E.Id,
COALESCE(e.Email, E.Address, Format(e.DOB, 'yyyy-MM-dd')) 
From Employee E;


-- 11

Select
C.Cat_name As CategoryName,
Count(B.Id) 'CountOfBooks'
From Book B, Category C
Where B.Cat_id = C.Id
Group By C.Cat_name

-- 12 

Select B.Id
From  Book B left join Shelf S  
on B.Shelf_code = S.Code
left join  Floor F on  S.Floor_num = F.Number
where not (f.Number = 1 AND s.Code = 'A1')

-- 13

Select 
F.Number, F.Num_blocks, Count(E.Id)
From Floor F, Employee E
Where E.Floor_no = F.Number
Group by F.Number, F.Num_blocks 

-- 14

Select U.User_Name , Book.Title, B.Borrow_date
From Borrowing B, Book, Users U
Where B.Book_id = Book.Id And B.User_ssn = U.SSN
And B.Borrow_date Between '2022-01-03' And '2022-01-10'

-- 15

Select 
E.Fname + ' ' + E.Lname As EmpName,
Super.Fname + ' ' + E.Lname As SuperName
From Employee E, Employee Super
Where Super.Id = E.Id

-- 16 

Select 
Concat_Ws(' ', E.Fname, E.Lname) As FullName,
ISNULL(e.Salary, e.Bouns) As Salary
From Employee E;

-- 17

Select Max(Salary) MaxSalary,
Min(Salary) MinSalary
From Employee 

-- 18

Go
Create Or Alter Function GetNumberType (@Number int)
Returns VarChar(10) 
As 
Begin
		Declare @Type VarChar(10)

		if (@Number % 2 = 0)
			Set @Type = 'Even'
		else 
			Set @Type = 'Odd'

		Return @Type
End

Go

Select (dbo.GetNumberType(1))

-- 19
Go
Create Function GetBooksTitleByCategory (@CategoryName VarChar(Max))
Returns Table
As
Return
(
	Select B.Title
	From Book B, Category C
	Where C.Id = B.Cat_id
	And C.Cat_name = @CategoryName
)

Go

Select * From dbo.GetBooksTitleByCategory('Programming')

-- 20
Go
Create Function GetBorrowingInfoByUserPhone (@Phone VarChar(Max))
Returns Table
As
Return
(
	Select U.User_Name, B.Title, Br.Amount, br.Due_date
	From Borrowing Br, Users U, User_phones P, Book B
	Where Br.Book_id = B.Id And Br.User_ssn = U.SSN
	And U.SSN = P.User_ssn And P.Phone_num = @Phone
)

Go

Select * From dbo.GetBorrowingInfoByUserPhone('0123654122');

-- 21
Go
Create Or Alter Function CheckUserName (@UserName VarChar(Max))
Returns VarChar(Max)
As
Begin
	declare @Message VarChar(Max)
	declare @RepeatedTimes int = 
	(
		Select Count(U.SSN) From Users U 
		Where U.User_Name = @UserName
	)
	if (@RepeatedTimes) > 1
		Set @Message = Concat_Ws(' ', @UserName , 'is Repeated')
	else if (@RepeatedTimes) = 1
		Set @Message = Concat_Ws(' ', @UserName , 'is Not Duplicated')
	else 
		Set @Message = Concat_Ws(' ', @UserName , 'is Not Found')
	Return @Message
End

Go

Select dbo.CheckUserName('Amr Ahmed')

-- 22

GO
Create Function GetDateByFormat
(
	@Date date,
	@Format VarChar(50)
)
Returns VarChar(50) 
As
Begin
	 Return Format(@Date, @Format);
End

Go 

Select dbo.GetDateByFormat('2024-12-12', 'yyyy-MM-dd');  -- Returns '2024-12-12'
Select dbo.GetDateByFormat('2024-12-12', 'MM/dd/yyyy');  -- Returns '12/12/2024'
Select dbo.GetDateByFormat('2024-12-12', 'yyyy-MMM-dd');  
Select dbo.GetDateByFormat('2024-12-12', 'MM/ddd/yyyy');  

-- 23
Go
Create Or Alter Proc SP_GetNumberOfBooksPerCategory
As
	Select C.Id , Count(B.Id) As CountOfBooks
	From Book B, Category C
	Where c.Id = B.Cat_id
	Group By C.Id


Go
Exec SP_GetNumberOfBooksPerCategory

-- 24

Go
Create Or Alter Proc UpdateManagerData
@OldEmployee int,
@NewEmployee int,
@FloorNumber int
As
	Update F
		Set F.MG_ID = @NewEmployee,
		Hiring_Date = GetDate()
	From Floor F, Employee E
	Where F.MG_ID = E.Id
	And F.Number = @FloorNumber
	And E.Id = @OldEmployee

-- 25
go
Create View AlexAndCairoEmp
With Encryption
As
	Select *
	From Employee e
	Where e.Address in ('Cairo', 'Alex')

Go

-- 26

Create Or Alter View V2
As
	Select Count(b.Id) As NOfBooks, s.Code
	from Book b, Shelf s
	Where s.Code = b.Shelf_code
	Group By s.Code

Go

-- 27

Create Or Alter View V3
As
	Select Top (1) * From
	(
	Select Count(b.Id) As NOfBooks, s.Code
	from Book b, Shelf s
	Where s.Code = b.Shelf_code
	Group By s.Code
	) R1
	Order By R1.NOfBooks Desc

Go

Select * From V3

-- 28
Go
Create Table ReturnedBooks
(
	UserSSN int,
	BookId int,
	DueDate Date,
	ReturnDate Date,
	Fees Money Default 0,
	Primary Key(UserSSN, BookId)
)

Go
Create Or Alter Trigger PreventInsertOnReturnedBooks
On ReturnedBooks
With Encryption
After Insert
As
	Declare @ReturnDate Date
	Declare @UserSSN int
	Declare @BookId int
	Declare @DueDate Date 

	Select 
	@UserSSN = i.UserSSN,
	@BookId = i.BookId,
	@DueDate = i.DueDate,
	@ReturnDate = i.ReturnDate
	From inserted i
	
	if (@ReturnDate > @DueDate)
	Begin
		Declare @Amount Money = 
		(
			Select Cast(Amount As Money) From Borrowing Br 
			Where Br.Book_id = @BookId And Br.User_ssn = @UserSSN 
		)
		Update ReturnedBooks
		Set Fees = @Amount * 0.20  -- 20 % Of Amount 
		Where BookId = @BookId 
		And UserSSN = @UserSSN
	End 		
Go

-- 29
Insert Into Floor 
Values (7, 2, 20, GetDate())

-- Mr.Omar Became The Manager Of Floor 6  Mr.Ali Took His Position

Update Floor
Set MG_ID = 12
Where MG_ID = 5

Update Floor
Set MG_ID = 5, Hiring_Date = GetDate()
Where Number = 6

Select * from Floor

-- 30
Go
Create View v_2006_check
With Encryption
As
	Select * From Floor F
	Where F.Hiring_Date Between '2022-3-01' And '2022-5-30'
With Check Option

Go
Insert Into v_2006_check
Values (8, 3, 2, '2022-05-05')  -- Inserted Successfully

Insert Into v_2006_check
Values (9, 4, 4, '2022-06-01')  -- Can't Be Inserted

/*
-- Error Message

The attempted insert or update failed because the target 
view either specifies WITH CHECK OPTION or spans a view 
that specifies WITH CHECK OPTION and one or more rows 
resulting from the operation did not qualify under the 
CHECK OPTION constraint.	
*/


-- 31
Go
Create Trigger PreventDMLOnEmployee
On Employee
Instead Of Insert, Update, Delete
As
	Select 'You Can''t Do Any DML Operation On This Table.'

-- 32

-- A

Insert Into User_phones Values (50, '01095181541')

-- I'm Trying To Add New Phone With UserId is Not Existed
-- In Users Table So The Referential Integrity Denies Me

-- B

Update Employee
Set Id = 21
Where Id = 20

-- Column Id Has A Identity Constraint So I 
-- Can't Update Id Because It's Inserted Automaticlly
-- By SQL Server

-- C

Delete From Employee
Where Id = 1

-- Now I Delete Id is A Foriegn key In Other 
-- Tables, I Can't Do DML Query That Affect 
-- More Than one Table.

-- The Solve
-- 1. Change Relationship Role From 'No Action' To 'Set Null'
-- 2. Or Do This By Me

-- D

Select * From Employee
Delete From Employee
Where Id = 12 

-- The Same Error Of The Problem C

-- E

Create NonClustered Index IX_Salary
On Employee(Salary Desc)
