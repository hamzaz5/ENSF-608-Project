-- Changes I've made 
-- added teacher id and gov id

DROP DATABASE IF EXISTS ENSF_608_Project;

CREATE DATABASE ENSF_608_Project;
USE ENSF_608_Project;

-- USERS
-- SHA256 hash creates a 64 character hash 
CREATE TABLE USERS (
    user_ID             int not null AUTO_INCREMENT,
    username            varchar(30),
    password_hash       VARCHAR(64), 
    email               varchar(255),
    first_name          varchar(100),
    last_name           varchar(100),
    user_type           ENUM('Government User', 'Teacher User'),
    PRIMARY KEY (user_ID)
);

-- GOVERNMENT USERS
CREATE TABLE GOVERNMENT_USER (
    gov_ID              int NOT NULL AUTO_INCREMENT,
    user_ID             int,
    department          varchar(200),
    job_title           varchar(200),      
    FOREIGN KEY (user_ID) REFERENCES users(user_ID)
);

-- SCHOOL
-- locality id foreign key added at bottom
CREATE TABLE SCHOOL (
    school_ID           int not null AUTO_INCREMENT,
    school_name         varchar(100),
    school_address      varchar(200),
    ownership_type      varchar(20),
    education_level     varchar(20),
    PRIMARY KEY (school_ID)
);

-- TEACHER USERS
CREATE TABLE TEACHER_USER (
    teacher_ID          int NOT NULL AUTO_INCREMENT, 
    user_ID             int,
    qualification       varchar(200),
    hire_date           date,
    school_ID           int,
    FOREIGN KEY (user_ID) REFERENCES users(user_ID),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID)
);

-- Admin users
CREATE TABLE ADMIN (
    user_ID             int,
    FOREIGN KEY (user_ID) REFERENCES users(user_ID)
);

-- STUDENT
-- Enrollement status should be binary, enrolled - 1, not enrolled - 0
-- Disability status - varchar - lots of diabilities with unique needs
CREATE TABLE STUDENT (
    student_ID          int not null AUTO_INCREMENT,
    first_name          varchar(100),
    last_name           varchar(100),
    date_of_birth       date,
    enrollment_status   BOOL,
    disability_status   varchar(150),
    grade_level         int,
    gender              varchar(20),
    
    PRIMARY KEY (student_ID)     
);

CREATE TABLE GUARDIAN_PHONE (
    student_ID          int,
    phone_number        VARCHAR(15),
    
    PRIMARY KEY (student_ID, phone_number),
    FOREIGN KEY (student_ID) REFERENCES student(student_ID)
);

-- CLASSES
CREATE TABLE CLASS (
    class_ID                int not null AUTO_INCREMENT,
    class_name              varchar(255),
    subject_name            varchar(255),
    grade_level             int,
    instructional_language  varchar(100),
    academic_year           year,
    starts_on               date,
    ends_on                 date, 
    school_ID               int not NULL,
    teacher_id              int,
    
    PRIMARY KEY (class_ID),
    FOREIGN KEY (school_id) REFERENCES school(school_ID),
    FOREIGN KEY (teacher_id) REFERENCES Teacher_User(teacher_id)
);

CREATE TABLE CLASS_STUDENT_TAKES (
    class_ID    INT,
    student_ID  INT,
    joined_on   DATE,
    left_on     DATE,

    PRIMARY KEY(class_ID, student_ID),
    FOREIGN KEY(class_ID) REFERENCES class(class_ID),
    FOREIGN KEY (student_ID) REFERENCES STUDENT(student_ID)
);

-- COUNTRY
CREATE TABLE COUNTRY (
    country_ID          int not null AUTO_INCREMENT,
    country_name        varchar(100),
    male_pop            long,
    female_pop          long,
    statistics_year     year,
    adult_literacy_rate float,
    gdp_per_capita      float,
    PRIMARY KEY (country_ID)
);

-- LOCALITY
CREATE TABLE LOCALITY (
    locality_ID             int not null AUTO_INCREMENT,
    locality_name           varchar(100),
    area_type               varchar(50),
    statistics_year         year,
    school_age_pop_boys     int,
    school_age_pop_girls    int,
    country_ID              int not NULL,

    PRIMARY KEY (locality_ID),
    FOREIGN KEY (country_ID) REFERENCES country(country_ID)
);

-- AWARDS
CREATE TABLE AWARDS (
    award_ID            int not null AUTO_INCREMENT,
    award_name          varchar(255),
    awarding_body       varchar(255),
    category            varchar(255),
    awarded_on          date,
    award_description   varchar(1000),
    school_ID           int not null,

    PRIMARY KEY (award_ID),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID)
);

-- FUNDING
CREATE TABLE FUNDING (
    funding_no          int not null AUTO_INCREMENT,
    source_name         varchar(255),
    source_sector       varchar(255),
    amount              long,
    currency            varchar(100),
    recieved_on         date,
    purpose             varchar(100),
    school_ID           int NOT NULL,
    award_ID            int NOT NULL,

    PRIMARY KEY (funding_no),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID),
    FOREIGN KEY (award_ID) REFERENCES awards(award_ID)
);

-- GOALS
CREATE TABLE GOALS (
    goal_ID             int not null AUTO_INCREMENT,
    title               varchar(200),
    sdg_target          varchar(80),
    cohort_definition   varchar(255),
    baseline_value      int,
    metric              varchar(255),
    target_value        int,
    due_date            datetime,
    goal_status         ENUM('Completed', 'Pending', 'In Progress', 'Assigned', 'To Be Assigned'),
    school_ID           int NOT NULL,
    -- government_user_ID  int,
    
    PRIMARY KEY (goal_ID),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID)
    -- FOREIGN KEY (government_user_ID) REFERENCES government_user(user_id)
);

-- ACTION ITEM
CREATE TABLE ACTIONITEM (
    actionitem_ID       int not null AUTO_INCREMENT,
    title               varchar(255),
    item_description    varchar(255),
    due_date            datetime,
    item_status         varchar(100),
    completed_on        date,
    -- goal_ID             int,
    -- user_ID             int,
    -- teacher_user_ID     int,
    -- student_id          int,
    -- school_id           int,

    PRIMARY KEY (actionitem_ID)
);

-- REMINDERS
CREATE TABLE REMINDERS (
    reminder_ID         int not null AUTO_INCREMENT,
    reminder_message    varchar(255),
    reminder_status     ENUM('sent', 'recieved', 'viewed'),
    sent_at             datetime,
    scheduled_at        datetime,
    school_ID           int,
    actionitem_ID       int,
    user_ID             int,

    PRIMARY KEY (reminder_ID),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID),
    FOREIGN KEY (actionitem_ID) REFERENCES actionitem(actionitem_ID),
    FOREIGN KEY (user_ID) REFERENCES users(user_id)
);

-- Normalization table
CREATE TABLE COMPETENCY_ASSESSMENT (
    Assesment_code      int,
    max_score           int,
    proficiency_cutoff  int,

    PRIMARY KEY (Assessment_code)
);

-- COMPETENCY
CREATE TABLE COMPETENCY (
    competency_ID       int not null AUTO_INCREMENT,
    assessment_code     int,
    attempt_no          int,
    score               int,
    -- max_score           int,
    -- proficiency_cutoff  int,
    assessed_on         date,
    class_ID            int,
    student_ID          int,
    
    PRIMARY KEY (competency_ID),
    FOREIGN KEY (assessment_code) REFERENCES COMPETENCY_ASSESSMENT(Assesment_code),
    FOREIGN KEY (class_ID) REFERENCES class(class_ID),
    FOREIGN KEY (student_ID) REFERENCES student(student_ID)
);

-- FACILITIES - Weak entity?
-- I think this should be added to school 
CREATE TABLE FACILITIES (
    school_ID           int,
    -- facilities_ID       int not null AUTO_INCREMENT,
    electricity         BOOLEAN,
    internet            BOOLEAN,
    drinking_water      BOOLEAN,
    toilets             BOOLEAN,
    -- PRIMARY KEY (facilities_ID),
    FOREIGN KEY (school_ID) REFERENCES school(school_ID)
);

-- SESSION
CREATE TABLE SESSION (
    session_ID          int not null AUTO_INCREMENT,
    session_date        date,
    start_time          time,
    end_time            time,
    topic               varchar(100),
    session_status      ENUM('Scheduled', 'In Progress', 'Completed'),
    attendance_finalized_at date,
    -- class_ID

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
    -- class_ID
    -- student_ID

    PRIMARY KEY (literacy_ID)
);


-- Add foreign key relations that break table order
ALTER TABLE School
    ADD(locality_id int, FOREIGN KEY (locality_id) REFERENCES Locality(locality_id));