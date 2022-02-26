--Problem Description:

--In the design for the Fresher Training Management, given the Trainee table with below initial attributes fields:

--TraineeID:  trainee identifier, auto-increment field

--Full_Name: full name of the trainee

--Birth_Date: trainee birth date

--Gender:  only have one of two value male, female

--ET_IQ: entry test point (IQ) of trainee, integer, value range from 0 to 20

--ET_Gmath: entry test point (GMath) of trainee, integer, value range from 0 to 20

--ET_English: entry test point (English) of trainee, integer, value range from 0 to 50

--Training_Class: the class code that trainee  is joining

--Evaluation_Notes:  trainee evaluation notes, free text.

--Q1. Create the tables (with the most appropriate/economic field/column constraints & types) 
--and add at least 10 records into each created table.
CREATE TABLE Trainee(
	TraineeID INT IDENTITY,
	Full_Name VARCHAR(50),
	Birth_Date DATE,
	Gender BIT,
	ET_IQ INT,
	ET_Gmath INT,
	ET_English INT,
	Training_Class INT,
	Evaluation_Notes VARCHAR(255)
);

ALTER TABLE Trainee
ADD CONSTRAINT CHECK_ET_IQ CHECK(ET_IQ BETWEEN 0 AND 20);

ALTER TABLE Trainee
ADD CONSTRAINT CHECK_ET_Gmath CHECK(ET_Gmath BETWEEN 0 AND 20);

ALTER TABLE Trainee
ADD CONSTRAINT CHECK_ET_English CHECK(ET_English BETWEEN 0 AND 50);

INSERT INTO Trainee
VALUES
	('Cuong','03/03/1998',1,15,12,40,112,'try hard'),
	('Tu','03/03/1997',1,15,18,40,112,'try hard'),
	('Thien','03/03/1995',1,2,12,40,112,'try hard'),
	('Nam','03/03/1994',1,6,12,40,112,'try hard'),
	('Chien','03/03/1999',0,7,19,50,112,'try hard'),
	('Dieu','03/03/2000',1,8,1,30,112,'try hard'),
	('Dat','03/03/2001',0,16,10,20,112,'try hard'),
	('Huy','03/03/2002',1,20,19,10,112,'try hard'),
	('Viet','03/03/1993',0,19,5,8,112,'try hard'),
	('Duc','03/03/2006',1,15,2,50,112,'try hard');
GO

--Q2. Change the table TRAINEE to add one more field named Fsoft_Account which is a not-null & unique field.
ALTER TABLE Trainee
ADD Fsoft_Account VARCHAR(30) NOT NULL UNIQUE;
GO

--Q3. Create a VIEW that includes all the ET-passed trainees. One trainee is considered as ET-passed when he/she 
--has the entry test points satisfied below criteria:
--ET_IQ + ET_Gmath >=20
--ET_IQ>=8
--ET_Gmath>=8
--ET_English>=18​
CREATE VIEW Trainee_Passed
AS
SELECT TraineeID,Full_Name,Birth_Date
FROM Trainee
WHERE ET_IQ +ET_Gmath >= 20 
AND ET_IQ >= 8 AND ET_Gmath >=8 AND ET_English >= 18;
GO

--Q4. Query all the trainees who are passed the entry test, group them into different birth months.
SELECT * FROM Trainee_Passed
ORDER BY MONTH(Birth_Date) ASC;
GO

--Q5. Query the trainee who has the longest name, showing his/her age along with his/her basic information (as defined in the table).
SELECT TraineeID,Full_Name,
YEAR(GETDATE()) - YEAR(Birth_Date) AS Age
FROM Trainee 
WHERE LEN(Full_Name) = (SELECT MAX(LEN(Full_Name)) FROM Trainee);
GO