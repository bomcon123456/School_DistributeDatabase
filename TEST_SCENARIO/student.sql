USE QLSV

--
SELECT * FROM AP1.QLSV.dbo.Student
SELECT * FROM AP2.QLSV.dbo.Student
--

-- Insert
  -- Success Insert (Procedure)
  exec ...
  -- Invalid Department_ID
  exec ...

-- Update
  -- Update student site1
  exec update_student @student_id='A00001', @group=3
  -- Update student site2
  exec update_student @student_id='A00001', @phone='0123654217'
  exec update_student @student_id='A00001', @department_id=3
  exec update_student @student_id='A00001', @phone='0123654978', @department_id=2
  -- Updata both
  exec update_student @student_id='A00001', @group=2, @phone='012212121', @department_id=1
  -- Update invalid department
  exec update_student @student_id='A00001', @department_id=3000
  -- Update invalid studentID
  exec update_student @student_id='INVALID', @group=3

-- DELETE
  -- Insert a test student to delete
  exec ...
  -- Delete valid student
  exec delete_student 'TESTSD'
  -- Delete invalid studentID
  exec delete_student 'TESTSS'
  -- Delete student who has grade
  exec delete_student 'A00001'
