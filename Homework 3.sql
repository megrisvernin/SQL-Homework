USE MOVIES
--QUESTION 1:
--Return film names that contain the word THE (case insensitive) but don't start with the word the

SELECT
	f.Filmname,
	CASE
		WHEN f.Filmname LIKE 'The%' AND f.Filmname LIKE '%_The%' THEN 'Both'
		WHEN f.Filmname LIKE 'The%' THEN 'Start'
		WHEN f.Filmname LIKE '%The%' THEN 'Inner'
		ELSE 'Neither'
	END AS [THE Organizing]
FROM 
	tblFilm AS f
Order By 
	[THE Organizing]
	,f.Filmname ASC

--QUESTION 2: 
--Return films that were released on the 13th
--Includes some playing around with dates
SELECT
	Filmname
	,FilmReleaseDate
	,CONVERT(varchar(5),FilmReleaseDate,110) AS [Date] --This Column isn't necessary
	,CONVERT(varchar(5),MONTH(FilmReleaseDate))+'-'+CONVERT(varchar(5),Day(FilmReleaseDate))
	,CONVERT(varchar(5),YEAR(FilmReleaseDate))+'-'+CONVERT(varchar(5),MONTH(FilmReleaseDate))+'-'+CONVERT(varchar(5),DAY(FilmReleaseDate)) AS [FULL DATE]
	,MONTH(FilmReleaseDate) AS [DayOfTheMonth]
	,DAY(FilmReleaseDate) AS [DayOfTheMonth]
FROM 
	tblFilm
GROUP BY 
	filmname
	,FilmReleaseDate
HAVING
	DAY(FilmReleaseDate)='13';

--QUESTION 3:
--Label countries with English or Non-English
SELECT
	f.filmname
	,l.Language
	,CASE
		WHEN l.language='English' THEN 'ENGLISH SPEAKING'
		ELSE 'NON-ENGLISH SPEAKING'
	END AS [English Speaking World]
FROM 
	tblFilm AS f
	INNER JOIN tblLanguage AS l
		ON f.FilmLanguageID=l.LanguageID
ORDER BY 
	[English Speaking World]
	,l.language;

--QUESTION 4:
--Films by Profitability
SELECT
	s.StudioName
	,f.Filmname
	,FORMAT(f.FilmBoxOfficeDollars, 'C2') as [Revenue]
	,FORMAT(f.FilmBudgetDollars,'C2') as [Budget]
	,FORMAT(f.FilmBoxOfficeDollars-f.FilmBudgetDollars,'C2') AS [Profit]
	,CASE 
		WHEN f.FilmBoxOfficeDollars > f.FilmBudgetDollars THEN 'Profitable'
		ELSE 'Unprofitable'
	END AS 'Profitability' 
FROM
	tblFilm AS f
	INNER JOIN tblStudio AS s
		ON f.FilmStudioID=S.StudioID
WHERE 
	f.FilmBoxOfficeDollars IS NOT NULL
AND 
	f.FilmBudgetDollars IS NOT NULL;

--Studio Profit Order By Profitability no formatting
Select 
	s.StudioName
	,SUM(CAST(f.FilmBoxOfficeDollars AS BIGINT)) AS [STUDIO_REVENUE]
	,SUM(CAST(f.FilmBudgetDollars AS BIGINT)) AS [STUDIO_BUDGET]
	,SUM(CAST(f.FilmBoxOfficeDollars-f.FilmBudgetDollars AS BIGINT)) AS [STUDIO_PROFITABILITY]
	,CASE WHEN SUM(CAST(f.FilmBoxOfficeDollars-f.FilmBudgetDollars AS BIGINT))>0 THEN 'PROFITABLE'
	ELSE 'UNPROFITABLE'
	END as 'Profitability'
FROM 
	tblFilm AS f
	INNER JOIN tblStudio AS s
		ON f.FilmStudioID=s.StudioID
WHERE 
	f.FilmBoxOfficeDollars IS NOT NULL
AND 
	f.FilmBudgetDollars  IS NOT NULL
GROUP BY
	s.StudioName
ORDER BY 
	[STUDIO_PROFITABILITY] desc;

--Studio Profit Order Formatted as Currency
Select 
	s.StudioName
	,FORMAT(SUM(CAST(f.FilmBoxOfficeDollars AS BIGINT)),'C2') AS [STUDIO_REVENUE]
	,FORMAT(SUM(CAST(f.FilmBudgetDollars AS BIGINT)),'C2') AS [STUDIO_BUDGET]
	,FORMAT(SUM(CAST(f.FilmBoxOfficeDollars-f.FilmBudgetDollars AS BIGINT)),'C2') AS [STUDIO_PROFITABILITY]
	,CASE WHEN SUM(CAST(f.FilmBoxOfficeDollars-f.FilmBudgetDollars AS BIGINT))>0 THEN 'PROFITABLE'
	ELSE 'UNPROFITABLE'
	END as 'Profitability'
FROM 
	tblFilm AS f
	INNER JOIN tblStudio AS s
		ON f.FilmStudioID=s.StudioID
WHERE 
	f.FilmBoxOfficeDollars IS NOT NULL
AND 
	f.FilmBudgetDollars  IS NOT NULL
GROUP BY
	s.StudioName
ORDER BY COL_LENGTH(Profitability)

--QUESTION 5:
--Organize movie releases by decade (>= 1990 is 90s, >= 2000 is 2000s, >= 2010 is 2010s
SELECT
	f.Filmname
	,f.FilmReleaseDate
	,YEAR(f.FilmReleaseDate) AS [YEAR]
	,CASE
		WHEN YEAR(f.FilmReleaseDate) <=1939 THEN '30s'
		WHEN YEAR(f.FilmReleaseDate) <=1949 THEN '40s'
		WHEN YEAR(f.FilmReleaseDate) <=1959 THEN '50s'
		WHEN YEAR(f.FilmReleaseDate) <=1969 THEN '60s'
		WHEN YEAR(f.FilmReleaseDate) <=1979 THEN '70s'
		WHEN YEAR(f.FilmReleaseDate) <=1989 THEN '80s'
		WHEN YEAR(f.FilmReleaseDate) <=1999 THEN '90s'
		WHEN YEAR(f.FilmReleaseDate) <=2009 THEN '2000s'
		WHEN YEAR(f.FilmReleaseDate) <=2019 THEN '2010s'
	END AS 'Decade'
FROM 
	tblFilm AS f
GROUP BY 
	f.Filmname
	,f.FilmReleaseDate
ORDER BY 
[Year]

/* QUESTION 6: 
Use a Case statement for directors to label them as
=0 'Nutin'
=1 One Shot
<4 A Couple
<6 A Lot
Everything else SHIT TON */
SELECT
	d.DirectorName
	,COUNT(f.FilmID) AS [Film Number]
	,CASE
		WHEN COUNT(f.FilmID)=0 THEN 'Nutin' 
		WHEN COUNT(f.FilmID)=1 THEN 'One shot' 
		WHEN COUNT(f.FilmID)<=3 THEN 'A Couple' 
		WHEN COUNT(f.FilmID)<=5 THEN 'A Lot' 
		ELSE 'Shit Ton'
	END AS [How much you got?]
FROM
	tblFilm AS f
	INNER JOIN tblDirector AS d
		ON f.FilmDirectorID=d.DirectorID
GROUP BY
	d.DirectorName
ORDER BY
	[Film Number] desc

Select
	[FilmName][FilmID], [FilmName], [FilmReleaseDate], [FilmDirectorID], [FilmLanguageID], [FilmCountryID], [FilmStudioID], [FilmSynopsis], [FilmRunTimeMinutes], [FilmCertificateID], [FilmBudgetDollars], [FilmBoxOfficeDollars], [FilmOscarNominations], [FilmOscarWins]
From 
	tblFilm