CREATE TRIGGER insert_grade
ON Grade
INSTEAD OF INSERT
AS
BEGIN
  DECLARE @student_id varchar(6);
  DECLARE @course_id int;
  DECLARE @grade float;
  SET @student_id = (SELECT TOP 1 StudentID FROM inserted);
  SET @course_id = (SELECT TOP 1 CourseID FROM inserted);
  SET @grade = (SELECT TOP 1 Grade FROM inserted);
  -- Validate CourseID
  IF((SELECT COUNT(CourseID) FROM Course WHERE CourseID=@course_id) <= 0)
    THROW 51000, 'Course_id invalid.', 1;
  -- Validate CourseID
  IF((SELECT COUNT(CourseID) FROM AP2.QLSV.dbo.Course WHERE CourseID=@course_id) <= 0)
    THROW 51000, 'Course_id invalid.', 1;
  -- Validate StudentID
  IF((SELECT COUNT(StudentID) FROM Student WHERE StudentID=@student_id) <= 0)
    THROW 51000, 'StudentID invalid.', 1;
  -- Validate StudentID
  IF((SELECT COUNT(StudentID) FROM AP2.QLSV.dbo.Student WHERE StudentID=@student_id) <= 0)
    THROW 51000, 'StudentID invalid.', 1;
  -- Validate grade from 0->10
  IF (@grade < 0 OR @grade > 10)
    THROW 51000, 'Grade should be within 0-10 range.', 1;
END