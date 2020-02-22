CREATE PROCEDURE delete_course @course_id int
AS
BEGIN
  DECLARE @is_site_1 BIT
  DECLARE @department_id INT

  -- Validate CourseID
  -- If there's no course having this ID in site 1
  IF((SELECT COUNT(CourseID) FROM AP1.QLSV.dbo.Course WHERE CourseID=@course_id) <= 0)
    -- And no course having this ID in site 2
    IF((SELECT COUNT(CourseID) FROM AP2.QLSV.dbo.Course WHERE CourseID=@course_id) <= 0)
      THROW 51000, 'CourseID invalid.', 1;
    ELSE
      SET @is_site_1 = 0
  ELSE
    SET @is_site_1 = 1
  -- Validate CourseID exists in Grade Table
  IF((SELECT COUNT(CourseID) FROM Grade WHERE CourseID=@course_id) > 0)
    THROW 51000, 'CourseID existed in Grade Table, cant delete.', 1;

  IF @is_site_1 = 1
  BEGIN
    DELETE FROM AP1.QLSV.dbo.Course
    WHERE CourseID = @course_id
  END
  ELSE
  BEGIN
    DELETE FROM AP2.QLSV.dbo.Course
    WHERE CourseID = @course_id
  END
END
