--in the homework sql problems, grep through all of them for the following words
-- SELECT
-- INNER JOIN
--- SELECT * (you might have to escape the star because its a keyword in bash, try single quotes instead of double quotes)
--How many Lines of SQl Code have we written

--Aggregated View of everything that joins

---Join Directors with film and Country

--#1 Make unified table of: 
--Director, film, Country, Language, Certificate
USE Movies
CREATE VIEW vwUnifiedMoviesTable
AS
SELECT *
FROM tblfilm AS f
INNER JOIN tblDirector AS d
	ON f.FilmDirectorID=d.DirectorID
INNER JOIN tblCountry AS c
	ON f.FilmCountryID=c.CountryID
INNER JOIN tblLanguage AS l
	ON f.FilmLanguageID=l.LanguageID
INNER JOIN tblCertificate AS Cert
	ON f.FilmCertificateID=Cert.CertificateID

--One of film count by Director
CREATE VIEW vwDirectorCount
AS
SELECT
	d.Directorname
	,COUNT(*) AS [MovieCount]
FROM tblfilm AS f
INNER JOIN tblDirector AS d
	ON f.FilmDirectorID=d.DirectorID
GROUP BY d.DirectorName
--ORDER BY  Note that "ORDER BY clause is invalid in views, inline functions, derived tables, subqueries, and common table expressions, unless TOP, OFFSET or FOR XML is also specified."
--[MovieCount] DESC
--,d.Directorname

SELECT * --SELF Note, one of the advantages to tables is that if you are preselecting one for the limited use, you can just pull * on it, rather than needing to list out all variables
FROM vwDirectorCount
ORDER BY 
	[FilmCount] DESC
	,DirectorName

--Sanity Check
SELECT
	f.FilmName
	,d.DirectorName
FROM tblfilm AS f
INNER JOIN tblDirector AS d
	ON f.FilmDirectorID=d.DirectorID
WHERE d.DirectorName = 'Steven Spielberg'
GROUP BY 
	d.DirectorName
	,f.Filmname
ORDER BY filmname

--And the other numbers of films by Country
CREATE VIEW vwCountryCount
AS
SELECT
	C.CountryName
	,Count(*) AS [FilmCount]
FROM tblFilm AS f
LEFT OUTER JOIN tblCountry AS c --Left Outer Join because we want all films that can be traced to Countries even if some have nulls 
ON f.FilmCountryID=c.CountryID
GROUP BY
	c.CountryName

SELECT *
FROM vwCountryCount
ORDER BY 
	[FilmCount] DESC
	,CountryName

--Sanity Check
SELECT
	f.Filmname
	,C.CountryName
FROM tblFilm AS f
LEFT OUTER JOIN tblCountry AS c
ON f.FilmCountryID=c.CountryID
WHERE c.CountryName='United States'
GROUP BY
	c.CountryName
	,f.filmname
ORDER By f.filmname

--Box Office By Country
CREATE VIEW vwCountryBoxOffice
AS
SELECT
	c.CountryName
	,SUM(CAST(f.FilmBoxOfficeDollars AS DECIMAL)) AS [NationalBoxOffice] --So added this because we can't sort by a Column formatted in Currency, but we can't include ORDER Bys in a view
	,FORMAT(SUM(CAST(f.FilmBoxOfficeDollars AS DECIMAL)),'C2')  AS [NationalBoxOffice$]
FROM tblFilm AS f
LEFT OUTER JOIN tblCountry AS c
ON f.FilmCountryID=c.CountryID
GROUP BY c.CountryName

--Call the view
SELECT 
	CountryName
	,NationalBoxOffice$
FROM vwCountryBoxOffice
ORDER BY NationalBoxOffice DESC --Sort by NationalBoxOffice which isn't currencyformatted, but not explicitly call it out. 
		,CountryName

--Sanity Check
SELECT 
	f.filmname
	,c.CountryName
	,ISNULL(f.FilmBoxOfficeDollars,0) AS [FilmBoxOffice]
FROM tblFilm AS f
INNER JOIN tblCountry AS c
ON f.FilmCountryID=c.CountryID
WHERE c.CountryName='United States'
--So I actually copied this to Excel and Summed it together. Totally value was "61883365665"

--Include a Drop view command at the end for all of them.
Drop View vwUnifiedMoviesTable,vwDirectorCount, vwCountryCount, vwCountryBoxOffice
--Bonus 
--Online Market Place make a view
--CREATE database OnlineMarketPlace
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

CREATE VIEW vwCustomerStar
AS
SELECT *
FROM Customer

CREATE VIEW vwCustomerCallOut
AS
SELECT
	AccountId
	,FirstName + ' ' + LastName AS [Name]
	,ReferralAccountID
FROM [Customer] 

SELECT *
FROM vwCustomerStar

SELECT *
FROM vwCustomerCallOut

sp_rename 'Customer.ReferralAccountID', 'Referral', 'COLUMN';

--Sanity Check
Select *
FROM [Customer]
--Okay renaming ReferralAccountID worked

SELECT *
FROM vwCustomerStar
--Keeps old ReferralAccountID name 
--Runs fine otherwise

SELECT *
FROM vwCustomerCallOut
--Get improper Columnname as expected, binding error. Fails to run

DROP VIEW vwCustomerStar, vwCustomerCallOut
DROP table [CUSTOMER]
--Return everything *
--Name all columns as alternative view
--Change Referral Code Name 
--See if both views break

