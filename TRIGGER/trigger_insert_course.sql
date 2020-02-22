CREATE TRIGGER insert_course
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
  -- Insert
  IF @department_id <= 5
  BEGIN
    INSERT INTO AP1.QLSV.dbo.Course
    SELECT * 
    FROM inserted
  END
  ELSE
  BEGIN
    INSERT INTO AP2.QLSV.dbo.Course
    SELECT * 
    FROM inserted
  END

END