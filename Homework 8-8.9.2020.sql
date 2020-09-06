Use Movies
Select
*
From tblFilm
WHere
FILMNAME='Serenity'

--Homework 8

--Topics
--ER diagrams

--Question 1: In ER Diagram
--Add all columns
--Appropriate labeling for Datatype
--Complete

--Question 2-Solve the many to many issue for Student to Course tables

--Question 3-Are you able to change a valid WHERE clause to HAVING nomatter what?
/*Found a good answer here:
http://www.geekinterview.com/question_details/87837
Highlights
Well every time you could use having this way, you need to use group by and this adds labor. Example:
--If you want to use a select * statement and decide to use having instead of where, you need a group by with the name of every column in the table
--They gave an example of it not working if the table names have not been normalized with no PK and columns containing repeating data as not working
--Overall
-->So, the answer to the interviewer would be, "Yes, for some limited select queries it would be possible
to replace the WHERE clause with a GROUP BY / HAVING clause, however doing so would not be a BEST PRACTICE to follow."


--Homework for later
--For future project make database as elaborate as it could be:
--> Student table columns under Attempt Hours and Passed Hours
--> Major table add graduation credits column
--> Student add a column for Semmester 
---> Each class has a credit hour
--> Able to:
---> One student many classes
---> Be able to retake classes (Be careful on ideas, play into attempted hours update it if you've previously failed it)
---> give a grade to each class
---> Calculate GPA for a student (CASE Field)
---> Add comment fields for any constraintsa
---> Create a database for data we create

--Question 4--Reassign SQL key to something else