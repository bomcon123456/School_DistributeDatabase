CREATE PROCEDURE delete_student @student_id varchar(6)
AS
BEGIN
  -- Validate StudentID
  IF((SELECT COUNT(StudentID) FROM Student WHERE StudentID=@student_id) <= 0)
      THROW 51000, 'StudentID invalid.', 1;
    
  -- Validate StudentID exists in Grade Table
  IF((SELECT COUNT(StudentID) FROM Grade WHERE StudentID=@student_id) > 0)
    THROW 51000, 'StudentID existed in Grade Table, cant delete.', 1;

  DELETE FROM AP1.QLSV.dbo.Student
  WHERE StudentID = @student_id
  DELETE FROM AP2.QLSV.dbo.Student
  WHERE StudentID = @student_id
END
