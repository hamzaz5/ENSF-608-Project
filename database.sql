DROP DATABASE IF EXISTS TEMPNAME;
-- TEMPNAME is just the placeholder name for the database 
CREATE DATABASE TEMPNAME;
USE TEMPNAME;


-- USERS
CREATE TABLE USERS (
    user_ID             int not null AUTO_INCREMENT,
    username            varchar(20),
    -- password_hash  (not sure about the type)
    email               varchar(50),
    first_name          varchar(20),
    last_name           varchar(20),
    user_type           ENUM('Government User', 'Teacher User'),
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
    user_ID             int,
    department          varchar(30),
    job_title           varchar(30),
    FOREIGN KEY (user_ID) REFERENCES users(user_ID)
);

-- Users test data 
INSERT INTO GOVERNMENTUSERS (user_ID, department, job_title) VALUES
(1, 'Department of Education', 'Assistant'),
(3, 'Department of Finance', 'Assistant'),
(5, 'Department of Education', 'Department Admin');

-- TEACHER USERS
CREATE TABLE TEACHERUSERS (
    user_ID             int,
    qualification       varchar(30),
    hire_date           date,
    FOREIGN KEY (user_ID) REFERENCES users(user_ID)
);

-- Users test data
INSERT INTO TEACHERUSERS (user_ID, qualification, hire_date) VALUES
(2, 'Teaching License', '2024-10-15'),
(4, 'Teaching License', '2025-10-15');

-- SCHOOL
CREATE TABLE SCHOOL (
    school_ID           int not null AUTO_INCREMENT,
    school_name         varchar(50),
    school_address      varchar(50),
    ownership_type      varchar(20),
    education_level     varchar(20),
    PRIMARY KEY (school_ID)
);

-- STUDENT
CREATE TABLE STUDENT (
    student_ID          int not null AUTO_INCREMENT,
    first_name          varchar(20),
    last_name           varchar(20),
    date_of_birth       date,
    enrollment_status   ENUM('temp1', 'temp2'),
    disability_status   ENUM('temp1', 'temp2'),
    grade_level         int,
    gender              varchar(20),
    PRIMARY KEY (student_ID)     
);

CREATE TABLE GUARDIANPHONE (
    student_ID          int,
    phone_number        int,
    FOREIGN KEY (student_ID) REFERENCES student(student_ID)
);

-- CLASSES
CREATE TABLE CLASSES (
    class_ID            int not null AUTO_INCREMENT,
    class_name          varchar(20),
    subject_name        varchar(20),
    grade_level         int,
    academic_year       year,
    starts_on           date,
    ends_on             date,
    instruct_language   varchar(20),
    PRIMARY KEY (class_ID)
);

-- LOCALITY 
CREATE TABLE LOCALITY (
    locality_ID         int not null AUTO_INCREMENT,
    locality_name       varchar(20),
    area_type           varchar(20),
    statistics_year     year,
    boys                int,
    girls               int,
    PRIMARY KEY (locality_ID)
);

-- FUNDING
CREATE TABLE FUNDING (
    funding_no          int not null AUTO_INCREMENT,
    source_name         varchar(20),
    source_sector       varchar(20),
    amount              long,
    currency            varchar(20),
    recieved_on         date,
    purpose             varchar(100),
    PRIMARY KEY (funding_no)
);

-- AWARDS
CREATE TABLE AWARDS (
    award_ID            int not null AUTO_INCREMENT,
    award_name          varchar(50),
    awarding_body       varchar(50),
    category            varchar(20),
    awarded_on          date,
    award_description   varchar(200),
    PRIMARY KEY (award_ID)
);

-- GOALS
CREATE TABLE GOALS (
    goal_ID             int not null AUTO_INCREMENT,
    title               varchar(20),
    sdg_target          varchar(50),
    cohort_definition   varchar(100),
    -- baseline_value (not sure about the type)
    goal_status         ENUM('Completed', 'Pending', 'In Progress', 'Assigned'),
    due_date            datetime,
    -- target_value        int?
    metric              ENUM('temp1', 'temp2'),
    PRIMARY KEY (goal_ID)
);

-- REMINDERS
CREATE TABLE REMINDERS (
    reminder_ID         int not null AUTO_INCREMENT,
    reminder_message    varchar(200),
    reminder_status     ENUM('temp1', 'temp2'),
    sent_at             datetime,
    scheduled_at        datetime,
    PRIMARY KEY (reminder_ID)
);

-- COUNTRY
CREATE TABLE COUNTRY (
    country_ID          int not null AUTO_INCREMENT,
    country_name        varchar(50),
    male_pop            long,
    female_pop          long,
    statistics_year     year,
    adult_literacy_rate int,
    -- gdp_per_capita derived?
    PRIMARY KEY (country_ID)
);

-- COMPETENCY
CREATE TABLE COMPETENCY (
    competency_ID       int not null AUTO_INCREMENT,
    assessment_code     int,
    attempt_no          int,
    score               int,
    max_score           int,
    proficiency_cutoff  int,
    assessed_on         date,
    PRIMARY KEY (competency_ID)
);

-- FACILITIES
CREATE TABLE FACILITIES (
    school_ID           int,
    facilities_ID       int not null AUTO_INCREMENT,
    -- not very sure about any of the types or what even is stored here
    electricity         varchar(50),
    internet            varchar(50),
    drinking_water      varchar(50),
    toilets             varchar(50),
    PRIMARY KEY (facilities_ID),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID)
);

-- SESSION
CREATE TABLE SESSIONTABLE (
    session_ID          int not null AUTO_INCREMENT,
    session_date        date,
    start_time          time,
    end_time            time,
    topic               varchar(50),
    session_status      ENUM('Scheduled', 'In Progress', 'Completed'),
    -- attendance_finalized_at datetime?
    PRIMARY KEY (session_ID)
);

-- LITERACY
CREATE TABLE LITERACY (
    literacy_ID         int not null AUTO_INCREMENT,
    assessed_on         date,
    attempt_no          int,
    score               int,
    max_score           int,
    assessment_code     int,
    literacy_cutoff     int,
    PRIMARY KEY (literacy_ID)
);

-- ACTION ITEM
CREATE TABLE ACTIONITEM (
    actionitem_ID       int not null AUTO_INCREMENT,
    title               varchar(30),
    item_description    varchar(200),
    due_date            datetime,
    item_status         ENUM('temp1', 'temp2'),
    completed_on        date,
    PRIMARY KEY (actionitem_ID)
);



DROP USER IF EXISTS 'user'@'localhost';

CREATE USER 'user'@'localhost' IDENTIFIED BY  'password';

GRANT ALL PRIVILEGES ON TEMPNAME.* TO 'user'@'localhost' WITH GRANT OPTION;

GRANT CREATE USER, RELOAD ON *.* TO 'user'@'localhost';

FLUSH PRIVILEGES;