--Homework 10

--Problem 1-Subquery-Movies that have more than double the average budget join to list director

USE MOVIES
SELECT 
	f.filmname
	,d.DirectorName
	,FORMAT(f.FilmBudgetDollars,'C2') AS [FilmBudget]
FROM tblFilm AS f
INNER JOIN tblDirector AS d
	ON f.FilmDirectorID=d.DirectorID
WHERE 
	FilmBudgetDollars>
	2*(	
		SELECT
			AVG(CAST(FilmBudgetDollars AS DECIMAL))
		FROM
			tblFilm
			)
ORDER BY
	f.FilmBudgetDollars
	,FilmName

Select *
FROM tblFIlm

--Problem 2-Directors who have fewer numbers of films than the average Director
SELECT
	d.DirectorName
	,COUNT(f.FilmID) AS [NumFilms]
FROM
	tblDirector AS d
FULL OUTER JOIN tblfilm AS f 
		ON d.DirectorID=f.FilmDirectorID
GROUP BY 
	d.DirectorName
HAVING COUNT(f.FilmID)<
		(
		SELECT
			CAST(COUNT(f.filmid) AS DECIMAL)/COUNT(DISTINCT d.DirectorID)
		FROM
			tblDirector AS d FULL 
		OUTER JOIN tblfilm AS f 
				ON d.DirectorID=f.FilmDirectorID
				)

--Problem 3-What is the maximum and minimum number of oscar wins (inner query question)
--Subquery What movies share that respective distinction (subquery)
--Max Oscar Wins
SELECT
	FilmName
	,FilmOscarWins
FROM
	tblFilm
WHERE 
	FilmOscarWins =
		(
		SELECT
			MAX(FilmOscarWins)
		FROM 
			tblFilm
		)

--Min
SELECT
	FilmName
	,FilmOscarWins
FROM
	tblFilm
WHERE 
	FilmOscarWins =
		(SELECT
			MIN(FilmOscarWins)
		FROM
			tblFilm)

--Problem 4-List the films which are either the maximum/min for oscarwins Draw on Problem 3 using OR to solve
SELECT
	FilmName
	,FilmOscarWins
FROM
	tblFilm
WHERE 
	FilmOscarWins IN
		(SELECT
			MAX(FilmOscarWins)
		FROM 
			tblFilm)
OR FilmOscarWins IN
		(SELECT
			MIN(FilmOscarWins)
		FROM
			tblFilm)
ORDER BY
	FilmOscarWins DESC,
	FilmName

--Problem 5-Return the longest movie runtime by director(same as wise owl video substitute country for director) using correlated subqueries
SELECT
	d.DirectorName
	,f.Filmname
	,f.FilmRunTimeMinutes
FROM
	TblFilm AS f 
INNER JOIN	tblDirector AS d 
		ON d.DirectorID=f.FilmDirectorID
WHERE
	f.FilmRunTimeMinutes =
		(SELECT
			MAX(FilmRunTimeMinutes)
		FROM 
			tblFilm AS g
		WHERE 
			g.FilmDirectorID=f.FilmDirectorID)
ORDER BY 
d.DirectorName
,f.FilmName
--Problem 6-Return the maximum Oscar Wins By director use correlated subqueries
SELECT
	do.DirectorName
	,do.DirectorID
	,fo.Filmname
	,fo.FilmOscarWins
FROM
	TblFilm AS fo 
INNER JOIN tblDirector AS do
		ON do.DirectorID=fo.FilmDirectorID
WHERE
	fo.FilmOscarWins =
		(
		SELECT
			MAX(FilmOscarWins)
		FROM 
			tblFilm AS fi
		WHERE fi.FilmDirectorID=15
			--fi.FilmDirectorID=fo.FilmDirectorID
		)
ORDER By
	fo.FilmOscarWins DESC
	,do.Directorname
	

--Problem Bonus--Difference between a regular subquery and correlated subquery
--->Interview answer

--The main difference between a regular, non-correlated and correlated subquery in SQL is in their working,
--a regular subquery just run once and return a value or a set of values which is used by outer query,
--but correlated subquery runs for each row returned by the outer query because the output of the whole query is
--based upon comparing the data returned by one row to the all other rows of the table. That's why it is also very 
--slow and generally avoided until you don't know any other way to solve the problem.
-- Alternatively A non-correlated subquery is executed only once and its result can be swapped back for a query, on the other hand, a correlated subquery executed multiple times, precisely once for each row returned by the outer query.

--Read more: https://www.java67.com/2017/06/difference-between-correlated-and-non-correlated-subquery-in-sql.html#ixzz6VVeyZZAP
--A correlated subquery depends upon the outer query and cannot execute in isolation, but a regular or non-correlated subquery 
--doesn't depend on the outer query and can execute in isolation. A non-correlated subquery is executed only once and its result
--can be swapped back for a query, on the other hand, a correlated subquery executed multiple times, precisely once for each row returned by the outer query.

-- A correlated subquery is much slower than the non-correlated subquery because in former, 
--the inner query executes for each row of the outer query. This means if your table has n rows then
--whole processing will take the n * n = n^2 time, as compared to 2n times taken by a non-correlated subquery.

---> Best answer--> Coorelated subquery each query references the other query whereas for standard simple query outer query references the inner query but not vice versa

--Thursday

--Check on HR on resume suggestions
--Check other gmail
--LinkedIn

--Shared Interest, project we could do at the same time. Something he's interested in we could take part in, remote way. Carpentry, Language learning, research on a topic. Way to stay connected.

--Reach out to Him

--Add a constraint that Start Date must be before End Date for Semester
--2 days a week 90 minutes
--1 Day 3 hours
---5 days 1 hour or 50 min

--Integrate Andrew's Data

--Add a Change to Course so that Coursename and CourseCredits don't list course
--Find replace on coding

--Think about this:
--ClassLocation cannot be taken by two courses during the same semester
--Some semmesters overlap
--Think of ways to resolve this
-- semester chunks
-- semesterToChunks bridge table that identifies many to many relationship of Semester to SemesterChunk
-- spring2019 = spring1, spring2
-- springTenWeek1 = spring1
-- springTenWeek2 = spring2


--Constraints are buildingNum, room Number, and then unsure on best way to represent time block

--Possible Answer, unsatisfying, is to make new table that breaks semmesters into diferent schedule blocks/chunks and be able to start classes on different chunks. And you would set it up so that the default is always generic semmester start/end date for default traunch
--This is a table for exceptions

-- spring1, spring2, summer1, summer2, summer3, fall1, fall2
-- normal spring semester is spring1 and spring2 chunks

-- semester chunks
-- semesterToChunks bridge table that identifies many to many relationship of Semester to SemesterChunk
-- spring2019 = spring1, spring2
-- springTenWeek1 = spring1
-- springTenWeek2 = spring2

--Add a query to tell if they overlap
