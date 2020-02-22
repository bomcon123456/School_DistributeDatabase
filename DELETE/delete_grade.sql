CREATE PROCEDURE delete_grade @grade_id int
AS
BEGIN
  IF((SELECT COUNT(GradeID) FROM Grade WHERE GradeID=@grade_id) <= 0)
    THROW 51000, 'GradeID invalid.',1;
  DELETE FROM Grade
  WHERE GradeID = @grade_id
END
