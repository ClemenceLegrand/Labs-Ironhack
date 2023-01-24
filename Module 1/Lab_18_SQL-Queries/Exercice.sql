CREATE DATABASE IF NOT EXISTS IronDB;
USE IronDB;
CREATE TABLE IF NOT EXISTS Students (
	StudentID int,
	Name varchar(255),
	Surname  varchar(255),
    Course_id int
	);
CREATE TABLE IF NOT EXISTS Teachers(
	TeacherID int,
    Name varchar(255),
    Surname varchar(255)
    );
CREATE TABLE IF NOT EXISTS Courses(
	CourseID int,
    Title varchar(255),
    Form varchar(255),
    TeacherID int
    );

INSERT INTO Courses (CourseID, Title, Form, TeacherID)
VALUES (111, "DA", "Fulltime", 1),
(112, "WEB", "Parttime", 2),
(113, "UIUX", "Fulltime", 3);

UPDATE Courses
SET Form= "Fulltime" WHERE CourseID = 112;

TRUNCATE Courses;
INSERT INTO Courses (CourseID, Title, Form, TeacherID)
VALUES (111, "DA", "Fulltime", 1),
(112, "WEB", "Parttime", 2),
(113, "UIUX", "Fulltime", 3);
INSERT INTO Courses (CourseID, Title, Form, TeacherID)
VALUES (114, "DA", "Fulltime", 1),
(115, "WEB", "Parttime", 2),
(116, "UIUX", "Fulltime", 3);
SELECT Title, Form from courses
where Title="DA";
SELECT Title, TeacherID from courses
where Form="Fulltime";