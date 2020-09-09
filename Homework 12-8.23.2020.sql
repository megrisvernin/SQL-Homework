--HW 12
USE MOVIES
--#1 Find the most common first and last name for Directors(2 Queries Must solve with Case)

--First Name
--I used Case to get more practice, didn't need to here
SELECT 
	CASE 
		WHEN CHARINDEX(' ',DirectorName)=0 THEN DirectorName
		ELSE LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1)
	END AS [First Name]
	,Count(*) as [Count]
FROM tblDirector
GROUP BY
	CASE 
		WHEN CHARINDEX(' ',DirectorName)=0 THEN DirectorName
		ELSE LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1)
	END
ORDER BY 
	[Count] DESC
	,[First Name]

--Andrew's attempt at the same
SELECT 
    SUBSTRING(DirectorName, 0, CHARINDEX(' ', DirectorName)) AS FirstName,
    COUNT(*) AS [Count]
From tblDirector
GROUP BY
    SUBSTRING(DirectorName, 0, CHARINDEX(' ', DirectorName))
ORDER BY
    [Count] DESC,
    FirstName

--Last Name
SELECT 
	CASE 
		WHEN CHARINDEX(' ',DirectorName)=0 THEN DirectorName
		ELSE RIGHT(DirectorName,CHARINDEX(' ',REVERSE(DirectorName)))
	END AS [Last Name]
	,Count(*) as [Count]
FROM tblDirector
GROUP BY
	CASE 
		WHEN CHARINDEX(' ',DirectorName)=0 THEN DirectorName
		ELSE RIGHT(DirectorName,CHARINDEX(' ',REVERSE(DirectorName)))
	END
ORDER BY [Count] DESC
	,[Last Name]

--Andrew's attempt at the same
SELECT 
    SUBSTRING(DirectorName, CHARINDEX(' ', DirectorName) + 1, LEN(DirectorName)) AS LastName,
    COUNT(*) AS [Count]
From tblDirector
GROUP BY
    SUBSTRING(DirectorName, CHARINDEX(' ', DirectorName) + 1, LEN(DirectorName))
ORDER BY
    [Count] DESC,
    LastName

--#2 Most common first letter of the last word of film names
--Lookup Function for determining final Word
SELECT
Filmname
	--,CHARINDEX(' ',REVERSE(FilmName))-1
	--,LEN(Filmname)
	,LEN(Filmname)-(CHARINDEX(' ',REVERSE(FilmName))-2) AS [Letter Position]
	,SUBSTRING(Filmname,LEN(Filmname)-(CHARINDEX(' ',REVERSE(FilmName))-2),1) AS [Last Word Starting Letter]
	,CASE 
		WHEN CHARINDEX(' ',FilmName)=0 THEN SUBSTRING(Filmname,1,1)
		ELSE SUBSTRING(Filmname,LEN(Filmname)-(CHARINDEX(' ',REVERSE(FilmName))-2),1)
	END AS [Case Last Word Starting Letter]
FROM tblFilm
ORDER BY 
	[Case Last Word Starting Letter] DESC
	,Filmname

--Actual Case Lookup
SELECT 
	CASE 
		WHEN CHARINDEX(' ',FilmName)=0 THEN SUBSTRING(Filmname,1,1)
		ELSE SUBSTRING(Filmname,LEN(Filmname)-(CHARINDEX(' ',REVERSE(FilmName))-2),1)
	END AS [Last Word Starting Letter]
,Count(*) as [Count]
FROM tblFilm
GROUP BY
	CASE
		WHEN CHARINDEX(' ',FilmName)=0 THEN SUBSTRING(Filmname,1,1)
		ELSE SUBSTRING(Filmname,LEN(Filmname)-(CHARINDEX(' ',REVERSE(FilmName))-2),1)
END
ORDER BY [Count] DESC

--Andrew's examples
SELECT 
    CASE
        WHEN FilmName LIKE '% %' THEN LEFT(RIGHT(FilmName, CHARINDEX(' ', REVERSE(FilmName)) - 1), 1)
        ELSE SUBSTRING(FilmName, 1, 1)
    END AS LastLetter,
    COUNT(*) AS [Count]
From tblFilm
GROUP BY
    CASE
        WHEN FilmName LIKE '% %' THEN LEFT(RIGHT(FilmName, CHARINDEX(' ', REVERSE(FilmName)) - 1), 1)
        ELSE SUBSTRING(FilmName, 1, 1)
    END
ORDER BY
    [Count] DESC,
    LastLetter

--#3 Most common Word Length for Last Word of film names

--Confirm Appropriate Coding for Length of Last Name
SELECT 
Filmname
	,CHARINDEX(' ',REVERSE(Filmname)) AS [Length Last Word] --Checks for position Last Word, 0 if one word.
	,LEN(Filmname) as [Title Length]
	,CASE
		WHEN CHARINDEX(' ',FilmName)=0 THEN LEN(Filmname)
		ELSE CHARINDEX(' ',REVERSE(Filmname))
	END AS [Last Name Length]
FROM tblFilm
GROUP BY
	CASE
		WHEN CHARINDEX(' ',FilmName)=0 THEN LEN(Filmname)
		ELSE CHARINDEX(' ',REVERSE(Filmname))
	END
	,Filmname
ORDER BY [Length Last Word]

SELECT 
	CASE 
		WHEN CHARINDEX(' ',FilmName)=0 THEN LEN(Filmname)
		ELSE CHARINDEX(' ',REVERSE(Filmname))-1
	END AS [Last Word Length]
	,Count(*) AS [Count]
FROM tblFilm
GROUP BY
	CASE 
		WHEN CHARINDEX(' ',FilmName)=0 THEN LEN(Filmname)
		ELSE CHARINDEX(' ',REVERSE(Filmname))-1
	END
ORDER BY 
[Count] DESC
,[Last Word Length]

--#4 Give strengths and weaknesses of Flat File vs Relational describe a situation in which you would prefer one over the other.
--Flat File
---Strengths-Easy to make and use, inexpensive, good for small databases, able to do searching and sorting
---Weaknesses-Can become overloaded with columns, become unwieldly, gain redundant data, can have insertion/deletion anomalies

--I would prefer a flat file if I was just want to organize data around something simple like a grocery list

--Relational database
---Advantages--Reduced Data Redundacy, easier to update parts of the database, can limit access if needed.
---Weaknesses-Requires preplanning before use(time to set up), can be expensive to setup

--I might be interested in setting up a relational dataase for something like a database for college enrollment. Maybe recipes? 

--#5 --Run the Joe Blue example of Cast as Date, use Table Data
--Work with Joey Blue's example CAST(Columname AS DATE)='2005-02-22'
--Date lookup using Between
/*

Select
	DateEnrolled
	,dateadd(dd,0,datediff(dd,0,DateEnrolled)) AS [Calculateddate]
	,datediff(dd,0,DateEnrolled) AS [Datediff]
FROM Enrollment

Select 
StudentID
,DateEnrolled
FROM Enrollment
WHERE DateEnrolled BETWEEN '12/29/2006' AND '12/31/2016'

--Working Code
Select 
StudentID
,DateEnrolled
FROM Enrollment
WHERE dateadd(dd,0,datediff(dd,0,DateEnrolled))='2006-12-30'

Most efficient if you have a recent version of SQL Server

SELECT *
FROM Enrollment
WHERE CAST(Dateenrolled as Date) = '2006-12-30'
*/

--Bonus-Thomas Homework Subqueries-Practice At least 3 to show Andrew Thursday

--GetUTCDate
--Returns time to seconds
--Example redo Table example where we used Joey Blue's date workaround and instead use GetUTCDate to populate table.

---GetDate
--> Explain use
---> Operative example I'll build is to say find 

--Dateddiff

--SOUNDEX Function

--SOUNDEX Paired-->Tells how close the sound

--Find all movies released within ten years
-->Use GetDate() to solve

--SOUNDEX Function

--


--Run example of using


--Bonus Andrew Write Lesson Plan for Git

--Topics

--GetUTCDate
--Returns time to seconds


Use MyTables



Select GETUTCDATE() 