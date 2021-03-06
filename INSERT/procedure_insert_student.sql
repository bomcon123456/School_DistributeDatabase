-- PROCEDURE INSERT INTO DEPARTMENT
ALTER PROCEDURE insert_student
@StudentID varchar(6),
@DepartmentID int,
@StudentName varchar(255),
@Phone char(255),
@AcademicYear int,
@Group int
AS
BEGIN
	set xact_abort on
	DECLARE @t1 TABLE(StudentID varchar(6), StudentName varchar(255), AcademicYear int, StudentGroup int)
	DECLARE @t2 TABLE(StudentID varchar(6), Phone varchar(255), DepartmentID int)
	-- lock table till end of transaction
	INSERT INTO @t1
		SELECT *
		FROM AP1.QLSV.dbo.Student
		WITH (TABLOCK, HOLDLOCK)
	INSERT INTO @t2
		SELECT *
		FROM AP2.QLSV.dbo.Student
		WITH (TABLOCK, HOLDLOCK)
	--
	IF ((SELECT COUNT(D.DepartmentID) FROM Department as D WHERE D.DepartmentID = @DepartmentID) <= 0)
		throw 51000, 'DepartmentID doesnt exist', 1
	ELSE
	BEGIN
		INSERT INTO AP1.QLSV.dbo.Student VALUES (@StudentID, @StudentName, @AcademicYear, @Group)
		INSERT INTO AP2.QLSV.dbo.Student VALUES(@StudentID, @Phone, @DepartmentID)
	END
END

EXEC insert_student 'A99999', 2, 'TestST', '0123412312', 2019, 3
exec delete_student 'A99999'