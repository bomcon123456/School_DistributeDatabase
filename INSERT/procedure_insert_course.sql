CREATE PROCEDURE insert_course
@CourseID int,
@CourseName varchar(255),
@Credit int,
@DepartmentID int
AS
BEGIN
  -- Validate course/department ID
  IF((SELECT COUNT(DepartmentID) FROM Department WHERE DepartmentID=@DepartmentID) <= 0)
    THROW 51000, 'Department_id invalid.',1;
  IF((SELECT COUNT(CourseID) FROM AP1.QLSV.dbo.Course WHERE CourseID=@CourseID) > 0)
    THROW 51000, 'Course_id existed.',1;
  IF((SELECT COUNT(CourseID) FROM AP2.QLSV.dbo.Course WHERE CourseID=@CourseID) > 0)
    THROW 51000, 'Course_id existed.',1;
  -- Validate credit <=3
  IF (@Credit > 3)
	THROW 51000, 'Invalid credit value.',1;
  -- LOCK TABLE
  DECLARE @t1 TABLE(CourseID int, CourseName varchar(255), Credit int, DepartmentID int)
  --
  -- Insert
  IF @DepartmentID <= 5
  BEGIN
    --
    INSERT INTO @t1
      SELECT CourseID, CourseName, Credit, DepartmentID
      FROM AP1.QLSV.dbo.Course
      WITH (TABLOCK, HOLDLOCK)
    --
    INSERT INTO AP1.QLSV.dbo.Course
    VALUES (@CourseID, @CourseName, @Credit, @DepartmentID)
  END
  ELSE
  BEGIN
    --
    INSERT INTO @t1
      SELECT CourseID, CourseName, Credit, DepartmentID
      FROM AP2.QLSV.dbo.Course
      WITH (TABLOCK, HOLDLOCK)
    --
    INSERT INTO AP2.QLSV.dbo.Course
    VALUES (@CourseID, @CourseName, @Credit, @DepartmentID)
  END

END
