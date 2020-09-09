USE Movies
--#1-Is there a way to do Order By with it Formatted as currency

--#2-Rewrite 5 movie releases by decade with yyyy-mm-dd
SELECT
	Filmname
	,FilmReleaseDate
	,CASE
		WHEN FilmReleaseDate<='1939-12-31' THEN '30s'
		WHEN FilmReleaseDate<='1949-12-31' THEN '40s'
		WHEN FilmReleaseDate<='1959-12-31' THEN '50s'
		WHEN FilmReleaseDate<='1969-12-31' THEN '60s'
		WHEN FilmReleaseDate<='1979-12-31' THEN '70s'
		WHEN FilmReleaseDate<='1989-12-31' THEN '80s'
		WHEN FilmReleaseDate<='1999-12-31' THEN '90s'
		WHEN FilmReleaseDate<='2009-12-31' THEN '2000s'
		WHEN FilmReleaseDate<='2019-12-31' THEN '2010s'
	END AS 'Decade'
FROM 
	tblFilm
GROUP BY 
	Filmname
	,FilmReleaseDate
ORDER BY 
FilmReleaseDate;

--Question 3:
--Return Films released between 2000 and 2010
--Write Out Date
SELECT
	FilmID
	,FilmName
	,FilmReleaseDate
FROM
	tblFilm
WHERE FilmReleaseDate BETWEEN '2000-01-01' AND '2000-12-31'
ORDER BY
	FilmName;

--Use Years
SELECT
	FilmID
	,FilmName
	,FilmReleaseDate
FROM
	tblFilm
WHERE YEAR(FilmReleaseDate) BETWEEN 2000 AND 2010
ORDER BY
	FilmName;

--Question 4:
--All movies that start with the letter A to F using <WHERE varchar(myStr, 1) Between 'A' and 'F')?
SELECT
	,FilmName
FROM
	tblFilm
WHERE CONVERT(varchar(1),FilmName) BETWEEN 'A' AND 'F'
ORDER BY Filmname ASC;

SELECT
	FilmName
	,SUBSTRING(filmName,1,1) AS FirstLetter
FROM
	tblFilm
WHERE SUBSTRING(filmName,1,1) BETWEEN 'A' AND 'F'
ORDER BY Filmname ASC;

--Question 5:
-- WHERE Runtime is BETWEEN 90 AND 120 AND between 2000 and 2010 OR Starts with T

SELECT
	FilmName
	,FilmRunTimeMinutes AS Runtime
	,FilmReleaseDate
FROM
	tblFilm
WHERE 
	FilmRunTimeMinutes BETWEEN 90 AND 120
	AND YEAR(FilmReleaseDate) BETWEEN 2000 AND 2010
	OR FilmName Like 't%'
ORDER BY FilmRunTimeMinutes

--Question 6:
-- Where Runtime is BETWEEN 90 AND 120 AND (between 2000 and 2010 OR Starts with T)
SELECT
	FilmName
	,FilmRunTimeMinutes AS Runtime
	,FilmReleaseDate
FROM
	tblFilm
WHERE 
	FilmRunTimeMinutes BETWEEN 90 AND 120
	AND( YEAR(FilmReleaseDate) BETWEEN 2000 AND 2010
	OR FilmName Like 't%')
ORDER By FilmRunTimeMinutes

--Question 7:
--"All movies that do not contain the string Harry Potter
--Like NOT "
SELECT
	FilmName
FROM
	tblFilm
WHERE 
	Filmname NOT LIKE '%Harry Potter%'
ORDER BY
	Filmname ASC

--Question 8:
--What are all the movies with either a null budget or a null box office (Must use ISNULL function)
SELECT
	FilmCertificateID
	,FilmName
	,FilmBoxOfficeDollars
	,FilmBudgetDollars
FROM
	tblFilm
WHERE FilmBoxOfficeDollars IS NULL
OR FilmBudgetDollars IS NULL

--Question 9:Install new SQL Update
--Done

Exa,[;e u