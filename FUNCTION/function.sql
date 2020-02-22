-- FUNCTION GET GRADE BY MSV
ALTER FUNCTION getGrade(@StudentID varchar(6))
RETURNS @response TABLE(GradeID int, StudentID varchar(6), CourseID int, Grade float)
AS
BEGIN
	DECLARE @MSV varchar(6);
	SET @MSV = @StudentID; 
		INSERT INTO @response SELECT GradeID, StudentID, CourseID, Grade FROM QLSV.dbo.Grade WHERE StudentID = @MSV
	RETURN;
END

SELECT * FROM getGrade('A00001');

-- FUNCTION GET AVERAGE GRADE BY MSV
CREATE FUNCTION getAverageGrade(@StudentID varchar(6))
RETURNS float
AS
BEGIN
	DECLARE @MSV varchar(6);
	SET @MSV = @StudentID;
	RETURN (SELECT Avg(Grade) FROM QLSV.dbo.Grade WHERE StudentID = @MSV)
END

SELECT dbo.getAverageGrade('A00001')