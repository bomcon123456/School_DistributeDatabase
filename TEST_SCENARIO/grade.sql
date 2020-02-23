USE [QLSV]
GO

--
SELECT * FROM AP1.QLSV.dbo.Grade
SELECT * FROM AP2.QLSV.dbo.Grade
--

-- Insert
  -- Success Insert (Procedure)
  exec insert_grade @GradeID = 9696, @StudentID = 'A00001', @CourseID = 1, @Grade = 5
  -- Duplicated Department_ID
  exec insert_grade @GradeID = 9696, @StudentID = 'A00001', @CourseID = 1, @Grade = 5

-- Update
  -- Update success
  exec update_grade @grade_id=9696, @grade=8.5
  -- Update invalid grade
  exec update_grade @grade_id=91, @grade=10
  exec update_grade @grade_id=9696, @grade=100

-- DELETE
  -- Delete valid department
  exec delete_grade @grade_id=9696
  -- Delete invalid grade (invalid id)
  exec delete_grade @grade_id=11231
