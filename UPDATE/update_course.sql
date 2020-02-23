CREATE PROCEDURE update_course
  @course_id int, 
  @course_name varchar(255) = NULL,
  @credit int = NULL
AS
BEGIN
  DECLARE @is_site_1 BIT
  -- Validate CourseID
  IF((SELECT COUNT(CourseID) FROM AP1.QLSV.dbo.Course WHERE CourseID=@course_id) <= 0)
  BEGIN
      IF((SELECT COUNT(CourseID) FROM AP2.QLSV.dbo.Course WHERE CourseID=@course_id) <= 0)
        THROW 51000, 'CourseID invalid.', 1;
      ELSE
         SET @is_site_1 = 0
  END
  ELSE
     SET @is_site_1 = 1
  -- Validate credit
  IF (@credit IS NOT NULL)
  BEGIN
    IF (@credit < 0 OR @credit > 3)
      THROW 51000, 'Credit invalid.', 1;
  END
  IF (@is_site_1 = 1)
  BEGIN
    UPDATE AP1.QLSV.dbo.Course
    SET CourseName = ISNULL(@course_name, CourseName),
        Credit = ISNULL(@credit, Credit)
    WHERE CourseID = @course_id
  END
  ELSE
  BEGIN
    UPDATE AP2.QLSV.dbo.Course
    SET CourseName = ISNULL(@course_name, CourseName),
        Credit = ISNULL(@credit, Credit)
    WHERE CourseID = @course_id
  END
END

exec update_course @course_id= '1', @credit=2