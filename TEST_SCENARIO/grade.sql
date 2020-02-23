USE [QLSV]
GO

--
SELECT * FROM AP1.QLSV.dbo.Grade
SELECT * FROM AP2.QLSV.dbo.Grade
--

-- Insert
  -- Success Insert (Procedure)
  exec insert_grade
  -- Duplicated Department_ID
  exec insert_grade

-- Update
  -- Update success
  exec update_grade @grade_id=1, @grade=8.5
  -- Update invalid grade
  exec update_course @grade_id=91, @grade=10
  exec update_course @grade_id=1, @grade=100

-- DELETE
  -- insert to delete
  exec insert_grade ...
  -- Delete valid department
  exec delete_grade @grade_id=96
  -- Delete invalid grade (invalid id)
  exec delete_grade @grade_id=11231
