--------------- Part01 --------------

-- 1 
Go
Create NonClustered Index IX_HireDates
On Department (manager_hiredate)

-- Now NonClustered Index ordered records by 'ManagerHireDate'
-- And There are Pointer to retrieve all record from hard desk.

-- 2


Create Unique Index IX_Age  -- Here it will create index (NonClustered)
On Student (St_Age)         -- And at the same time will make Age Unique

-- But it'll make error because the stored values of age must be unique

-- 3

Create Login RouteStudent With Password = '442004'
Create User RouteStudent For Login RouteStudent

Grant Select, Insert On Student To RouteStudent
Grant Select, Insert On Course To RouteStudent

Deny Delete, Update On Student To RouteStudent
Deny Delete, Update On Course To RouteStudent



--------------- Part02 --------------

-- 1

Create Table ReturnedBooks
(
	USSN VarChar(20) ,
	BookID VarChar(20),
	DueDate Date,
	ReturnDate Date,
	Fees Money,
	PaidAmount Money,
	Primary Key(USSN, BookID)
);


Go

Create Trigger Tr_CheckReturnDate
On ReturnedBooks
With Encryption
After Insert
As

    Declare @UserSSN VarChar(20),
    @BookId VarChar(20),
    @DueDate Date,
    @ReturnDate Date,
    @PaidAmount Money;


    Select @UserSSN = USSN,
    @BookId = BookId,
    @DueDate = DueDate,
    @ReturnDate = ReturnDate,
    @PaidAmount = PaidAmount
    From inserted;

    If @ReturnDate > @DueDate
        Update ReturnedBooks
        Set Fees = @PaidAmount * 0.2
        Where USSN = @UserSSN And BookId = @BookId;
    Else
        Update ReturnedBooks
        Set Fees = 0
        Where USSN = @UserSSN AND BookId = @BookId;
    
-- 2

Go
Create Trigger TR_PreventDMLOnEmployee
On Employee 
With Encryption
Instead Of Insert, Update, Delete 
As
	Select 'You Can''t Do Any DML On This Table';

-- 3
Go

Create NonClustered Index IX_Salary On Employee (Salary)

-- Index doesn't affect on Referential Integrity, Because it depends on
-- Forigen Key not Index.

-- But index can improve the performance of checking on the Forigen Key.
	
-- 4

Create Login Mohamed With Password = '442004'
Create User MohamedUser For Login Mohamed

Grant Select, Insert On Employee To MohamedUser

Deny Delete, Update On Employee To MohamedUser
