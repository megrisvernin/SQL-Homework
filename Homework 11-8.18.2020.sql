--Correlated Subqueries
--Homework 11

--#1 Highest Grossing Movie per year
USE MOVIES
SELECT
fo.FilmName
,FORMAT(fo.FilmBoxOfficeDollars,'C2') AS [BoxOffice]
,YEAR(fo.FilmReleaseDate)
FROM tblFilm AS fo
WHERE CAST(fo.FilmBoxOfficeDollars AS BIGINT) IN
(
SELECT MAX(fi.FilmBoxOfficeDollars) AS [HighestGross]
FROM tblFilm AS fi
WHERE YEAR(fi.FilmReleaseDate)=YEAR(fo.FilmReleaseDate)
)
ORDER BY
YEAR(fo.FilmReleaseDate) DESC
,fo.FilmBoxOfficeDollars DESC
,fo.FilmName

--#2 Highest Oscar Nominations Per country
SELECT
	c.CountryName
	,fo.FilmName
	,fo.FilmOscarNominations
FROM tblFilm AS fo
	INNER JOIN tblCountry AS c
	On fo.FilmCountryID=c.CountryID
WHERE fo.FilmOscarNominations IN
(
			Select Max(FilmOscarNominations) AS [MostOscarWins]
			FROM tblFilm AS fi
			WHERE fi.FilmCountryID=fo.FilmCountryID
)
ORDER By 
	c.CountryName
	,fo.FilmOscarNominations
	,fo.FilmName

--#3 films by directors whose movies were higher box office than the average for that director
SELECT
	d.DirectorName
	,fo.FilmName
	,FORMAT(fo.FilmBoxOfficeDollars,'C2') AS [BoxOffice]
FROM tblFilm AS fo
	INNER JOIN tblDirector AS d
	ON FilmDirectorID=DirectorID
WHERE fo.FilmBoxOfficeDollars>
(
			SELECT
			AVG(CAST(fi.FilmBoxOfficeDollars AS DECIMAL))
			FROM tblFilm AS fi
			WHERE fi.FilmDirectorID=fo.FilmDirectorID
)
ORDER BY
d.DirectorName
,fo.FilmBoxOfficeDollars DESC
,fo.FilmName

--Did a sample lookup to confirm it works:

SELECT
DirectorName
,FilmName
,FilmBoxOfficeDollars
FROM tblFilm
INNER JOIN tblDirector
ON FilmDirectorId=DirectorID
WHERE FilmDirectorID = 5
ORDER BY FilmDirectorID

--#4 For the 1990s, films that returned higher box office than average box office for the 1990s
--Had to correct under outer query to use WHERE for Film Release in the 1990s and FilmBoxOffice is greater than
SELECT
	FilmName
	,FORMAT(FilmBoxOfficeDollars,'C2') AS [BoxOffice]
	,YEAR(FilmReleaseDate) AS [ReleaseYear]
FROM tblFilm
WHERE Year(FilmReleaseDate) LIKE '199_'
AND FilmBoxOfficeDollars>
(
			SELECT
			AVG(CAST(FilmBoxOfficeDollars AS DECIMAL))
			FROM tblFilm
			WHERE YEAR(FilmReleaseDate) LIKE '199_'
)
ORDER BY FilmBoxOfficeDollars

--#5 'For the film x, it was niminated for x oscars and won X"
--First 3 Columns are to confirm it works
SELECT 
FilmName
,FilmOscarNominations
,FilmOscarWins
,FilmName+ ' was nominated for '+ CAST(FilmOscarNominations AS VARCHAR(2))+' oscars and won '+CAST(FilmOscarWins AS VARCHAR(2)) AS [Oscar Statements]
FROM tblFilm
ORDER BY
	FilmOscarNominations DESC,
	FilmOscarWins,
	FilmName

--#6 "Film X earned X Box Office and spent X on its budget"
--Kept first 3 columns to confirm the latter came out 
--For using Format in text combinations, it's already Varchar Don't need to use Cast
--Generally give Columns Nicknames
--Recommended to have spaces around pluses
SELECT 
	FilmName
	,FORMAT(FilmBoxOfficeDollars,'C2')
	,FilmBudgetDollars
	,FilmName+ ' earned ' + FORMAT(FilmBoxOfficeDollars,'C2') + ' and spent ' + FORMAT(FilmBudgetDollars,'C2')+ ' on its budget'  --For using Format in text combinations, it's already Varchar Don't need to use Cast AS [Statistics]
FROM tblFilm
ORDER BY 
	FilmBoxOfficeDollars DESC
	,FilmBudgetDollars DESC
	,FilmName

--#7-Find First and Last Name of Director
--List Director Name Japanese style(Last name first, first name last) Pelletier, Thomas
--Remember to only jon on tables that are relevant
Select
	DirectorName
	,DirectorID
--	,CHARINDEX(' ',DirectorName)-1
--	,LEN(DirectorName)-(CHARINDEX(' ',DirectorName)-1)
	,LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1) AS [FirstName]
	,RIGHT(DirectorName,LEN(DirectorName)-(CHARINDEX(' ',DirectorName)-1)) AS [LastName]
	,RIGHT(DirectorName,LEN(DirectorName)-(CHARINDEX(' ',DirectorName)-1)) + ', '+ LEFT(DirectorName,CHARINDEX(' ',DirectorName)-1) AS [FullName]
FROM tblDirector
ORDER By 
	DirectorName
	,DirectorID

--#8 Find the most common last word for movie names
SELECT
	CASE WHEN CHARINDEX(' ', Filmname)= 0 THEN Filmname
	ELSE RIGHT(Filmname,CHARINDEX(' ',REVERSE(Filmname))-1) 
	END As LastWord,
	Count(*) As [Count]
FROM tblFilm
GROUP BY
	CASE 
		WHEN CHARINDEX(' ', Filmname)= 0 THEN Filmname
		ELSE RIGHT(Filmname,CHARINDEX(' ',REVERSE(Filmname))-1) 
	END
ORDER BY
	[Count] DESC
	,LastWord

--Find the most common First Word

--#9a For SELECT 14.4/Cast(0.144 AS VARCHAR(3)) AND WHY
SELECT 14.4/CAST(0.144 AS VARCHAR(5))
--SQL Server is trying to do an implicit conversion on 0.14 as the base data tpyes don't match, converting varchar to a match decimal type. As the level of precision is to one decimal, 0.14 will be rounded to 1 decimal.

SELECT 14.400/CAST(0.144 as varchar(5))
--Use three significant digits on the first number and it'll do the same for the rest.

--#9b For SELECT 14.4/Cast(1.44 AS VARCHAR(3)) AND WHY
SELECT 4.4/CAST(1.44 as varchar(5))
--One decimal spot for 4.4 so it converts 1.44 to 1.4

--10 What is the Difference Between CAST and CONVERT?
--While both can be used to convert data from one type to another and what you can do with cast you can do with convert.
--Convert is SQL specific, while Cast can be used for databases supporting ANSI-SQL specifications
--Convert lets you specifiy optional style parameter for formatting. For example, 
--CONVERT(VARCHAR,GETDATE(),111) as YYYYDD
--CAST is better to prefer as it's more likely to be used in other DBMS

--11 What are the 4 types of DBMS, explain in your own words and example of each
--Hieararchical DBMS--Stores data in tree like structure, data stored as recorded connected to each other thru links.
---Windows XP is an example as is IBM's MangementSystem(IMS)
--Network DBMS--Supports many to many relationships, it often has complicated database setups. 
---An example is RdM server, Integrated Data Store(IDS)
--Relationshal DBMS--defines relationships in the form of tables. 
---Example is Microsoft SQL Server.
--Object Oriented DBMS-Data stored in objects that have traits called attributes, think color, country of origin etc. 
---Example is Postgresql
--Fifth is Document-oriented DBMS are key value stored. Key would be some unique ID number
--id --> Docuemnt
--Examples are MongoDb,dynamoDB

SELECT
FilmReleaseDate
From tblFilm

