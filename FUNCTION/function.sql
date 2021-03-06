-- FUNCTION GET GRADE BY MSV
CREATE FUNCTION getGrade(@StudentID varchar(6))
RETURNS @response TABLE(GradeID int, StudentID varchar(6), CourseID int, Grade float)
AS
BEGIN
	DECLARE @MSV varchar(6);
	SET @MSV = @StudentID;

	DECLARE @count_StudentID int;
	SET @count_StudentID = (SELECT COUNT(S.StudentID) FROM QLSV.dbo.Student as S WHERE S.StudentID = @MSV)
	IF @count_StudentID <= 0
		RETURN;
	ELSE
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

	DECLARE @count_StudentID int;
	SET @count_StudentID = (SELECT COUNT(S.StudentID) FROM QLSV.dbo.Student as S WHERE S.StudentID = @MSV)

	DECLARE @result float;

	IF @count_StudentID <= 0
		SET @result = -1
	ELSE
		BEGIN
			SET @result = ((SELECT Sum(Grade) FROM QLSV.dbo.Grade WHERE StudentID = @MSV)/dbo.getSumCredit('A00003'))
		END
	RETURN @result
END

print 'This student (A00003) has GPA=' + cast(dbo.getAverageGrade('A00003') as varchar(max))




-- FUNCTION GET AVERAGE GRADE BY MSV
ALTER FUNCTION getAverageGradeWithCredit(@StudentID varchar(6))
RETURNS float
AS
BEGIN
	DECLARE @MSV varchar(6);
	SET @MSV = @StudentID;

	DECLARE @count_CourseId_AP1 int;
	DECLARE @count_CourseId_AP2 int;

	DECLARE @temp TABLE(CourseID int);
	INSERT INTO @temp SELECT CourseID FROM QLSV.dbo.Grade WHERE StudentID = @MSV

	SET @count_CourseId_AP1 = (
		SELECT COUNT(C.CourseID) FROM AP1.QLSV.dbo.Course as C INNER JOIN @temp as T 
		ON C.CourseID = T.CourseID  WHERE C.CourseID <= 5
		)
	SET @count_CourseId_AP2 = (
		SELECT COUNT(C.CourseID) FROM AP2.QLSV.dbo.Course as C INNER JOIN @temp as T 
		ON C.CourseID = T.CourseID WHERE C.CourseID > 5
		)

	DECLARE @count_StudentID int;
	SET @count_StudentID = (SELECT COUNT(S.StudentID) FROM QLSV.dbo.Student as S WHERE S.StudentID = @MSV)

	DECLARE @result float;

	IF @count_StudentID <= 0
		SET @result = -1
	ELSE
		BEGIN
			IF (@count_CourseId_AP1 > 0 AND @count_CourseId_AP2 > 0)
				BEGIN
					DECLARE @result1 int;
					DECLARE @result2 int;
					SET @result1 = (SELECT Sum(Grade.Grade*Course.Credit) FROM AP1.QLSV.dbo.Grade INNER JOIN AP1.QLSV.dbo.Course 
									ON Grade.CourseID = Course.CourseID WHERE StudentID = @MSV)
					SET @result2 = (SELECT Sum(Grade.Grade*Course.Credit) FROM AP2.QLSV.dbo.Grade INNER JOIN AP2.QLSV.dbo.Course 
									ON Grade.CourseID = Course.CourseID WHERE StudentID = @MSV)
					SET @result = (@result1 + @result2)/dbo.getSumCredit(@MSV)
					
				END
			ELSE
				BEGIN
					IF @count_CourseId_AP2 <= 0
						BEGIN
							SET @result = (SELECT Sum(Grade.Grade*Course.Credit) FROM AP1.QLSV.dbo.Grade INNER JOIN AP1.QLSV.dbo.Course 
									ON Grade.CourseID = Course.CourseID WHERE StudentID = @MSV)/dbo.getSumCredit(@MSV)
						END
					ELSE
						BEGIN
							SET @result = (SELECT Sum(Grade.Grade*Course.Credit) FROM AP2.QLSV.dbo.Grade INNER JOIN AP2.QLSV.dbo.Course 
									ON Grade.CourseID = Course.CourseID WHERE StudentID = @MSV)/dbo.getSumCredit(@MSV)
						END
				END
		END
	RETURN @result
END

print 'This student (A00003) has GPA=' + cast(dbo.getAverageGradeWithCredit('A00003') as varchar(max))




-- FUNCTION GET SUM CREDIT BY MSV
CREATE FUNCTION getSumCredit(@StudentID varchar(6))
RETURNS INT
AS
BEGIN
	DECLARE @MSV varchar(6);
	SET @MSV = @StudentID;
	
	DECLARE @count_CourseId_AP1 int;
	DECLARE @count_CourseId_AP2 int;

	DECLARE @temp TABLE(CourseID int);
	INSERT INTO @temp SELECT CourseID FROM QLSV.dbo.Grade WHERE StudentID = @MSV

	SET @count_CourseId_AP1 = (
		SELECT COUNT(C.CourseID) FROM AP1.QLSV.dbo.Course as C INNER JOIN @temp as T 
		ON C.CourseID = T.CourseID  WHERE C.CourseID <= 5
		)
	SET @count_CourseId_AP2 = (
		SELECT COUNT(C.CourseID) FROM AP2.QLSV.dbo.Course as C INNER JOIN @temp as T 
		ON C.CourseID = T.CourseID WHERE C.CourseID > 5
		)

	DECLARE @count_StudentID int;
	SET @count_StudentID = (SELECT COUNT(S.StudentID) FROM QLSV.dbo.Student as S WHERE S.StudentID = @MSV)

	DECLARE @result int;
	IF @count_StudentID <= 0
		SET @result = -1
	ELSE
		BEGIN
			IF (@count_CourseId_AP1 > 0 AND @count_CourseId_AP2 > 0)
				BEGIN
					DECLARE @result1 int;
					DECLARE @result2 int;
					SET @result1 = ( 
								SELECT SUM(C.Credit) 
								FROM AP1.QLSV.dbo.Course AS C 
								INNER JOIN @temp AS T 
								ON C.CourseID = T.CourseID 
								)
					SET @result2 = (
								SELECT SUM(C.Credit) 
								FROM AP2.QLSV.dbo.Course AS C 
								INNER JOIN @temp AS T 
								ON C.CourseID = T.CourseID 
								)
					SET @result = @result1 + @result2
					
				END
			ELSE
				BEGIN
					IF @count_CourseId_AP2 <= 0
						BEGIN
							SET @result = ( 
								SELECT SUM(C.Credit) 
								FROM AP1.QLSV.dbo.Course AS C 
								INNER JOIN @temp AS T 
								ON C.CourseID = T.CourseID 
								)
						END
					ELSE
						BEGIN
							SET @result = (
								SELECT SUM(C.Credit) 
								FROM AP2.QLSV.dbo.Course AS C 
								INNER JOIN @temp AS T 
								ON C.CourseID = T.CourseID 
								)
						END
				END
		END
	RETURN @result
END

print 'This student (A00003) has gathered total of ' + cast(dbo.getSumCredit('A00003') as varchar(max)) + ' credits.'

