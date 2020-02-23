USE [QLSV]
GO

--
SELECT * FROM AP1.QLSV.dbo.Course
SELECT * FROM AP2.QLSV.dbo.Course
--

-- Insert
  -- Success Insert (Procedure)
  exec insert_course 
  -- Duplicated Department_ID
  exec insert_course

-- Update
  -- Update course site 1
  exec update_course @course_id=1, @credit=2
  -- Update course site 2
  exec update_course @course_id=6, @credit=3
  -- Update invalid course
  exec update_course @course_id=91

-- DELETE
  -- insert to delete
  exec insert_course ...
  -- Delete valid department
  exec delete_course @course_id=96
  -- Delete invalid course (grade have this course id)
  exec delete_course @course_id=1
  -- Delete invalid course (invalid id)
  exec delete_course @course_id=9192
