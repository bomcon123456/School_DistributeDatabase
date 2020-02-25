USE [QLSV]
GO

-- Get grade By MSV
  -- Success
  SELECT * FROM getGrade('A00001');
  -- Not exist
  SELECT * FROM getGrade('INVALID')

-- Get average grade By MSV
	-- Success 
	print 'This student (A00003) has GPA=' + cast(dbo.getAverageGrade('A00003') as varchar(max))
	-- Invalid StudentID will return -1
	print dbo.getAverageGrade('A00005')

-- Get avg grade with credits by msv
	-- Success 
	print 'This student (A00003) has GPA=' + cast(dbo.getAverageGradeWithCredit('A00003') as varchar(max))
	-- Invalid StudentID will return -1
	print dbo.getAverageGrade('A00005')


-- Get sum credit by MSV
  -- Success
  print 'This student (A00003) has gathered total of ' + cast(dbo.getSumCredit('A00003') as varchar(max)) + ' credits.'
  -- Invalid StudentID
  print dbo.getSumCredit('A00005')
