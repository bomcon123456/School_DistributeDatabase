CREATE TRIGGER insert_Student
ON Student
INSTEAD OF INSERT
AS
BEGIN
  DECLARE @department_id int;
  SET @department_id = (SELECT TOP 1 DepartmentID FROM inserted)
  IF((SELECT COUNT(DepartmentID) FROM Department WHERE DepartmentID=@department_id) <= 0)
    THROW 51000, 'Department_id invalid.',1;
  -- lock table "a" till end of transaction
  SELECT *
  FROM Student
  WITH (TABLOCK, HOLDLOCK)
  -- Insert for Site 1
  INSERT INTO AP1.QLSV.dbo.Student
  SELECT TOP 1 StudentID, StudentName, AcademicYear, StudentGroup
  -- Insert for Site 2
  INSERT INTO AP2.QLSV.dbo.Student
  SELECT TOP 1 StudentID, Phone, DepartmentID
END