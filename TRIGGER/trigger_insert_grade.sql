ALTER TRIGGER trigger_insert_grade
ON Grade
AFTER INSERT
AS
BEGIN
  DECLARE @grade float;
  SET @grade = (SELECT TOP 1 Grade FROM inserted);
  -- Validate grade from 0->10
  IF (@grade < 0 OR @grade > 10)
    THROW 51000, 'Grade should be within 0-10 range.', 1;
END