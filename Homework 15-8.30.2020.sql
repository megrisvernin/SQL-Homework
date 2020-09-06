-Homework 15
--Add Topics I intro from last Thursday
--Properly Indent and Format SQL Coding

--Thomas Only
--Problem 1, find the most common SOUNDEX value for the  most common last word of filmnamnes

USE MOVIES
--Test look getting coding for looking Last Word
SELECT
	filmname
	,CHARINDEX(' ',filmname)
	,CHARINDEX(' ',REVERSE(filmname))-1
	,RIGHT(filmname,CHARINDEX(' ',REVERSE(filmname))) AS [LastWord]
FROM tblFilm
ORDER BY [LastWord] DESC

--Actual lookup
SELECT
	SOUNDEX(
		CASE 
			WHEN filmname LIKE '% %' THEN RIGHT(filmname,CHARINDEX(' ',REVERSE(filmname))-1)
			ELSE filmname
		END
		)AS [Soundex]
	,COUNT(*) AS [Count]
FROM Tblfilm
WHERE filmname NOT LIKE '% [0-9]'
AND filmname != '300' --NOT A and NOT B (will be true if A is false or if B is false)
GROUP BY
	SOUNDEX(
		CASE 
			WHEN filmname LIKE '% %' THEN RIGHT(filmname,CHARINDEX(' ',REVERSE(filmname))-1)
			ELSE filmname
		END
		)
ORDER BY 
	[Count] DESC
	,[Soundex]

--filmname Sanity Check
SELECT
	filmname
	,SOUNDEX(
		CASE 
			WHEN filmname LIKE '% %' THEN RIGHT(filmname,CHARINDEX(' ',REVERSE(filmname))-1)
			ELSE filmname
		END
		)AS [Soundex]
	,COUNT(*) AS [Count]
FROM Tblfilm
WHERE filmname NOT LIKE '% [0-9]'
	AND filmname != '300'
GROUP BY
	SOUNDEX(
		CASE 
			WHEN filmname LIKE '% %' THEN RIGHT(filmname,CHARINDEX(' ',REVERSE(filmname))-1)
			ELSE filmname
		END
		)
	,filmname
ORDER BY [Soundex]
--Noted that movies ending in a number produce SOUNDEX value of 0

--Problem 2, find the most common SOUNDEX value for the  most common last word of DirectorName
--Actual lookup
SELECT
	SOUNDEX(
		CASE 
			WHEN Directorname LIKE '% %' THEN RIGHT(Directorname,CHARINDEX(' ',REVERSE(Directorname))-1)
			ELSE Directorname
		END
		)AS [Soundex]
	,COUNT(*) AS [Count]
FROM tblDirector
GROUP BY
	SOUNDEX(
		CASE 
			WHEN Directorname LIKE '% %' THEN RIGHT(Directorname,CHARINDEX(' ',REVERSE(Directorname))-1)
			ELSE Directorname
		END
		)
ORDER BY 
	[Count] DESC
	,[Soundex]
	

--Directorname Sanity Check
SELECT
	Directorname
	,SOUNDEX(
		CASE 
			WHEN Directorname LIKE '% %' THEN RIGHT(Directorname,CHARINDEX(' ',REVERSE(Directorname))-1)
			ELSE Directorname
		END
		)AS [Soundex]
	,COUNT(*) AS [Count]
FROM tblDirector
GROUP BY
	SOUNDEX(
		CASE 
			WHEN Directorname LIKE '% %' THEN RIGHT(Directorname,CHARINDEX(' ',REVERSE(Directorname))-1)
			ELSE Directorname
		END
		)
	,Directorname
ORDER BY [Soundex]

--Problem 3 
--Homework Problem-Show all customers included the name of whoever referred if they had a referral 

--Add OnlineMarketPlace to Github

--Add the newest table we wrote OnlineMarketPlace to GitHub
--USE CASE
--Work this out using Incremental Columns

--Do not do if could not find answer to Bonus
--Find first position with Char Index and then nest another Charindex for the next 
--Make file with all project for college and move to git hub. Difference repository to hello world

--Create database OnlineMarketPlace
USE OnlineMarketPlace
CREATE TABLE [Customer] (
  [AccountID] Int Identity(1,1),
  [FirstName] varchar(40),
  [LastName] varchar(40),
  [ReferralAccountID] Int default NULL,
  PRIMARY KEY ([AccountID])
);

INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Jeff','Jones',NULL)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Lisa','Lane',1)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('River','Roads',1)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Sean','Street',1)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Peter','Parker',7)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Reed','Richardson',7)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Michael','Michaelson',NULL)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('Keanu','Reeves',7)
INSERT INTO [Customer](FirstName,LastName,ReferralAccountID) VALUES('George','Toyota',1)

Select *
FROM [Customer]

SELECT
	cust.AccountId
	,cust.FirstName + ' ' + cust.LastName AS [Name]
	,cust.ReferralAccountID
	,refer.FirstName + ' ' + refer.LastName AS [Referral]
FROM [Customer] AS cust
LEFT OUTER JOIN [Customer] AS refer
	ON refer.AccountID=cust.ReferralAccountID

--Homework Problem-Show all customers included the name of whoever referred if they had a referral 
Drop Table [Customer]

--Ask Andrew how to do Git add multiple files at once

