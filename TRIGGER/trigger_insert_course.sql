CREATE TRIGGER trigger_insert_course
ON Course
AFTER INSERT
AS
BEGIN
  DECLARE @credit int;
  SET @credit = (SELECT TOP 1 Credit FROM inserted);
  -- Validate credit <=3
  IF (@credit > 3 OR @credit <= 0)
  	THROW 51000, 'Invalid credit value.',1;
END