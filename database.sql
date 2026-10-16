DROP DATABASE IF EXISTS TEMPNAME;
-- TEMPNAME is just the placeholder name for the database 
CREATE DATABASE TEMPNAME;
USE TEMPNAME;


-- USERS
CREATE TABLE USERS (
    user_ID         int not null AUTO_INCREMENT,
    username        varchar(20),
    -- password_hash  (not sure about the type)
    email           varchar(50),
    first_name      varchar(20),
    last_name       varchar(20),
    user_type       ENUM('Government User', 'Teacher User'),
    PRIMARY KEY (user_ID)
);

-- Users test data 
INSERT INTO USERS (user_ID, username, email, first_name, last_name, user_type) VALUES
(1, 'hamzaitani1', 'hamza.itani@gmail.com', 'Hamza', 'Itani', 'Government User'),
(2, 'sobiakhan2', 'sobia.khan@gmail.com', 'Sobia', 'Khan', 'Teacher User'),
(3, 'ericgodin3', 'eric.godin@gmail.com', 'Eric', 'Godin', 'Government User'),
(4, 'hyunseongjeon4', 'hyunseong.jeon@gmail.com', 'Hyunseong', 'Jeon', 'Teacher User'),
(5, 'changgunyee5', 'changgun.yee@gmail.com', 'Changgun', 'Yee', 'Government User');

-- GOVERNMENT USERS
CREATE TABLE GOVERNMENTUSERS (
    user_ID         int,
    department      varchar(30),
    job_title       varchar(30),
    FOREIGN KEY (user_ID) REFERENCES users(user_ID)
);

-- Users test data 
INSERT INTO GOVERNMENTUSERS (user_ID, department, job_title) VALUES
(1, 'Department of Education', 'Assistant'),
(3, 'Department of Finance', 'Assistant'),
(5, 'Department of Education', 'Department Admin');

-- TEACHER USERS
CREATE TABLE TEACHERUSERS (
    user_ID         int,
    qualification   varchar(30),
    hire_date       date,
    FOREIGN KEY (user_ID) REFERENCES users(user_ID)
);

-- Users test data
INSERT INTO TEACHERUSERS (user_ID, qualification, hire_date) VALUES
(2, 'Teaching License', '2024-10-15'),
(4, 'Teaching License', '2025-10-15');

-- SCHOOL


-- STUDENT


-- CLASS


-- LOCALITY 


-- FUNDING


-- AWARDS


-- GOALS


-- REMINDER


-- COUNTRY


-- COMPETENCY


-- FACILITIES


-- SESSION


-- LITERACY


-- ACTION ITEM




DROP USER IF EXISTS 'user'@'localhost';

CREATE USER 'user'@'localhost' IDENTIFIED BY  'password';

GRANT ALL PRIVILEGES ON TEMPNAME.* TO 'user'@'localhost' WITH GRANT OPTION;

GRANT CREATE USER, RELOAD ON *.* TO 'user'@'localhost';

FLUSH PRIVILEGES;