Create Database ITI_Database;
use ITI_Database;

Create Table Students
(
	Id int Primary Key Identity,
	FirstName NVarChar(20) Not Null,
	LastName NVarChar(20) Not Null,
	Age bit,
	Address VarChar(50),
	DepartmentId int

);

Create Table Departments
(
	Id int Primary Key Identity(10, 10),
	Name NVarChar(50) Not Null,
	HiringDate Date,
	InstructorId int
);


-- Add Foreign Key Constraint On DepartmentId In Students

Alter Table Students
Add Foreign Key (DepartmentId) References Departments(Id);

Create Table Instructor 
(
	Id int Primary Key,
	Name NVarChar(100) Not Null,
	Address VarChar(50),
	Bonus Float Not Null,
	Salary smallmoney Not Null,
	Hour_Rate int Not Null,
	DepartmentId int References Departments(Id)
);

-- Add Foreign Key Constraint On InstructorId In Departments
Alter Table Departments
Add Foreign Key(InstructorId) References Instructor(Id);

Create Table Courses
(
	Id int Primary Key Identity (100, 100),
	Name VarChar(50) Not Null,
	Duration int,
	Description VarChar(200) Not Null,
	TopicId int

);

Create Table Topics
(
	Id int Primary Key,
	Name VarChar(50) Not Null

);

-- Add Foreign Key Constraint On TopicId In Courses

Alter Table Courses 
Add Foreign Key (TopicId) References Topics(Id); 

Create Table Student_Course
(
	StudentId int References Students(Id),
	CourseId int References Courses(Id),
	Grade Char,
	Primary Key(StudentId, CourseId)
);

Create Table Course_Instructor
(
	InstructorId int References Instructors(Id),
	CourseId int References Courses(Id),
	Evaluation Char,  --  A , B , C , Or D 
	Primary Key(InstructorId, CourseId)
);

Select * From Students;

Select * From Departments;

Select * From Instructors;

Select Name, TopicId From Courses;

Select * From Course_Instructor;

Select * From Student_Course;
