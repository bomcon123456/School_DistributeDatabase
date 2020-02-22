CREATE PROCEDURE update_grade
  @grade_id int, 
  @grade float
AS
BEGIN
  -- Validate GradeID
  IF((SELECT COUNT(GradeID) FROM Grade WHERE GradeID=@grade_id) <= 0)
    THROW 51000, 'GradeID invalid.', 1;	 
  -- Validate grade
  IF (@grade < 0 OR @grade > 10)
    THROW 51000, 'Grade should be within 0-10 range.', 1;
  
  UPDATE AP1.QLSV.dbo.Grade
  SET Grade = ISNULL(@grade, Grade)
  WHERE GradeID = @grade_id
END

exec update_grade @grade_id='1', @grade=8.5