-- ENSF 608 Group 8: SQL Queries
-- SDG 4: Quality Education
-- Hyunseong Jeon, Changgun Yee, Eric Godin, Hamza Itani, Sobia Khan

USE ensf_608_project;

-- INSERT Operations
INSERT INTO USERS (user_ID, username, password_hash, email, first_name, last_name, user_type) VALUES
(7, 'Taylor_S', 'abcdefg', 'taylor.s@gmail.com', 'Taylor', 'Swift', 'Teacher User');
-- Create a new user called Taylor who can access the web application

INSERT INTO TEACHER_USER (teacher_ID, qualification, hire_date, school_id) VALUES
(7, 'Teaching License', '2020-09-20', 1);
-- Add user Taylor to the teacher_user table so that her school and qualifications can be recorded and she can access
-- and update student records.


-- UPDATE Operations
UPDATE GUARDIAN_PHONE
SET phone_number = '15872221111'
WHERE student_Id = 3 AND phone_number = '15871112222';
-- Replace an old phone number for student named Max with updated guardian contact phone number

UPDATE TEACHER_USER
SET qualification = "Masters in Education"
WHERE teacher_ID = 2;
-- Update teacher qulaifications when teacher updates their qualifications

-- DELETE Operations

UPDATE GOALS
SET government_ID = 3
WHERE government_ID = 1;

DELETE FROM government_user
WHERE government_ID = 1;
-- Delete government user when they no longer work for the government, update all foreign key constraints before deleting (assign goals to a different government worker)

DELETE FROM CLASS
WHERE class_id = 3 and school_id = 2;
-- Remove a class when it is no longer offered at the school


-- Basic SELECT Queries  using filtering conditions (WHERE, LIKE, IN, BETWEEN, AND, OR, etc.) - 4
SELECT CLASS.*
FROM CLASS
WHERE CLASS.teacher_ID = 2;
-- USE CASE: Teacher viewing list of classes they are teaching for the year
-- Get all classes a specific teacher (Sobia) teaches

SELECT LITERACY.*
FROM LITERACY
WHERE LITERACY.score <= 50
AND LITERACY.class_id = 2;
-- View literacy scores in a specific range for a specific 
-- USE CASE: Figure out which students failed - need more help, need to reattempt the exam

SELECT GOALS.*
FROM GOALS
WHERE GOALS.goal_status IN ("In Progress", "Pending");
-- 5.	What are the goals that are being worked on and their current progress?

SELECT REMINDERS.*
FROM REMINDERS
WHERE REMINDERS.school_id = 1;
-- View reminders for action items for the whole school

SELECT qualification, teacher_ID 
FROM TEACHER_USER 
WHERE qualification LIKE 'Master%'; 
-- Views all teachers with a Master’s degree, in any field.

-- SELECT queries using ORDER BY, DISTINCT, or LIMIT - 2

SELECT c.country_name, sc.school_ID, sc.school_name, f.currency, SUM(f.amount) AS total_funding FROM FUNDING f
JOIN SCHOOL sc
    ON f.school_ID = sc.school_ID
JOIN LOCALITY l
    ON sc.locality_ID = l.locality_ID
JOIN COUNTRY c
    ON l.country_ID = c.country_ID
WHERE c.country_name = 'CANADA'
GROUP BY
    c.country_name,
    sc.school_ID,
    sc.school_name,
    f.currency    
ORDER BY total_funding DESC;
-- List schools based on the amount of funding received in the selected country.

SELECT FUNDING_SOURCE.source_name, FUNDING_SOURCE.source_sector, FUNDING.*
FROM FUNDING
INNER JOIN FUNDING_SOURCE ON
FUNDING.source_id = FUNDING_SOURCE.source_id
WHERE FUNDING.school_id IS NULL
ORDER BY FUNDING.amount DESC;
-- Find all funding that hasn't already been awarded and list it by the total amount offered
-- USE CASE: Apply for funding that will have the largest impact


-- SELECT queries using aggregate functions (COUNT, SUM, AVG, MIN, MAX) - 3
SELECT ATTENDANCE.student_id, CONCAT(STUDENT.first_name, " ", STUDENT.last_name) AS Student_Name, COUNT(ATTENDANCE.attendance) AS Num_Absences
FROM ATTENDANCE
INNER JOIN STUDENT ON 
ATTENDANCE.student_ID = STUDENT.student_ID
INNER JOIN SESSION ON
ATTENDANCE.session_ID = SESSION.session_ID
WHERE SESSION.session_date > '2026-08-30'
AND ATTENDANCE.attendance = 'absent'
GROUP BY ATTENDANCE.student_ID;
-- Get the number of times each student absent from the start of the school year in a specific school
-- USE CASE: Calculate attendance and if some student are missing too much school

SELECT COUNT(AWARDS.award_id) AS Num_Awards, SCHOOL.school_name
FROM AWARDS 
INNER JOIN SCHOOL ON 
AWARDS.school_id = SCHOOL.school_id
GROUP BY SCHOOL.school_name
ORDER BY Num_Awards DESC;
-- Find the number of awards awarded to each school

SELECT s.school_name, f.currency, AVG(f.amount) AS total_amount 
FROM FUNDING f 
JOIN SCHOOL s 
    ON f.school_ID = s.school_ID
    GROUP BY s.school_name, f.currency;
--  Calculate the avg funding each school receives

SELECT s.first_name, s.last_name, ca.score
FROM COMPETENCY ca 
JOIN STUDENT s 
    ON ca.student_id = s.student_id
WHERE ca.competency_id = 1
AND ca.score = (SELECT MAX(ca.score) FROM COMPETENCY ca WHERE ca.competency_id = 1);
-- Get the students that performed best on a specific assessment 


-- SELECT queries using GROUP BY, including at least one with HAVING - 2
SELECT AVG(LITERACY.score) AS score, school.school_name
FROM LITERACY
LEFT JOIN CLASS ON
literacy.class_id = class.class_id
INNER JOIN SCHOOL ON 
class.school_id = school.school_id
INNER JOIN lOCALITY ON
school.locality_id = locality.locality_id
WHERE locality.country_id = 1 
GROUP BY school.school_name
ORDER BY score;
-- 2.	Which schools have the lowest average literacy scores in a country?

SELECT class_id, COUNT(student_id) AS Num_Students
FROM CLASS_STUDENT_TAKES
WHERE class_student_takes.joined_on >= '2026-08-31'
GROUP BY class_id
HAVING Num_Students < 5;
-- Find the classes that have less than 5 students enrolled in them for the current school year
-- These schools may need additional resources to promote education and help enrolling students 


-- SELECT queries using INNER JOIN - 3
SELECT ATTENDANCE.student_id, CONCAT(STUDENT.first_name, " ", STUDENT.last_name) AS Student_Name, ATTENDANCE.absence_reason
FROM ATTENDANCE
INNER JOIN STUDENT ON 
ATTENDANCE.student_ID = STUDENT.student_ID
INNER JOIN SESSION ON
ATTENDANCE.session_ID = SESSION.session_ID
WHERE SESSION.session_date = '2025-09-02'
AND ATTENDANCE.attendance = 'absent';
-- Get students that were absent on a specific date
-- USE CASE: Contacting parents of students who are absent often

SELECT DISTINCT STUDENT.*, LOCALITY.locality_name, COUNTRY.country_name
FROM STUDENT
LEFT JOIN class_student_takes ON 
student.student_ID = class_student_takes.student_ID
INNER JOIN CLASS ON
class_student_takes.class_id = CLASS.class_ID
INNER JOIN SCHOOL ON 
CLASS.school_ID = SCHOOL.school_ID
INNER JOIN LOCALITY ON 
SCHOOL.locality_ID = LOCALITY.locality_ID
INNER JOIN COUNTRY ON 
LOCALITY.country_ID = COUNTRY.country_ID;
-- Get Locality and country of each student

SELECT CLASS.class_name, CONCAT(STUDENT.first_name, ' ', STUDENT.last_name) AS student_name, GUARDIAN_PHONE.phone_number
FROM CLASS 
INNER JOIN CLASS_STUDENT_TAKES ON 
CLASS.class_ID = CLASS_STUDENT_TAKES.class_ID 
INNER JOIN STUDENT ON 
CLASS_STUDENT_TAKES.student_ID = STUDENT.student_ID 
INNER JOIN GUARDIAN_PHONE ON 
STUDENT.student_ID = GUARDIAN_PHONE.student_ID 
WHERE CLASS.teacher_ID = 2 AND CLASS.academic_year = 2026 AND CLASS_STUDENT_TAKES.left_on IS NULL 
ORDER BY CLASS.class_name, student_name;
-- Get guardian phone numbers of the students in a specific teacher’s classes for the current school year 

-- SELECT queries using LEFT JOIN or RIGHT JOIN - 2
SELECT COUNTRY.country_name, COUNTRY_STATISTICS.statistics_year, COUNTRY_STATISTICS.adult_literacy_rate
FROM COUNTRY
LEFT JOIN country_statistics ON
COUNTRY_STATISTICS.country_id = COUNTRY.country_ID;
-- Literacy rate for a country - include countries without statistics because this is important info on if these countries
-- need more resources from the UN 

SELECT CONCAT(STUDENT.first_name, ' ', STUDENT.last_name) AS "Student Name", ACTIONITEM.item_description AS "Action items", ACTIONITEM.item_status AS "Action item status" 
FROM ACTIONITEM 
RIGHT JOIN STUDENT ON  
STUDENT.student_id = ACTIONITEM.student_id 
WHERE STUDENT.enrollment_status = TRUE AND STUDENT.disability_status != ''; 
-- Find all students with disabilities who have actions items

-- SELECT queries combining JOINs, aggregate functions, filtering, or grouping - 1
SELECT AVG(LITERACY.score), school.locality_id, LITERACY_ASSESSMENT.assessment_code
FROM LITERACY
INNER JOIN literacy_assessment ON 
LITERACY.assessment_code = LITERACY_ASSESSMENT.assessment_code
INNER JOIN CLASS ON
LITERACY.class_id = class.class_id
INNER JOIN SCHOOL ON 
class.school_id = school.school_id
INNER JOIN locality ON 
school.locality_id = locality.locality_id
WHERE LITERACY.score IN (SELECT MAX(LITERACY.score)
                        FROM LITERACY
                        GROUP BY LITERACY.student_ID)  
AND LOCALITY.country_id = 1
GROUP BY SCHOOL.locality_id, LITERACY_ASSESSMENT.assessment_code;
-- USE CASE: What is the literacy rate for a particular area?
-- Literacy rate among kids in a specific grade in every locality in a country using only their best score


-- Stored procedures, including at least one with an input parameter
DROP PROCEDURE IF EXISTS InsertUser;

DELIMITER //
CREATE PROCEDURE InsertUser(
    IN username            varchar(30),
    IN password_hash       VARCHAR(64), 
    IN email               varchar(255),
    IN first_name          varchar(100),
    IN last_name           varchar(100),
    IN user_type           ENUM('Government User', 'Teacher User', 'Admin')
)
BEGIN
    INSERT INTO USERS (username, password_hash, email, first_name, last_name, user_type) VALUES
    (username, password_hash, email, first_name, last_name, user_type);
END //
DELIMITER ;

CALL InsertUser('Jack_Black', '123456', 'jack@gmail.com', 'Jack', 'Black', 'Teacher User');
-- Stored procedure to create new user

DROP PROCEDURE IF EXISTS GetUserID;

DELIMITER //
CREATE PROCEDURE GetUserID(
    IN email varchar(255),
    OUT userID INT
)
BEGIN
    SELECT USERS.user_ID INTO userID
    FROM USERS
    WHERE USERS.email = email;
END //
DELIMITER ;

CALL GetUserID('jack@gmail.com', @t);
SELECT @t;

-- Stored procedure to retrieve user id based on email
-- User ID is needed to create references in other tables and is not something that would be known before insertion
-- Its value should also not be controlled through the front-end to prevent primary key errors or overwrites. 

