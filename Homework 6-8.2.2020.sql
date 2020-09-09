--HW 6

--Problem 1:
--Find by Filmname Revenue/ Budget of Budget(bod office dived by budget) decimal format

USE Movies
SELECT
	FilmName
	--,FilmBoxOfficeDollars/FilmBudgetDollars
	,CAST(FilmBoxOfficeDollars AS DECIMAL)/ FilmBudgetDollars AS [RevenueRatio]
FROM 
	tblFilm
ORDER By [RevenueRatio] DESC

--Problem 2:
--Put Box Office in Millions of Dollars 
USE MOVIES
SELECT 
	FILMNAME
	,FilmBoxOfficeDollars/(1000000.0) AS [Millions of Dollars]
	,FORMAT(FilmBoxOfficeDollars / (1000000.0),'C1')+' Million' AS [BOXOFFICEINMILLIONS]
FROM 
	tblFILM
ORDER BY [Millions of Dollars] DESC
--Problem 3:
--By Country how many days, hours, minutes, seconds of movies are there  (ex 21 days, 10 hours, 15 minutes, 00 seconds)
--Hours and Minutes
SELECT
FilmCountryID
,SUM(CAST(FilmRunTimeMinutes AS DECIMAL)) AS [Total Minutes]
--minutes/ minutes per day
,SUM(FilmRunTimeMinutes) / (60*24) AS [Days]
--minutes divided by minutes per day (mod 24 since there are max 24 hours in a day)
,(SUM(FilmRunTimeMinutes) % (60*24)/60) [Hours]
,(SUM(FilmRunTimeMinutes) % (60*24)%60) [Minutes]
,0 AS SECONDS
--Seems FilmRunTIme is integer filetype and listed in minutes so wouldn't be any 'seconds' to peel out.
FROM 
	tblFILM
GROUP BY
FilmCountryID


