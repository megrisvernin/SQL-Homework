--Homework 5

USE Movies
--Question 1:
--Find Box Office Revenue by Country, Including Rollup on Country & Count of Number of Films
SELECT 
ISNULL(c.CountryName,'TOTAL') as 'CountryName'
,sum(CAST(f.FilmBoxOfficeDollars AS BIGINT)) as [Office Revenue]
,Count(*) as Films
From Tblfilm AS f
Inner join tblCountry AS c
ON f.FilmCountryID=c.CountryID
GROUP BY
	c.CountryName WITH ROLLUP

--Question 2:
--IGNORING Examples where Oscar Nominations is Zero Use Aggregates only to return Minimum,Maximum, Average and Count of Films that have nominated for Oscars

SELECT 
	MIN(FilmOscarNominations) as [Min Oscars]
	,AVG(FilmOscarNominations) AS [Avg. Oscars]
	,MAX(FilmOscarNominations) AS [Max Oscars]
	,Count(*) AS [Films Nominated for Oscars]
FROM TBlfilm
WHERE
	FilmOscarNominations != 0

--Question 3:
--Group by directors and movies and show average budget and average box office(Convert Decimal), also include Rollup on both and rename Rollup 
--With Rollup
SELECT
	ISNULL(d.DirectorName,'TOTAL') AS [DirectorsName]
	,ISNULL(f.FilmName,'TOTAL') AS [FilmName]
	,FORMAT(AVG(CAST(f.FilmBudgetDollars AS Decimal)),'C2') AS [Average Budget] 
	,FORMAT(AVG(CAST(f.FilmBoxOfficeDollars AS Decimal)),'C2') AS [Average Box Office] 
--	,AVG(CONVERT(DECIMAL,CAST(f.FilmBudgetDollars as BIGINT))) as [Average Budget Office] The Hard way to do this
--	,AVG(CONVERT(DECIMAL,CAST(f.FilmBoxOfficeDollars as BIGINT))) as [Average Box Office] The Hard way to do this
--	,AVG(CAST(f.FilmBudgetDollars as BIGINT)) AS [Average Film Budget]
FROM
	tblFilm AS f
	INNER JOIN tblDirector AS D
		ON f.FilmDirectorID=d.DirectorID
WHERE 
	f.FilmBudgetDollars IS NOT NULL AND
	f.FilmBoxOfficeDollars IS NOT NULL
GROUP BY  
	ROLLUP (d.DirectorName,f.FilmName)
ORDER BY  [Average Budget]

--Question 4:
--Avg of Box Office Revenue, AND Box Office Budget  using ISNULL Statement replace Null with 0  Run same statement as above without ISNULL to see them side by side.
SELECT
	FORMAT(AVG(CAST(FilmBudgetDollars as decimal)),'C2') AS [Average Budget Dec]
	,FORMAT(AVG(CAST(FilmBoxOfficeDollars as decimal)),'C2') AS [Average Box Office Dec]
FROM
	tblFilm

SELECT
	FORMAT(AVG(CAST(ISNULL(FilmBudgetDollars,0) AS DECIMAL)),'C2') AS [Average Budget Office]
	,FORMAT(AVG(CAST(ISNULL(FilmBoxOfficeDollars,0) AS DECIMAL)),'C2') AS [Average Box Office]
	--,FORMAT(ISNULL(AVG(CAST(FilmBudgetDollars as decimal)),0),'C2') as [Average Budget Office] --Order of Operations issue you want to include ISNULL changes WITHIN Agregators like Avg not Outside
	--,FORMAT(ISNULL(AVG(CAST(FilmBoxOfficeDollars as decimal)),0),'C2') as [Average Box Office] 
FROM
	tblFilm

--Question 5:
--List Directors that make an average of less than 5 million per movie
--Calculated by Revenue
SELECT 
	d.DirectorName
	,AVG(CAST(f.FilmBoxOfficeDollars AS BIGINT)) as [Average Revenue]
	,Count(*)
	FROM tblfilm as f
	INNER JOIN tblDirector as d
		ON f.FilmDirectorID=d.DirectorID
GROUP BY
	d.DIrectorName
HAVING AVG(CAST(f.FilmBoxOfficeDollars AS BIGINT))<=5000000

--Calculated by Profitability
SELECT 
	d.DirectorID
	,AVG(CAST(f.FilmBoxOfficeDollars-F.FilmBudgetDollars AS DECIMAL)) AS [Movie Profit]
	,Count(*)
	--,AVG(CAST(f.FilmBoxOfficeDollars AS BIGINT)) as [Average Revenue]
	FROM tblfilm as f
	INNER JOIN tblDirector as d
		ON f.FilmDirectorID=d.DirectorID
GROUP BY
	d.DIrectorID
HAVING AVG(CAST(f.FilmBoxOfficeDollars-F.FilmBudgetDollars AS DECIMAL))<=5000000
ORDER By [Movie Profit] desc;

--Question 6:
--Develop a scenario involving Teachers, students that will need have 3 tables, joined on foreign key in the table examples show at least one use of
--Name of Table_
--Table 1-Exam Grades should have Numerical Grade StudentNumber
--Table 2 is Student Major Primary key is Major_Student_ID
--Primary key STUDENT ID Number
--Table 3-Student
--Must have at least 1 example of Constraints of NOT NULL, UNIQUE, CHECK
--Example of Check
--What might be the advantages of rolling the Major table into Student Information

USE Movies

Create table Major(
	Majorid INT Primary Key Identity(1,1)
	,Majorname VARCHAR(50) not null unique DEFAULT 1)

Create table Student(
	Studentid INT Primary Key Identity(1,1)
	,StudentFirstName VARCHAR(40) not null
	,StudentLastName VARCHAR(40) not null
	,StutdentStart Datetime not null
	,StudentEnd Datetime default null
	,StudentEmail varchar(40) not null unique 
	,Studentfinancialaidid  bit default 0 not null
	,StudentMajorId int Foreign Key References Major(Majorid)
	,StudentAge int constraint StudentMustNotBEZERO
	CHECK (StudentAge>0),
	constraint ENDDATECOMESAFTERSTARTDATE check(StutdentStart < StudentEnd),
	Constraint HAVEATSYMBOLANDDOT Check (StudentEmail like '%@%.%')
	)
Create table Exam(
	Examid INT Primary Key Identity(1,1)
	,ExamGrade Int not null default 0 constraint GRADEMUSTBEBETWEEN0AND100
	CHECK  (ExamGrade>=0 AND Examgrade<=100)
	,ExamStudentid int Foreign Key References Student(studentID)
	)
INSERT INTO major(Majorname) VALUES ('English')
INSERT INTO major(Majorname) VALUES ('Pre-Med')
INSERT INTO major(Majorname) VALUES ('Economics')
INSERT INTO major(Majorname) VALUES ('Engineering')
INSERT INTO major(Majorname) VALUES ('Art')
INSERT INTO major(Majorname) VALUES ('Philosophy')
INSERT INTO major(Majorname) VALUES ('Physical Therapy')
INSERT INTO major(Majorname) VALUES ('History')
INSERT INTO major(Majorname) VALUES ('Math')
INSERT INTO major(Majorname) VALUES ('Psychology')
	
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Mary','Lincoln',1,16,'Mlincoln@gmail.com')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Jack','Thompson',2,18,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Louise','Valliere',3,20,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Mike','Tyson',4,21,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Larry', 'Tillson',5,19,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Jeanne','Darc',6,20,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Alexander','Great',7,18,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Becky','Vons',8,18,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Melissa','Ferrian',9,18,'')
INSERT INTO student(StudentFirstName,StudentLastName, StudentMajorId,Studentage,StudentEmail) VALUES ('Taylor','Hebert',10,17,'')

--UPDATE student
--SET Studentfinancialaidid =1
--WHERE Studentid IN ('6','7','9')

INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (100,1)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (86,2)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (93,3)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (81,4)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (76,5)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (60,6)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (82,7)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (93,8)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (94,9)
INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (71,10)
--INSERT INTO Exam(ExamGrade,ExamStudentid) VALUES (72,11) I had a foreign key catch this as an error actually

SELECT 
s.Studentid
,s.StudentFirstName
,s.StudentLastName
,f.financialaidstatus
,s.StudentAge
,m.majorname
,e.Examid
,e.ExamGrade
,CASE
	WHEN e.ExamGrade<60 THEN 'F'
	WHEN e.ExamGrade<70 THEN 'D'
	WHEN e.ExamGrade<80 THEN 'C'
	WHEN e.ExamGrade<90 THEN 'B'
	ELSE 'A'
END AS [LetterGrade]
FROM Student AS s
INNER JOIN major AS m
ON StudentMajorId=m.Majorid
INNER JOIN Exam AS e
On s.Studentid=e.ExamStudentid
INNER JOIN FinancialAid f
ON s.Studentfinancialaidid =f.financialaidid
GROUP BY
s.Studentid
,s.StudentFirstName
,s.StudentLastName
,f.financialaidstatus
,s.StudentAge
,m.majorname
,e.Examid
,e.ExamGrade
ORDER BY e.ExamGrade DESC;

Drop table exam,Student,major,FinancialAid