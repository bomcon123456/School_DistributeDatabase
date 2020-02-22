-- PROCEDURE INSERT INTO GRADE
CREATE PROCEDURE insertGrade
@GradeID int,
@StudentID varchar(6),
@CourseID int,
@Grade float
AS
BEGIN
	IF (@@SERVERNAME = 'AP1')
	BEGIN
		DECLARE @count_Student_AP1 int;
		SET @count_Student_AP1 = (SELECT COUNT(S.StudentID)
				FROM AP1.QLSV.dbo.Student as S WHERE S.StudentID = @StudentID)
		IF @count_Student_AP1 <= 0
		BEGIN
			throw 51000, 'StudentID doesnt exist', 1
		END
		ELSE
		BEGIN
			DECLARE @count_Course_AP1_1 int;
			SET @count_Course_AP1_1 = (SELECT COUNT(C.CourseID) FROM AP1.QLSV.dbo.Course as C WHERE C.CourseID = @CourseID)
				IF @count_Course_AP1_1 <= 0
				BEGIN
					DECLARE @count_Course_AP2_1 int;
					SET @count_Course_AP2_1 = (SELECT COUNT(C.CourseID) FROM [AP2\MSSQLSERVER11].QLSV.dbo.Course as C WHERE C.CourseID = @CourseID)
					IF @count_Course_AP2_1 <= 0
						throw 51000, 'CourseID doesnt exist', 1
					ELSE
						INSERT INTO [AP1].QLSV.dbo.Grade([GradeID],[StudentID],[CourseID],[Grade]) VALUES(@GradeID, @StudentID, @CourseID, @Grade)
				END
				ELSE
						INSERT INTO [AP1].QLSV.dbo.Grade([GradeID],[StudentID],[CourseID],[Grade]) VALUES(@GradeID, @StudentID, @CourseID, @Grade)
		END
	END

	IF (@@SERVERNAME = 'AP2')
	BEGIN
		DECLARE @count_Student_AP2 int;
		SET @count_Student_AP2 = (SELECT COUNT(S.StudentID)
				FROM [AP2\MSSQLSERVER11].QLSV.dbo.Student as S WHERE S.StudentID = @StudentID)
		IF @count_Student_AP2 <= 0
		BEGIN
			throw 51000, 'StudentID doesnt exist', 1
		END
		ELSE
		BEGIN
			DECLARE @count_Course_AP2_2 int;
			SET @count_Course_AP2_2 = (SELECT COUNT(C.CourseID) FROM [AP2\MSSQLSERVER11].QLSV.dbo.Course as C WHERE C.CourseID = @CourseID)
				IF @count_Course_AP2_2 <= 0
				BEGIN
					DECLARE @count_Course_AP1_2 int;
					SET @count_Course_AP1_2 = (SELECT COUNT(C.CourseID) FROM AP1.QLSV.dbo.Course as C WHERE C.CourseID = @CourseID)
					IF @count_Course_AP1_2 <= 0
						throw 51000, 'CourseID doesnt exist', 1
					ELSE
						INSERT INTO [AP2\MSSQLSERVER11].QLSV.dbo.Grade([GradeID],[StudentID],[CourseID],[Grade]) VALUES(@GradeID, @StudentID, @CourseID, @Grade)
				END
				ELSE
						INSERT INTO [AP2\MSSQLSERVER11].QLSV.dbo.Grade([GradeID],[StudentID],[CourseID],[Grade]) VALUES(@GradeID, @StudentID, @CourseID, @Grade)
		END
	END
END

-- insert example
EXEC insertGrade
@GradeID = 999,
@StudentID = 'A00001',
@CourseID = 1,
@Grade = 5
