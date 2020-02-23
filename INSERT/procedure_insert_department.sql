-- PROCEDURE INSERT INTO DEPARTMENT
CREATE PROCEDURE insert_department
@DepartmentID int,
@DepartmentName varchar(255)
AS
BEGIN
	-- Check if student exists
	IF ((SELECT COUNT(DepartmentID)
			 FROM Department WHERE DepartmentID = @DepartmentID) <= 0)
		throw 51000, 'DepartmentID doesnt exist', 1 
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

	-- INSERT INTO GRADE
	INSERT INTO Department([DepartmentID], [DepartmentName]) VALUES(@DepartmentID, @DepartmentName)
END

-- insert example
EXEC insert_department 999, 'TestDP'

exec delete_department 999