--Homework 14
--#1-Find the number of days difference between the earliest film of the 90s and the latest release of the 90s.

USE MOVIES

SELECT
	DATEDIFF(Day,

	(
		SELECT MIN(FilmReleaseDate)
		FROM tblFilm
		WHERE YEAR(FilmReleaseDate) LIKE '199_')
	,
	(
		SELECT MAX(FilmReleaseDate)
		FROM tblFilm
		WHERE YEAR(FilmReleaseDate) LIKE '199_')) AS [DaysDifferent]

--#2-Homework Using our College example, Return everyone who enrolled within 5 years.
--See My Table
/*
Select 
	StudentID
	,DateEnrolled
FROM Enrollment
WHERE DateEnrolled>(Getdate()-5*365) */

--Use GetDate() in writing query
--Get Updated Table Data from Thomas

--Problem 3, find the most common SOUNDEX value for the  most common first word of filmnamnes
--Since they only use the first word:

SELECT
	SOUNDEX(filmname) AS [Soundex]
	,Count(*) AS [Count]
FROM Tblfilm
GROUP BY 
	SOUNDEX(filmname)
ORDER BY [Count] DESC

--Noticed that trying to isolate the first word DOES lead to a different answer, unsure of why

SELECT
	SOUNDEX(
		CASE 
			WHEN Filmname LIKE '% %' THEN LEFT(Filmname, CHARINDEX(' ',Filmname)-1)
			ELSE Filmname
		END 
		) AS [Soundex]
	,Count(*) AS [Count]
From tblfilm
GROUP BY
	SOUNDEX(
		CASE 
			WHEN filmname LIKE '% %' THEN LEFT(Filmname, CHARINDEX(' ',Filmname)-1)
			ELSE Filmname
		END 
		)
ORDER BY [Count] DESC

SELECT 
	filmname
	,SOUNDEX(SUBSTRING(filmname,0,CHARINDEX(' ',filmname))) AS [SOUNDEX]
	,SUBSTRING(filmname,0,CHARINDEX(' ',filmname))
	,SOUNDEX(SUBSTRING(filmName,0,CHARINDEX(' ',filmname)))
	,SOUNDEX(filmname) AS [Soundex]
	,Count(*) AS [Count]
FROM tblfilm
GROUP BY 
	SOUNDEX(filmname)
	,filmname
ORDER BY [Count] DESC

--BONUS, how would you find the 2nd world of a statement with 3 or more words.

	--,SUBSTRING(
	--	column,
	--	1,
	--	end
	   
   /*-- SUBSTRING(
    --    textAfterFirstSpace, 
    --    startIndexOfSecondWord, 
    --    numberOfCharacters2ndWord
    -- )
    SUBSTRING(
        SUBSTRING(FilmName, CHARINDEX(' ', FilmName) + 1, LEN(FilmName)),
        1,
        CHARINDEX(' ', SUBSTRING(FilmName, CHARINDEX(' ', FilmName) + 1, LEN(FilmName)))
    ) AS SecondWord, */

SELECT 
	filmname
	,CHARINDEX(' ',Filmname) AS INDEXOFFIRSTSPACE
	,SUBSTRING(filmname,CHARINDEX(' ',Filmname)+1,LEN(Filmname)) AS TextAfterFirstSpace
	,CHARINDEX(' ',
		SUBSTRING(filmname,CHARINDEX(' ',Filmname)+1,LEN(Filmname))
	) AS INDEXOFSECONDSPACE
		,Substring(
			SUBSTRING(filmname,CHARINDEX(' ',Filmname)+1,LEN(Filmname))
			,1
			,CHARINDEX(' ',SUBSTRING(filmname,CHARINDEX(' ',Filmname)+1,LEN(Filmname)))
	) AS SECONDWORD
	FROM tblfilm





