USE ENSF_608_Project;

-- Users test data 
INSERT INTO USERS (user_ID, username, email, first_name, last_name, user_type) VALUES
(1, 'hamzaitani1', 'hamza.itani@gmail.com', 'Hamza', 'Itani', 'Government User'),
(2, 'sobiakhan2', 'sobia.khan@gmail.com', 'Sobia', 'Khan', 'Teacher User'),
(3, 'ericgodin3', 'eric.godin@gmail.com', 'Eric', 'Godin', 'Government User'),
(4, 'hyunseongjeon4', 'hyunseong.jeon@gmail.com', 'Hyunseong', 'Jeon', 'Teacher User'),
(5, 'changgunyee5', 'changgun.yee@gmail.com', 'Changgun', 'Yee', 'Government User');

-- Users test data 
INSERT INTO GOVERNMENT_USER (government_ID, department, job_title) VALUES
(1, 'Department of Education', 'Assistant'),
(3, 'Department of Finance', 'Assistant'),
(5, 'Department of Education', 'Department Admin');

-- Users test data
INSERT INTO TEACHER_USER (teacher_ID, qualification, hire_date) VALUES
(2, 'Teaching License', '2024-10-15'),
(4, 'Teaching License', '2025-10-15');

INSERT INTO COUNTRY (country_ID, country_name) VALUE
(1, "CANADA");

INSERT INTO LOCALITY (locality_name, country_ID) VALUE
("AB-CAL-DT", 1);

INSERT INTO SCHOOL (school_ID, school_name, education_level) VALUE
(1, "Langevin", "Junior High");

UPDATE SCHOOL SET locality_ID = 1 WHERE school_ID = 1;

INSERT INTO CLASS (class_ID, class_name, subject_name, school_ID, teacher_ID) VALUE
(1, "MATH 9", "MATH", 1, 2);

INSERT INTO STUDENT (student_ID, first_name, last_name, date_of_birth, enrollment_status, disability_status, grade_level, gender) VALUES
(1, "Amy", "Black", '2011-09-04', 1, "", 9, "Female"),
(2, "Madeline", "Hester", '2012-10-09', 1, "Hearing Impaired", 8, "Female");

SELECT * FROM school;

