CREATE TRIGGER trigger_insert_Student_site2
ON Student
AFTER INSERT
AS
BEGIN
  DECLARE @department_id int;
  SET @department_id = (SELECT TOP 1 DepartmentID FROM inserted)
  IF((SELECT COUNT(DepartmentID) FROM Department WHERE DepartmentID=@department_id) <= 0)
    THROW 51000, 'Department_id invalid.',1;
END