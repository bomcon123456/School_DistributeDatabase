CREATE PROCEDURE delete_department @department_id varchar(6)
AS
BEGIN
  -- Validate DepartmentID
  IF((SELECT COUNT(DepartmentID) FROM Department WHERE DepartmentID=@department_id) <= 0)
      THROW 51000, 'DepartmentID invalid.', 1;
    
  -- Validate DepartmentID exists in Course Table
  IF((SELECT COUNT(DepartmentID) FROM AP1.QLSV.dbo.Course WHERE DepartmentID=@department_id) > 0)
    THROW 51000, 'DepartmentID existed in Course Table, cant delete.', 1;
  IF((SELECT COUNT(DepartmentID) FROM AP2.QLSV.dbo.Course WHERE DepartmentID=@department_id) > 0)
    THROW 51000, 'DepartmentID existed in Course Table, cant delete.', 1;

  DELETE FROM Department
  WHERE DepartmentID = @department_id
END

exec delete_Department 1