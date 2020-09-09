--Homework 16
--#1 Try to create a schema and try to have two tables same name, one with default dbo other with Schema

CREATE table test1 (ID int)
SELECT * from test1

CREATE Schema test
CREATE table test.test1 (ID Int)

INSERT INTO test.test1 VALUES (7)
INSERT INTO dbo.test1 VALUES (9)

SELECT * from test.test1
SELECT * from dbo.test1

Drop Table test1, test.test1
Drop Schema test

--Nominally seems to have worked

--Bonus Thomas-Watch Wise Owl video: https://www.youtube.com/watch?v=dspNtyemezo&list=PLNIs-AWhQzcl9QXUSb0GRTxa2XlTHqDE8&index=1
--Install and inform Andrew of any relevant parts:
--Seems to work, didn't install SQl server major program link. Following nhis instructions gives SQL Server Developer 2017 instead of the 2016 in the video.


--#2 Try and write out some strings, use Cast, Convert and Parse on following

--'Saturday 5, September 2020'
SELECT PARSE('Saturday 5, September 2020' AS date) AS 'Parse1' --Parse Succeeds
SELECT CAST('Saturday 5m September 2020' AS date) AS 'Cast1' --Cast Fails
SELECT CONVERT(date,'Saturday 5m September 2020') AS 'Convert1'	 --Convert fails

--'Saturday 5 September 2020'
SELECT PARSE('Saturday 5 September 2020' AS date) AS 'Parse2' --Parse Succeeds
SELECT CAST('Saturday 5 September 2020' AS date) AS 'Cast2' --Cast Fails
SELECT CONVERT(date,'Saturday 5 September 2020') AS 'Convert2' --Convert fails
	
--'Wed, 18 September 2019'
SELECT PARSE('Wed, 18 September 2019' AS date) AS 'Parse3' --Parse Succeeds
SELECT CAST('Wed, 18 September 2019' AS date) AS 'Cast3' --Cast Fails
SELECT CONVERT(date,'Wed, 18 September 2019' ) AS 'Convert3'  --Convert fails 

--'Wed 18 September 2019'
SELECT PARSE('Wed 18 September 2019' AS date) AS 'Parse4' --Parse Succeeds
SELECT CAST('Wed 18 September 2019' AS date) AS 'Cast4' --Cast Fails
SELECT CONVERT(date,'Wed 18 September 2019') AS 'Convert4'  --Convert fails	 

--'Wednesday 18 Sept 2019'
SELECT PARSE('Wednesday 18 Sept 2019' AS date) AS 'Parse5' --Parse Fails
SELECT CAST('Wednesday 18 Sept 2019' AS date) AS 'Cast5' --Cast Fails
SELECT CONVERT(date,'Wednesday 18 Sept 2019') AS 'Convert5'	 --Convert fails

--'6543'
SELECT PARSE('6543' AS INT) AS 'Parse6' --Parse Succeeds
SELECT CAST('6543' AS INT) AS 'Cast6' --Cast Succeeds
SELECT CONVERT(INT,'6543') AS 'Convert6'	--Convert Succeeds

--'6,543'
SELECT PARSE('6,543' AS INT) AS 'Parse7' --Parse Succeeds
SELECT CAST('6,543' AS INT) AS 'Cast7' --Cast Fails
SELECT CONVERT(INT,'6,543') AS 'Convert7' --Convert Fails

--'6443,00'
SELECT PARSE('6443,00' AS DEC) AS 'Parse8' --Parse Succeeds
SELECT CAST('6443,00' AS INT) AS 'Cast8' --Cast Fails
SELECT CONVERT(INT,'6443,00') AS 'Convert8'	--Convert Fails

--#3 Get movies made in the 80s, save as Temp Table (Method 1)
USE MOVIES
SELECT 
	FilmName
	,FilmBoxOfficeDollars AS [FilmBoxOffice]
	,FilmBudgetDollars AS [FilmBudget]
	,YEAR(FilmReleaseDate) AS [Year]
INTO #TempTable
FROM tblfilm
WHERE YEAR(FilmReleaseDate) Between '1980' and '1989'
ORDER BY [Year]

SELECT *
FROM #TempTable

--From that Temp table find Box Office+Budget, and Box Office/Budget
SELECT 
	Filmname
	,FORMAT([FilmBoxOffice],'C2') AS [FilmBoxOffice]
	,FORMAT([FilmBudget],'C2')  AS [FilmBudget]
	,CAST(([FilmBoxOffice]/[FilmBudget]) AS VARCHAR(10)) AS [Box Ratio]
	,[Year]
	,FilmName + ' had a box office of ' + CAST(FORMAT([FIlmBoxOffice],'C2') AS VARCHAR(20)) + ' on a budget of ' + CAST(FORMAT([FilmBudget],'C2') AS VARCHAR(20)) 
	+ ' and had a Ratio of Box Office/Budget of ' + CAST(([FilmBoxOffice]/[FilmBudget]) AS VARCHAR(10)) AS [Statement]
FROM #TempTable
ORDER BY
	[Year]
	,[FilmBoxOffice] DESC
--2nd query, correlated subquery return top box office per year
SELECT
	tempo.Filmname
	,FORMAT(tempo.[FilmBoxOffice],'C2') AS [BoxOffice]
	,tempo.[Year]
FROM #TempTable AS tempo
WHERE CAST(tempo.[FilmBoxOffice] AS DECIMAL) IN
(
	SELECT
		MAX(tempi.[FilmBoxOffice]) AS [HighestGrossing]
	FROM #TempTable tempi
		WHERE tempi.[Year]=tempo.[Year]
	)
ORDER BY
	tempo.[Year]
	,[BoxOffice]

--Bonus redo Problem 3 using Method 2

Create Table #TempTable2
(
	Filmname Varchar(max)
	,[FilmBoxOffice] INT
	,[FilmBudget] INT
	,[Year] INT
)

--Two Methods Here-Lazy Bones is:
INSERT INTO #TempTable2
SELECT *
FROM #TempTable
--Actual Effort is:

INSERT INTO #TempTable2
SELECT 
	Filmname
	,FilmBoxOfficeDollars AS [FilmBoxOffice]
	,FilmBudgetDollars AS [FilmBudget]
	,YEAR(FilmReleaseDate) AS [Year]
FROM tblfilm
WHERE YEAR(FilmReleaseDate) Between '1980' and '1989'

SELECT *
FROM #TempTable2

--From that Temp table find Box Office+Budget, and Box Office/Budget
SELECT 
	Filmname
	,FORMAT([FilmBoxOffice],'C2') AS [FilmBoxOffice]
	,FORMAT([FilmBudget],'C2')  AS [FilmBudget]
	,CAST(([FilmBoxOffice]/[FilmBudget]) AS VARCHAR(10)) AS [Box Ratio]
	,FilmName + ' had a box office of ' + CAST(FORMAT([FIlmBoxOffice],'C2') AS VARCHAR(20)) + ' on a budget of ' + CAST(FORMAT([FilmBudget],'C2') AS VARCHAR(20)) 
	+ ' and had a Ratio of Box Office/Budget of ' + CAST(([FilmBoxOffice]/[FilmBudget]) AS VARCHAR(10)) AS [Statement]
FROM #TempTable2

--2nd query, correlated subquery return top box office per year
SELECT
	tempo.Filmname
	,FORMAT(tempo.[FilmBoxOffice],'C2') AS [BoxOffice]
	,tempo.[Year]
FROM #TempTable2 AS tempo
WHERE CAST(tempo.[FilmBoxOffice] AS DECIMAL) IN
(
	SELECT
		MAX(tempi.[FilmBoxOffice]) AS [HighestGrossing]
	FROM #TempTable2 tempi
		WHERE tempi.[Year]=tempo.[Year]
	)
ORDER BY
	tempo.[Year]
	,[BoxOffice]

--Bonus try out closing file will delete the temp table( found in system database, temp tables)
DROP TABLE #TempTable, #TempTable2

--Problem 4
*/
--make 3 files a.txt, b.txt, and c.txt
--create a folder "stuff"
--move everything that ends in ".txt" into the directory stuff
--move everything that ends in ".txt" back into the parent directory (up 1 directory)
--rename a.txt to d.txt
--copy stuff to stuff2
--remove stuff
--remove stuff2
--remove all files that end in ".txt"
--use echo and redirection to type "some text" into "text.txt"
--use >> instead of > to append to a file, add the last text "more" to the end of the file

--Notes For TempTable

--Method 1

USE Movies
SELECT
Filmname
,FilmreleaseDate
INTO #TempFiles
FROM tblfilm
Where filmname like '%Star%'

Select * From #Tempfiles

--Method 2

Create Table #TempFilms2
(
	Title Varchar(max)
	,ReleaseDate Datetime
)
INSERT INTO #TempFilms2
SELECT
Filmname
,Filmreleasedate
FROM tblfilm

Select *
From #TempFilms2

--Found in system database, temporary databases, Temporary tables
--temp tables are local to the file you run it in, so it's unique for every "connection" aka file
--Double Hashmarks ## indicate global temporary table
--temp tables delete themselves when the connection closes  close the file'
--You can explicitly delete a temp table Drop table #TempFilms