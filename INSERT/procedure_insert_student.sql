-- PROCEDURE INSERT INTO DEPARTMENT
CREATE PROCEDURE insertDepartment
@StudentID varchar(6),
@DepartmentID int,
@StudentName varchar(255),
@Phone char(255),
@AcademicYear int,
@Group int
AS
BEGIN
	BEGIN TRANSACTION
	IF (@@SERVERNAME = 'AP1')
	BEGIN
		-- lock table "a" till end of transaction
		SELECT *
		FROM AP1.QLSV.dbo.Student
		WITH (TABLOCK, HOLDLOCK)
		SELECT *
		FROM AP2.QLSV.dbo.Student
		WITH (TABLOCK, HOLDLOCK)

		DECLARE @count_Department_AP1 int;
		SET @count_Department_AP1 = (SELECT COUNT(D.DepartmentID) FROM AP1.QLSV.dbo.Department as D WHERE D.DepartmentID = @DepartmentID)
		IF @count_Department_AP1 <= 0
			throw 51000, 'DepartmentID doesnt exist', 1
		ELSE
		BEGIN
			INSERT INTO AP1.QLSV.dbo.Student VALUES (@StudentID, @StudentName, @AcademicYear, @Group)
			INSERT INTO AP2.QLSV.dbo.Student VALUES(@StudentID, @Phone, @DepartmentID)
		END
	END
	
	IF (@@SERVERNAME = 'AP2')
	BEGIN
		-- lock table "a" till end of transaction
		SELECT *
		FROM AP1.QLSV.dbo.Student
		WITH (TABLOCK, HOLDLOCK)
		SELECT *
		FROM AP2.QLSV.dbo.Student
		WITH (TABLOCK, HOLDLOCK)

		DECLARE @count_Department_AP2 int;
		SET @count_Department_AP2 = (SELECT COUNT(D.DepartmentID) FROM AP2.QLSV.dbo.Department as D WHERE D.DepartmentID = @DepartmentID)
		IF @count_Department_AP2 <= 0
			throw 51000, 'DepartmentID doesnt exist', 1
		ELSE
		BEGIN
			INSERT INTO AP1.QLSV.dbo.Student VALUES (@StudentID, @StudentName, @AcademicYear, @Group)
			INSERT INTO AP2.QLSV.dbo.Student VALUES(@StudentID, @Phone, @DepartmentID)
		END
	END
	COMMIT TRANSACTION
END