USE ENSF_608_Project;

-- Users test data 
INSERT INTO USERS (user_ID, username, email, first_name, last_name, user_type) VALUES
(1, 'hamzaitani1', 'hamza.itani@gmail.com', 'Hamza', 'Itani', 'Government User'),
(2, 'sobiakhan2', 'sobia.khan@gmail.com', 'Sobia', 'Khan', 'Teacher User'),
(3, 'ericgodin3', 'eric.godin@gmail.com', 'Eric', 'Godin', 'Government User'),
(4, 'hyunseongjeon4', 'hyunseong.jeon@gmail.com', 'Hyunseong', 'Jeon', 'Teacher User'),
(5, 'changgunyee5', 'changgun.yee@gmail.com', 'Changgun', 'Yee', 'Government User');

-- Users test data 
INSERT INTO GOVERNMENT_USER (user_ID, department, job_title) VALUES
(1, 'Department of Education', 'Assistant'),
(3, 'Department of Finance', 'Assistant'),
(5, 'Department of Education', 'Department Admin');

-- Users test data
INSERT INTO TEACHER_USER (user_ID, qualification, hire_date) VALUES
(2, 'Teaching License', '2024-10-15'),
(4, 'Teaching License', '2025-10-15');