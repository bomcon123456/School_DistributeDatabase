USE [QLSV]
GO
-- Insert
  -- Success Insert (Procedure)
  INSERT INTO [dbo].[Department]
            ([DepartmentID]
            ,[DepartmentName])
      VALUES
            (96
            ,'Test Department')
  GO
  -- Duplicated Department_ID
  INSERT INTO [dbo].[Department]
           ([DepartmentID]
           ,[DepartmentName])
     VALUES
           (1
           ,'Test Department')
  GO

-- Update
  -- Update valid
  UPDATE [dbo].[Department]
   SET ,[DepartmentName] = 'New_department_name'
  WHERE DepartmentID = 96
  GO
  -- Update invalid
  UPDATE [dbo].[Department]
   SET ,[DepartmentName] = 'New_department_name'
  WHERE DepartmentID = 1291
  GO

-- DELETE
  -- Delete valid department
  exec delete_department @department_id=96
  -- Delete invalid department (course have this department id)
  exec delete_department @department_id=1
  -- Delete invalid department (invalid id)
  exec delete_department @department_id=1123
