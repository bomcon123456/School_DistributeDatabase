USE QLSV

--
SELECT * FROM AP1.QLSV.dbo.Student
SELECT * FROM AP2.QLSV.dbo.Student
--

-- Insert
  -- Success Insert (Procedure)
  EXEC insert_student 'A99999', 2, 'TestST', '0123412312', 2019, 3
  -- Invalid student_ID
  EXEC insert_student 'A00001', 2, 'TestST', '0123412312', 2019, 3

-- Update
  -- Update student site1
  exec update_student @student_id='A99999', @group=2
  -- Update student site2
  exec update_student @student_id='A99999', @phone='0123654217'
  exec update_student @student_id='A99999', @department_id=3
  exec update_student @student_id='A99999', @phone='0123654978', @department_id=2
  -- Updata both
  exec update_student @student_id='A99999', @group=2, @phone='012212121', @department_id=1
  -- Update invalid department
  exec update_student @student_id='A99999', @department_id=3000
  -- Update invalid group
  exec update_student @student_id='A99999', @group=3000
  -- Update invalid studentID
  exec update_student @student_id='INVALID', @group=3

-- DELETE
  -- Delete valid student
  exec delete_student 'A99999'
  -- Delete invalid studentID
  exec delete_student 'TESTSS'
  -- Delete student who has grade
  exec delete_student 'A00001'
