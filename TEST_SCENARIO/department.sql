USE [QLSV]
GO

--
SELECT * FROM AP1.QLSV.dbo.Department
SELECT * FROM AP2.QLSV.dbo.Department
--

-- Insert
  -- Success Insert (Procedure)
  exec insert_department 9696, 'TestDP'
  -- Duplicated Department_ID
  exec insert_department 1, 'TestDP'

-- Update
  -- Update valid
  UPDATE [dbo].[Department]
   SET [DepartmentName] = 'New_department_name'
	WHERE DepartmentID = 9696
  -- Update invalid
  UPDATE [dbo].[Department]
   SET [DepartmentName] = 'New_department_name'
  WHERE DepartmentID = 1291

-- DELETE
  -- Delete valid department
  exec delete_department @department_id=9696
  -- Delete invalid department (course have this department id)
  exec delete_department @department_id=1
  -- Delete invalid department (invalid id)
  exec delete_department @department_id=1123
