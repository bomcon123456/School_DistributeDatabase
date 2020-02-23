CREATE TRIGGER trigger_insert_Student_site1
ON Student
AFTER INSERT
AS
BEGIN
  DECLARE @group int;
  SET @group = (SELECT TOP 1 StudentGroup FROM inserted)
  IF(@group <= 0 OR @group > 3)
    THROW 51000, 'Group invalid.',1;
END