--Homework 7


--Question 1
--Use FUNCTION  DATEADD to add one year, two years, 3 years to DATERELEASE returning the Day of the week  it is:
--Name constraint
USE MOVIES
SELECT
	FilmName
	,FilmReleaseDate
	,DATEADD(year,1,FilmReleaseDate) AS [FilmReleaseDatePlus1]
	,DATEADD(year,2,FilmReleaseDate) AS [FilmReleaseDatePlus2]
	,DATEADD(year,3,FilmReleaseDate) AS [FilmReleaseDatePlus3]
	,DATENAME(weekday,FilmReleaseDate) AS [Weekday]
	,DATENAME(weekday,(DATEADD(year,1,FilmReleaseDate))) AS [WeekdayPlus1]
	,DATENAME(weekday,(DATEADD(year,2,FilmReleaseDate))) AS [WeekdayPlus2]
	,DATENAME(weekday,(DATEADD(year,3,FilmReleaseDate))) AS [WeekdayPlus3]
FROM 
	tblFilm
--Note that leap years like 2000,2004,2008 are leap years will complicate this, typically adding an extra day for the 28th.


--Question 2
--Constraints
--Table
--name constraints in table
--add columns Start and end date with end date with end date default null
--Add the constraint about start and end date that end must begin after start
--Add a start date for at least 1 person see if will let you enter

--Question 3
--Check
--Add Email Column to student
--Add check ensure @ is there. Check like %@%.% Make sure to name constraint 'ValidEmailAddress' Make sure Unique email

--Question 4
--Wildcards
--Return all movies produced in 1990s AND the DAY ended in 7(Day of the month) using the _ on a date field 

USE MOVIES
Select
	FilmName
	,FilmReleaseDate
	,CONVERT(VARCHAR(25), FilmReleaseDate)
	,DATENAME(day,FilmReleaseDate) AS [DAYofMonth]
	,DATENAME(year,FilmReleaseDate) AS [Year]
FROM
	tblFilm
Where DATENAME(day,FilmReleaseDate) LIKE '%7'
AND DATENAME(year,FilmReleaseDate) LIKE '199_'
--Datename returned the character string
--Datepart returns integer




