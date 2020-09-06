--Script he ran

SELECT 
	f.filmname
	,d.DirectorName
	,f.filmname
	,f.filmdirectorid
FROM 
	TblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmdirectorid=d.directorid
	INNER JOIN tblstudio AS s
		ON f.FilmStudioID=studioid
	INNER JOIN tblCOUNTry AS c
		ON f.filmCOUNTryid=c.COUNTryid
--Below Example replaced with Left, want to return Directors who have NOT directed movies

SELECT 
	f.filmname
	,d.DirectorName
	,f.filmname
	,f.filmdirectorid

--Have commas before so you don't have dropped commmas
FROM 
	TblFilm AS f
	LEFT OUTER JOIN tblDirector AS d
		ON f.filmdirectorid=d.directorid
	INNER JOIN tblstudio AS s
		ON f.FilmStudioID=studioid
	INNER JOIN tblCOUNTry AS c
		ON f.filmCOUNTryid=c.COUNTryid
WHERE 
	f.filmid is null --returns WHERE it lists directors who have not directed films in database

--Another example: INNER this one returns ONLY examples WHERE an Actor is a Director
SELECT 
	*
FROM
	tblActor AS a
	INNER JOIN tblDirector AS d
		ON a.ActorName=d.DirectorName
--In this example BELOW it lists actors who have NOT been directors
SELECT 
	*
FROM
	tblActor AS a
	Left Outer JOIN tblDirector AS d
		ON a.ActorName=d.DirectorName
WHERE
	d.DirectorID is Null
--In this example below it lists directors who have NOT	been Actors
	
SELECT 
	*
FROM
	tblActor AS a
	RIGHT OUTER JOIN tblDirector AS d
		ON a.ActorName=d.DirectorName
WHERE
	a.actorID is Null
	
/*In this example BELOW it returns ALL Data including:
	Actors who have been directors
	Actors who have not been directors
	Directors who have not been actors
	*/
	
SELECT 
	*
FROM
	tblActor AS a
	FULL OUTER JOIN tblDirector AS d
		ON a.ActorName=d.DirectorName
	
SELECT 
	*
FROM 
	tblActor AS a
	INNER JOIN tblCast AS c
		ON a.ActorID=c.CastActorID

SELECT *
FROM 
	tblCOUNTry AS a

--QUESTION 1:
--List all directors who only make movies in the US

SELECT 
	d.DirectorName
	,COUNT(Distinct c.countryName) AS 'Total COUNTries They Direct In'
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmDirectorID = d.DirectorID
	INNER JOIN tblCountry AS c
		ON f.filmCountryid = c.CountryID
WHERE
	c.CountryName= 'United States' 
GROUP BY
	d.DirectorName
HAVING 
	COUNT(Distinct c.CountryName)= ('1')

--Conduct further work in Excel

--QUESTION 2:
--For the US list movies by top grossing (ORDER BY)
SELECT
	f.Filmname
	,c.CountryName
	,f.FilmBoxOfficeDollars
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmDirectorID = d.DirectorID
	RIGHT OUTER JOIN tblCountry AS c
		ON f.filmCountryid = c.CountryID
WHERE 
	c.CountryName= 'United States' 
AND 
	f.FilmBoxOfficeDollars is NOT null
ORDER BY 
	f.FilmBoxOfficeDollars desc
	, c.CountryName
	,f.Filmname;

--QUESTION 3:
--List NZ films by run length (ORDER BY)
SELECT
	f.Filmname
	,c.CountryName
	,f.FilmRunTimeMinutes
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmDirectorID = d.DirectorID
	RIGHT OUTER JOIN tblCountry AS c
		ON f.filmCountryid = c.CountryID
WHERE 
	c.CountryName= 'New Zealand' 
ORDER BY 
	f.FilmRunTimeMinutes desc;

--QUESTION 4:
--Sum the number of Oscar Nominations and Oscar Wins by Directors
SELECT DISTINCT
	d.DirectorName
	,SUM(f.FilmOscarNominations) AS 'Director Oscar Nominations'
	,SUM(f.FilmOscarWins) AS 'Director Oscar Wins'
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		On f.filmDirectorID = d.DirectorID
GROUP BY
	d.DirectorName
	,f.Filmname
	,f.FilmOscarNominations
	,f.FilmOscarWins
ORDER BY
	'Director Oscar Nominations' desc;

--QUESTION 5:
--What is avg box office for US films?
SELECT 
	AVG(CONVERT(BIGINT, f.FilmBoxOfficeDollars)) AS [Total] --Total probably needs Brackets because the TOTAL command is used in other SQL Commands
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmDirectorID = d.DirectorID
	RIGHT OUTER JOIN tblCountry AS c
		ON f.filmCountryid = c.CountryID
WHERE 
	c.CountryName= 'United States' 
AND 
	f.FilmBoxOfficeDollars is NOT null

--QUESTION 6:
--List all films that occurred in New Zealand
SELECT
	f.Filmname
	,d.DirectorName
	,c.CountryName
FROM 
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmDirectorID = d.DirectorID
	RIGHT OUTER JOIN tblCountry AS c
		ON f.filmCountryid = c.CountryID
WHERE
	c.CountryName= 'New Zealand' 

--QUESTION 7:
--List the name of all non-english films in the united states (if it doesnt exist, pick english films in dif country)
SELECT
	f.Filmname
	,d.DirectorName
	,l.Language
	,c.CountryName
	,f.FilmRunTimeMinutes
FROM
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.filmDirectorID = d.DirectorID
	RIGHT OUTER JOIN tblCountry AS c
		ON f.filmCountryid = c.CountryID
	INNER JOIN tblLanguage AS l
		ON f.FilmLanguageID=l.LanguageID
WHERE
	l.Language <> 'English'
AND
	c.CountryName= 'United States' 

--QUESTION 8:
--List the name of studios and the count of all the films in those studios
SELECT
	s.StudioName
	,Count(f.FilmName) AS TotalFilms
FROM
	tblFilm AS f
	INNER JOIN tblStudio AS s
		ON f.FilmStudioID=s.StudioID
GROUP BY
	s.StudioName
ORDER BY
	TotalFilms desc

--QUESTION 9:
--List all actors who have the same birthday
SELECT 
	CONVERT(varchar(5),a.actorDOB,110) AS Birthday
	,Count(a.actorDOB) AS BirthdayCount
	,a.ActorDOB
FROM
	tblActor AS a
WHERE
	a.actorDOB is NOT null
GROUP BY
	a.ActorDOB
HAVING 
	Count(a.actorDOB)> 1
ORDER BY
	BirthdayCount desc;

SELECT DISTINCT
	CONVERT(varchar(5),a1.ActorDOB,110)
FROM
	tblActor AS a1
    INNER JOIN tblActor AS a2
        ON a1.ActorDOB = a2.ActorDOB
WHERE
	CONVERT(varchar(5),a1.ActorDOB,110) = CONVERT(varchar(5),a2.ActorDOB,110)
AND
	a1.ActorID != a2.ActorID

--Now look up those dates:
SELECT
	a.ActorName
	,CONVERT(varchar(5),a.actorDOB,110) AS Birthday
	,a.ActorDOB
FROM 
	tblActor AS a
WHERE
	a.actorDOB is NOT null
GROUP BY
	a.ActorName,a.ActorDOB
HAVING CONVERT(varchar(5),a.actorDOB,110) IN ('02-21'
	,'04-13'
	,'03-29'
	,'04-15'
	,'12-03'
	,'08-18'
	)
ORDER BY
	Birthday

SELECT
	a.ActorName
	,CONVERT (varchar(5),a.ActorDOB,110)
FROM
	tblActor AS a
WHERE
	CONVERT(varchar(5),a.ActorDOB,110) IN 
	( -- all the birthdays that match at least 1 other person
SELECT DISTINCT
	CONVERT (varchar(5),a1.ActorDOB,110)
FROM
	tblActor AS a1
    INNER JOIN tblActor AS a2
        ON a1.ActorDOB = a2.ActorDOB
WHERE
	CONVERT (varchar(5),a1.ActorDOB,110) = CONVERT (varchar(5),a2.ActorDOB,110)
AND
	a1.ActorID != a2.ActorID
)
ORDER BY
	CONVERT(varchar(5),a.ActorDOB,110)

--QUESTION 10:
--List the actor who has been in the most films (ORDER BY)*/
Select Top 1
	a.ActorName 
	,COUNT(f.FilmName) AS TotalFilms
FROM 
	tblActor AS a
		INNER JOIN tblCast AS c
		ON a.ActorID = c.CastActorID
	INNER JOIN tblFilm AS f
		ON c.CastFilmID=f.FilmID
GROUP BY
	a.ActorName
ORDER BY
	TotalFilms desc;