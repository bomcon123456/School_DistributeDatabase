USE [QLSV]
GO

-- Get grade By MSV
  -- Success
  SELECT * FROM getGrade('A00001');


-- Get average grade By MSV
	-- Success 
	print dbo.getAverageGrade('A00003')
	-- Invalid StudentID
	print dbo.getAverageGrade('A00005')

-- Get sum credit by MSV
  -- Success
  print dbo.getSumCredit('A00003')
  -- Invalid StudentID
  print dbo.getSumCredit('A00005')
