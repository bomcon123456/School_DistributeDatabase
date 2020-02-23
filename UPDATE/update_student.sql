CREATE PROCEDURE update_student 
  @student_id varchar(6),
  @phone varchar(255) = NULL,
  @group int = NULL,
  @department_id int = NULL
AS
BEGIN
  -- Validate StudentID
  IF((SELECT COUNT(StudentID) FROM Student WHERE StudentID=@student_id) <= 0)
      THROW 51000, 'StudentID invalid.', 1;
    
  IF (@group IS NOT NULL)
  BEGIN
    IF @group > 3 OR @group <= 0
      THROW 51000, 'Group invalid.', 1;
  END
  IF (@department_id IS NOT NULL)
  BEGIN
    IF((SELECT COUNT(DepartmentID) FROM Department WHERE DepartmentID=@department_id) <= 0)
      THROW 51000, 'DepartmentID invalid.', 1;
  END

  IF (@group IS NOT NULL)
  BEGIN
    UPDATE AP1.QLSV.dbo.Student
    SET StudentGroup = ISNULL(@group, StudentGroup)
    WHERE StudentID = @student_id
  END
  IF (@phone IS NOT NULL OR @department_id IS NOT NULL)
  BEGIN
    UPDATE AP2.QLSV.dbo.Student
    SET Phone = ISNULL(@phone, Phone),
        DepartmentID = ISNULL(@department_id, DepartmentID)
    WHERE StudentID = @student_id
  END
END

exec update_student @student_id='A00001', @group=3