--Homework 18 

--#1 From our College Table create a view that pulls Student ID and Major ID and no other identifying information
--Select everything from it, drop it in the same command(need Go)

USE Mytables
GO
CREATE VIEW vwStudent
AS
SELECT 
	StudentID
	,MajorID
FROM Student
GO
SELECT *
FROM vwStudent
DROP VIEW vwStudent
--#2 Insert into a temporary table GO 10,000
--Create a copy of the director table as a temp table, insert a row into it 10,00 times (Need Go)
USE MOVIES
SELECT 
	DIRECTORNAME
INTO #TempTable
FROM tblDirector

Select *
FROM #TempTable

GO
INSERT INTO #TempTable VALUES('Name')
GO 100000

Select *
FROM #TempTable

DROP TABLE #TempTable

INSERT 

--Goal is to make time for Select * statement in it take >0 seconds
--Bonus Update all the HWs to have home problems in tabs --Thomas
--Bonus is to add GitHub Readmies to all repositories that are public and delete that are just extra.
