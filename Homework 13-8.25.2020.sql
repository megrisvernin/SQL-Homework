--Homework 13

--By Thursday
--Make Account at --github.com
--Go through exercise video https://www.youtube.com/watch?v=XxSgdX7lX6E
--New Credit Card with good signup
--Get 5 pound handweights

--Make Presentation on:
--GetUTCDate
--Returns time to seconds
--Example redo Table example where we used Joey Blue's date workaround and instead use GetUTCDate to populate table.

---GetDate
--> Explain use
---> Operative example I'll build is to say find 

--Dateddiff

--SOUNDEX Function

--SOUNDEX Paired-->Tells how close the sound

--By Sunday 
--Problem 1 Find the most common the last letter of the first word in filmnames
USE Movies
SELECT 
	FilmName
	,(CHARINDEX(' ',Filmname)-1) AS [Position of Last Letter First Word]
	,RIGHT(Filmname,1) AS [LastLetter One Word]
	,SUBSTRING(Filmname,(CHARINDEX(' ',Filmname)-1),1) AS [Last Letter First Word]
FROM tblFilm

SELECT 
	CASE 
		WHEN Filmname like '% %' THEN SUBSTRING(Filmname,(CHARINDEX(' ',Filmname)-1),1)
		ELSE RIGHT(Filmname,1)
	END  AS [LastLetterOFFirstWord]
	,COUNT(*) AS [Count]
FROM tblfilm
GROUP BY 
	CASE 
		WHEN Filmname like '% %' THEN SUBSTRING(Filmname,(CHARINDEX(' ',Filmname)-1),1)
		ELSE RIGHT(Filmname,1)
	END
ORDER BY
	[Count] DESC
	,[LastLetterOFFirstWord]

--Problem 2-Find out the most common number that movie names ending in a number end in. 
SELECT
	CASE
		WHEN filmname like '% _' THEN RIGHT(filmname,1)
		ELSE filmname
	END AS [EndsinNumber]
	,COUNT(*) as [Count]
FROM tblfilm
WHERE filmname like '% _'
GROUP BY
	CASE
		WHEN filmname like '% _' THEN RIGHT(filmname,1)
		ELSE filmname
	END
	ORDER BY [Count] DESC

--Sanity Check
SELECT
	filmname
	,RIGHT(filmname,1) AS [Last Word]
FROM tblfilm
WHERE filmname like '% _'
ORDER BY [Last Word]

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

--Problem 3-Find the ratio of Box Office to Budget, Use ISnull to turn null entries into 0s 1st query
--IS NULL First Example
--2nd query use Nullif to turn 0s back to Null
SELECT 
	Filmname
	,FORMAT(FilmBoxOfficeDollars,'C2') AS [BoxOffice]
	,FORMAT(FilmBudgetDollars,'C2') AS [Budget]
	,ISNULL(FilmBoxOfficeDollars,0)/ISNULL(FilmBudgetDollars,0) AS [Ratio]
FROM tblFilm

--NULLIF 2nd Example Null if to get Ratio back
SELECT 
	Filmname
	,FORMAT(FilmBoxOfficeDollars,'C2') AS [BoxOffice]
	,FORMAT(FilmBudgetDollars,'C2') AS [Budget]
	,NULLIF(ISNULL(FilmBoxOfficeDollars,0),0)
	/NULLIF(ISNULL(FilmBudgetDollars,0),0) AS [Ratio]
FROM tblFilm
	ORDER BY [Ratio] DESC

--Problem 4-Fill out the following fields if one is null, then proceed to the next
SELECT 
	Filmname
	,FIlmCertificateID
	,FilmStudioID
	,FilmDIrectorid
	,COALESCE(
	'FilmCertificateID=' + CAST(FilmCertificateID AS VARCHAR(5)),
	'FilmStudioID=' + CAST(filmstudioid AS VARCHAR(5)),
	'FilmDirectorID=' + CAST(filmDirectorid AS VARCHAR(5)),
	'Unknown') AS [Coalesce Test]
FROM tblfilm
ORDER BY [Coalesce Test] DESC

-- 'FilmCertificateID=' + film certificate id, 
-- 'FilmStudioID=' + film studio id, 
-- 'FilmDirector=' + film director id, 
--else 'unknown'
--Might have to convert to a string 

--'FilmStudioID' + IsNUll(columnname)
--ISNULL ('Filstudioid' +columnName)


--GetUTCDate
--Returns time to seconds
--Example redo Table example where we used Joey Blue's date workaround and instead use GetUTCDate to populate table.

--Find the number of days difference between the earliest film of the 90s and the latest release of the 90s.

USE MOVIES
SELECT
FilmName
,CAST(FilmReleaseDate AS DATE) AS [ReleaseDate]
FROM tblFilm
WHERE CAST(FilmReleaseDate AS DATE)>Getdate()-7200
ORDER BY 
[ReleaseDate]
,Filmname

--Homework Using our College example, use the GetDate() command to find everyone whose enrolled within 5 years.

Select
GetUTCDate() AS [GetDate]

--Couldn't think of examples 

---GetDate
--> Explain use
---> Operative example I'll build is to say find 

--Dateddiff

SELECT
	DATEDIFF(day,GETDATE()-14,GETDATE())

SELECT 
	DATEDIFF(year,
(
	SELECT
		min(filmreleasedate) as [Releasedate]
	FROM tblfilm
),
(
	SELECT
		max(filmreleasedate) as [Releasedate]
	FROM tblfilm
	)) as [DaysDifference]

--Find the number of days difference between the earliest film of the 90s and the latest release of the 90s.



--SOUNDEX Function

--SOUNDEX Paired-->Tells how close the sound

SELECT
	DirectorName
	,LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1) AS [Firstname]
	,SOUNDEX(DirectorName)
	,SOUNDEX(LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1)) AS [Soundex Firstname]
FROM tblDirector
	WHERE SOUNDEX(LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1)) LIKE SOUNDEX('John')

SELECT
	d.Directorname
	,f.filmname
	,SOUNDEX(d.Directorname)
	,SOUNDEX(f.Filmname)
	,DIFFERENCE(d.DirectorName,f.FilmName) AS [Similarity]
FROM tblDirector AS d
INNER JOIN tblFilm AS f
ON d.DirectorID=f.FilmDirectorID
ORDER BY
	[Similarity] DESC

SELECT
	Directorname
	,DIFFERENCE(DIrectorname,'John') AS [Similarity]
FROM tblDirector
ORDER BY
	[Similarity] Desc

SELECT
FilmReleaseDate
FROM tblfilm 
WHERE filmreleasedate in



(
SELECT
max(filmreleasedate) as [Releasedate]
FROM tblfilm
)

(
SELECT
min(filmreleasedate) as [Releasedate]
FROM tblfilm
)

SELECT
	DATEDIFF(day,GETUTCDATE()-14,GETUTCDATE())



MAX(FilmreleaseDate)
FROM tblFilm
GROUP BY
FilmReleaseDate

--Homework On Filmnames, find the SOUNDEX returns for the  most common first word of movies
--Homework On Filmnames, find the SOUNDEX returns for the most common 2nd word of movies
