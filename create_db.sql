CREATE TABLE Department(DepartmentID int PRIMARY KEY NOT NULL, DepartmentName varchar(255))

CREATE TABLE Course(CourseID int PRIMARY KEY NOT NULL, CourseName varchar(255), Credit int, DepartmentID int)

CREATE TABLE Grade(GradeID int PRIMARY KEY NOT NULL, StudentID varchar(6), CourseID int, Grade float)

CREATE TABLE Student(StudentID varchar(6) PRIMARY KEY NOT NULL, StudentName varchar(255), Phone varchar(255), AcademicYear int, StudentGroup int, DepartmentID int)

USE [QLSV]
GO


USE [QLSV]
GO

INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('1'
           ,'Math')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('2'
           ,'IT')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('3'
           ,'Economics')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('4'
           ,'Statistics')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('5'
           ,'Applied Math')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('6'
           ,'Litterature')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('7'
           ,'Tourism')
GO
INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           ('8'
           ,'Hospitality')
GO






INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (1
           ,'Course1'
           ,3
           ,1)
GO
INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (2
           ,'Course2'
           ,2
           ,2)
GO
INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (3
           ,'Course3'
           ,1
           ,3)
GO
INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (4
           ,'Course4'
           ,3
           ,4)
GO
INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (5
           ,'Course5'
           ,2
           ,5)
GO

INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (6
           ,'Course6'
           ,3
           ,6)
GO
INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (7
           ,'Course7'
           ,2
           ,7)
GO
INSERT INTO [dbo].[Course]
           ([CourseID]
           ,[CourseName]
           ,[Credit]
           ,[DepartmentID])
     VALUES
           (8
           ,'Course8'
           ,1
           ,8)
GO

USE [QLSV]
GO

INSERT INTO [dbo].[Student]
           ([StudentID]
           ,[StudentName]
           ,[Phone]
           ,[AcademicYear]
           ,[StudentGroup]
           ,[DepartmentID])
     VALUES
           ('A00001'
           ,'S1'
           ,'0123'
           ,'2019'
           ,1
           ,1)
GO


INSERT INTO [dbo].[Student]
           ([StudentID]
           ,[StudentName]
           ,[Phone]
           ,[AcademicYear]
           ,[StudentGroup]
           ,[DepartmentID])
     VALUES
           ('A00002'
           ,'S2'
           ,'01234'
           ,'2019'
           ,2
           ,2)
GO


USE [QLSV]
GO

INSERT INTO [dbo].[Grade]
           ([GradeID]
           ,[StudentID]
           ,[CourseID]
           ,[Grade])
     VALUES
           (1
           ,'A00001'
           ,1
           ,8)
GO
INSERT INTO [dbo].[Grade]
           ([GradeID]
           ,[StudentID]
           ,[CourseID]
           ,[Grade])
     VALUES
           (2
           ,'A00001'
           ,3
           ,9)
GO
INSERT INTO [dbo].[Grade]
           ([GradeID]
           ,[StudentID]
           ,[CourseID]
           ,[Grade])
     VALUES
           (2
           ,'A00002'
           ,2
           ,10)
GO