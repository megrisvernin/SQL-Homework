--Question 1
--Use Update statement to ADD CONSTRAINTs, add relevaqnts from before and any new ones that seem relevant, 
--add foreign keys according to diagram
--Andrew do Enrollment and Course
--Thomas Fill out ClassLocation and Semmester
--Both do Major and Student, format VALUES to match new table"
--Question 2
--Return Filname, FilmeRunTime WHERE SUBQUERY Returns 
--Run Time between 90 and 120 Minutes
--Using Wherelookup
Select
filmname
,FilmRunTimeMinutes
From tblfilm
WHERE FilmRunTimeMinutes BETWEEN 90 AND 120
ORDER BY Filmname

--Use Subquery
USE Movies
SELECT
	Filmname
	,FilmRunTimeMinutes
FROM 
	tblFilm
WHERE
	FilmRunTimeMinutes IN
		(SELECT
			FilmRunTimeMinutes
		FROM
			tblFilm
		WHERE 
			FilmRunTimeMinutes BETWEEN 90 AND 120)

--Question 3
--What films were released in the same year as around the world in 80 days, use a subquery to do this
--Note to self King Kong is 3 movies 
--IN

SELECT
	FilmName
	,FilmReleaseDate
	,DATENAME(Year,FilmReleaseDate) AS YEAR
FROM
	tblFilm
WHERE 
	DATENAME(Year,FilmReleaseDate) = --IN works for queries returning multiple items, = is only good for a subquery looking up one item
		(SELECT 
			DATENAME(Year,FilmReleaseDate)
		FROM
			tblfilm
		WHERE 
			Filmname = 'Around the World in 80 days')

--Question 3
--What films were released in the same year as King Kong, use a subquery to do this
--Note to self King Kong is 3 movies 
--=
SELECT
	FilmName
	,FilmReleaseDate
	,DATENAME(YEAR,FilmReleaseDate) AS [Year]
FROM
	tblFilm
WHERE
	DATENAME(YEAR,FilmReleaseDate) IN --IN works for queries returning multiple items, = is only good for a subquery looking up one item
		(SELECT 
			DATENAME(YEAR,FilmReleaseDate)
		FROM
			tblfilm
		WHERE
			Filmname = 'Around the World in 80 days')

--Question 4
--What films were released in the same year as Serenity, use a subquery to do this
--IN

SELECT
	FilmName
	,FilmReleaseDate
	,DATENAME(Year,FilmReleaseDate) AS Year
FROM
	tblFilm
WHERE
	DATENAME(Year,FilmReleaseDate) IN
		(SELECT 
			DATENAME(Year,FilmReleaseDate)
		FROM
			tblfilm
		WHERE
			Filmname = 'Serenity')
ORDER BY Filmname

--Question 3
--What films were released in the same year as Serenity, use a subquery to do this
--Note to self King Kong is 3 movies 
--=
SELECT
	FilmName
	,FilmReleaseDate
	,DATENAME(YEAR,FilmReleaseDate) AS year
FROM
	tblFilm
WHERE
	DATENAME(YEAR,FilmReleaseDate) =
		(SELECT 
			DATENAME(YEAR,FilmReleaseDate)
		FROM
			tblfilm
		WHERE 
			Filmname = 'Serenity')

--Homework 10
--Examples of
-- subquery returning a set of VALUES
-- subquery returning a single value"

