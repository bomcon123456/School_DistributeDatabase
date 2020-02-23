USE [QLSV]
GO

--
SELECT * FROM AP1.QLSV.dbo.Course
SELECT * FROM AP2.QLSV.dbo.Course
--

-- Insert
  -- Success Insert (Procedure) site 1
  exec insert_course 9696, 'TestCourse', 3, 3
  -- Success Insert (Procedure) site 2
  exec insert_course 9697, 'TestCourse2', 2, 7
  
  -- Duplicated CourseID
  exec insert_course 9697, 'TestCourse2', 2, 3
  -- Invalid departmentID
  exec insert_course 9698, 'TestCourse2', 2, 999


-- Update
  -- Update course site 1
  exec update_course @course_id=9696, @credit=3
  -- Update course site 2
  exec update_course @course_id=9697, @credit=3
  -- Update invalid course
  exec update_course @course_id=91
  -- Update invalid course
  exec update_course @course_id=9696, @credit = 100

-- DELETE
  -- Delete valid department
  exec delete_course @course_id=9696
  exec delete_course @course_id=9697
  -- Delete invalid course (grade have this course id)
  exec delete_course @course_id=1
  -- Delete invalid course (invalid id)
  exec delete_course @course_id=9698
