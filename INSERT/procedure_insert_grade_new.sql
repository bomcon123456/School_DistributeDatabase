-- PROCEDURE INSERT INTO GRADE
ALTER PROCEDURE insert_grade
@GradeID int,
@StudentID varchar(6),
@CourseID int,
@Grade float
AS
BEGIN
	-- Check if student exists
	IF ((SELECT COUNT(S.StudentID)
			 FROM Student as S WHERE S.StudentID = @StudentID) <= 0)
		throw 51000, 'StudentID doesnt exist', 1 
	-- Check if course exists
	IF ((SELECT COUNT(C.CourseID) FROM AP1.QLSV.dbo.Course as C WHERE C.CourseID = @CourseID) <= 0)
	BEGIN
		IF ((SELECT COUNT(C.CourseID) FROM AP2.QLSV.dbo.Course as C WHERE C.CourseID = @CourseID) <= 0)
			throw 51000, 'CourseID doesnt exist', 1
	END
	-- LOCK TABLE
	DECLARE @t1 TABLE(GradeID int, StudentID varchar(6), CourseID int, Grade float)
	INSERT INTO @t1
		SELECT GradeID, StudentID, CourseID, Grade
		FROM AP1.QLSV.dbo.Grade
		WITH (TABLOCK, HOLDLOCK)
	INSERT INTO @t1
		SELECT GradeID, StudentID, CourseID, Grade
		FROM AP2.QLSV.dbo.Grade
		WITH (TABLOCK, HOLDLOCK)
	--

	-- INSERT INTO GRADE
	INSERT INTO Grade([GradeID],[StudentID],[CourseID],[Grade]) VALUES(@GradeID, @StudentID, @CourseID, @Grade)
END

-- insert example
EXEC insert_grade
@GradeID = 999,
@StudentID = 'A00001',
@CourseID = 1,
@Grade = 5

exec delete_grade 999