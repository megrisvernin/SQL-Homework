CREATE TABLE [Course] (
  [CourseID] Int,
  [Coursename] varchar(30),
  [CourseCredits] Int,
  PRIMARY KEY ([CourseID])
);

CREATE TABLE [Major] (
  [MajorID] Int,
  [Name] varchar(30),
  [CreditsToGrad] Int,
  PRIMARY KEY ([MajorID])
);

CREATE TABLE [Student] (
  [StudentID] Int,
  [MajorID] Int,
  [FirstName] varchar(30),
  [LastName] varchar(30),
  [Age] Int,
  [HasFinancialAid] Bit,
  [Email] varchar(30),
  PRIMARY KEY ([StudentID])
);

CREATE TABLE [Enrollment] (
  [ScheduledClassID] Int,
  [StudentID] Int Not NULL,
  [CourseID] Int Not Null,
  [SemesteriD] Int Not NULL,
  [ClassLocationID] Int,
  [DateEnrolled] Date Default getDATE(),
  [GradePoint] Int,
  PRIMARY KEY ([ScheduledClassID])
);

CREATE TABLE [Semester] (
  [SemesterID] Int,
  [Name] varchar(30),
  [StartDate] Date,
  [EndDate] Date,
  PRIMARY KEY ([SemesterID])
);

CREATE TABLE [ClassLocation] (
  [ClassLocationID] Int,
  [Address] varchar(100),
  [RoomNumber] Int,
  [DaysoftheWeek] varchar(7),
  [Startime] Time,
  [DurationTimes] Int,
  [StudentCapacity] Int ,
  PRIMARY KEY ([ClassLocationID])
);


Drop table ClassLocation,Semester,Enrollment,Student,Major,Course

---Homework 9
---Use Update statement to add constraints, add relevaqnts from before and any new ones that seem relevant, 
---add foreign keys according to diagram
---Andrew do Enrollment and Course
--Thomas Fill out ClassLocation and Semmester
--Both do Major and Student, format values to match new table
--Homework

--Return Filname, FilmeRunTime

--WHERE SUBQUERY Returns

--Run Time between 90 and 120 Minutes
--
--WHat films were released in the same year as King Kong, use a subquery to do this
--Note to self King Kong is 3 movies so you want to do filename Like 'King Kong'
--Use = and In on subquery
--
--Do the same but filmname Serenity
---Use = and In on subquery

--Homework 10
--Examples of
-- subquery returning a set of values
-- subquery returning a single value










And we can both do Major and Student