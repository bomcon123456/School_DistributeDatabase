-- PROCEDURE INSERT INTO DEPARTMENT
CREATE PROCEDURE insert_department
@DepartmentID int,
@DepartmentName varchar(255)
AS
BEGIN
	-- LOCK TABLE
	DECLARE @t1 TABLE(DepartmentID int, DeparmentName varchar(255))
	INSERT INTO @t1
		SELECT DepartmentID, DepartmentName
		FROM AP1.QLSV.dbo.Department
		WITH (TABLOCK, HOLDLOCK)
	INSERT INTO @t1
		SELECT DepartmentID, DepartmentName
		FROM AP2.QLSV.dbo.Department
		WITH (TABLOCK, HOLDLOCK)
	--

	-- INSERT INTO DEPARTMENT
	INSERT INTO Department([DepartmentID], [DepartmentName]) VALUES(@DepartmentID, @DepartmentName)
END

DROP PROCEDURE insert_department