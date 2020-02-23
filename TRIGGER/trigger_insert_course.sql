CREATE TRIGGER tigger_insert_course
ON Course
INSTEAD OF INSERT
AS
BEGIN
  DECLARE @department_id int;
  DECLARE @course_id int;
  DECLARE @credit int;
  SET @department_id = (SELECT TOP 1 DepartmentID FROM inserted);
  SET @course_id = (SELECT TOP 1 CourseID FROM inserted);
  SET @credit = (SELECT TOP 1 Credit FROM inserted);
  -- Validate course/department ID
  IF((SELECT COUNT(DepartmentID) FROM Department WHERE DepartmentID=@department_id) <= 0)
    THROW 51000, 'Department_id invalid.',1;
  IF((SELECT COUNT(CourseID) FROM AP1.QLSV.dbo.Course WHERE CourseID=@course_id) > 0)
    THROW 51000, 'Course_id existed.',1;
  IF((SELECT COUNT(CourseID) FROM AP2.QLSV.dbo.Course WHERE CourseID=@course_id) > 0)
    THROW 51000, 'Course_id existed.',1;
  -- Validate credit <=3
  IF (@credit > 3)
	THROW 51000, 'Invalid credit value.',1;
  -- LOCK TABLE
  DECLARE @t1 TABLE(CourseID int, CourseName varchar(255), Credit int, DepartmentID int)
  --
  -- Insert
  IF @department_id <= 5
  BEGIN
    --
    INSERT INTO @t1
      SELECT CourseID, CourseName, Credit, DepartmentID
      FROM AP1.QLSV.dbo.Course
      WITH (TABLOCK, HOLDLOCK)
    --
    INSERT INTO AP1.QLSV.dbo.Course
    SELECT * 
    FROM inserted
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
    SELECT * 
    FROM inserted
  END

END