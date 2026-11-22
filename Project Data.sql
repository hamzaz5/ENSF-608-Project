USE ENSF_608_Project;

-- Users test data 
INSERT INTO USERS (user_ID, username, email, first_name, last_name, user_type) VALUES
(1, 'hamzaitani1', 'hamza.itani@gmail.com', 'Hamza', 'Itani', 'Government User'),
(2, 'sobiakhan2', 'sobia.khan@gmail.com', 'Sobia', 'Khan', 'Teacher User'),
(3, 'ericgodin3', 'eric.godin@gmail.com', 'Eric', 'Godin', 'Government User'),
(4, 'hyunseongjeon4', 'hyunseong.jeon@gmail.com', 'Hyunseong', 'Jeon', 'Teacher User'),
(5, 'changgunyee5', 'changgun.yee@gmail.com', 'Changgun', 'Yee', 'Government User');

INSERT INTO COUNTRY (country_ID, country_name) VALUE
(1, "CANADA"),
(2, "PAKISTAN");

-- Users test data 
INSERT INTO GOVERNMENT_USER (government_ID, department, job_title, country_id) VALUES
(1, 'Department of Education', 'Assistant', 1),
(3, 'Department of Finance', 'Assistant', 1),
(5, 'Department of Education', 'Department Admin', 2);

INSERT INTO LOCALITY (locality_name, country_ID) VALUE
("AB-CAL-DT", 1),
("SI-KAR-SP", 2);

INSERT INTO SCHOOL (school_ID, school_name, education_level, locality_id) VALUE
(1, "Langevin", "Junior High", 1),
(2, "Karachi Public School", "K-12", 2);

-- Users test data
INSERT INTO TEACHER_USER (teacher_ID, qualification, hire_date, school_id) VALUES
(2, 'Teaching License', '2024-10-15', 1),
(4, 'Teaching License', '2025-10-15', 2);

INSERT INTO CLASS (class_ID, class_name, subject_name, school_ID, teacher_ID) VALUE
(1, "MATH 9", "MATH", 1, 2),
(2, "ENG 8", "ENGLISH", 1, 2),
(3, "URDU 9", "URDU", 2, 4);

INSERT INTO SESSION (session_id, session_date, start_time, end_time, topic, session_status, attendance_finalized_at, class_ID) VALUE 
(1, "2025-09-01", "8:15", "9:30", "Intro to MATH 8", "Completed", "2025-09-02", "2"),
(2, "2025-09-02", "8:15", "9:30", "Review MATH 7", "Completed", "2025-09-03", "2"),
(3, "2026-09-01", "8:15", "9:30", "Intro to MATH 9", "Completed", "2026-09-02", "1"), 
(4, "2026-09-02", "8:15", "9:30", "Review MATH 8", "Completed", "2026-09-03", "1");

INSERT INTO STUDENT (student_ID, first_name, last_name, date_of_birth, enrollment_status, disability_status, grade_level, gender) VALUES
(1, "Amy", "Black", '2011-09-04', 1, "", 9, "Female"),
(2, "Madeline", "Hester", '2012-10-09', 1, "Hearing Impaired", 8, "Female"),
(3, "Max", "White", '2011-08-04', 1, "", 9, "Male");

INSERT INTO GUARDIAN_PHONE (student_ID, phone_number) VALUES 
(1, '14031234560'),
(1, '15871234560'),
(2, '14031234560'),
(3, '15871112222');

INSERT INTO class_student_takes (class_id, student_id, joined_on, left_on) VALUES
(2, 1, "2025-09-01", "2026-06-30"),
(1, 1, "2026-09-01", NULL),
(1, 3, "2026-09-01", NULL),
(2, 2, "2026-09-01", NULL);

INSERT INTO ATTENDANCE (student_id, session_id, attendance, absence_reason) VALUES
(1, 1, 'present', NULL),
(1, 2, 'absent', 'medical appointment'),
(1, 3, 'present', NULL),
(1, 4, 'present', NULL);

INSERT INTO LITERACY_ASSESSMENT (assessment_code, max_score, literacy_cutoff) VALUES
("ENG-8-2026", 120, 60),
("ENG-9-2027", 100, 60);

INSERT INTO competency_assessment (assessment_code, max_score, proficiency_cutoff) VALUES
("MATH-8-2026", 200, 120),
("MATH-9-2027", 150, 100);

INSERT INTO competency (competency_id, assessment_code, attempt_no, score, assessed_on, class_id, student_id) VALUES
(1, "MATH-8-2026", 1, 100, "2026-06-20", 2, 1),
(2, "MATH-8-2026", 2, 180, "2026-08-20", 2, 1);

INSERT INTO LITERACY (literacy_id, assessment_code, attempt_no, score, assessed_on, class_id, student_id) VALUES
(1, "ENG-8-2026", 1, 100, "2026-06-18", 2, 1),
(2, "ENG-8-2026", 1, 50, "2026-06-18", 2, 3),
(3, "ENG-8-2026", 2, 120, "2026-08-18", 2, 3);

INSERT INTO funding_source(source_name, source_sector) VALUES
("UN", "Literacy"),
("USAID", "Literacy");

INSERT INTO AWARDS(award_ID, award_name, awarding_body, category, awarded_on, award_description, school_ID) VALUES
(1, 'Outsanding Performance Award', 'Government of Canada', 'Academics', '2026-11-10 12:00:00', 'Award issued for students with exemplary performance in academics', 2),
(2, 'Community Outreach Award', 'Government of Canada', 'Community Service', '2026-11-20 12:00:00', 'Award issued for students with an overwhelming amount of community service', 1);

INSERT INTO FUNDING(source_name, amount, currency, received_on, purpose, school_ID, award_ID) VALUES
("UN", 100000, "USD", "2026-06-01", "Promote literacy", 1, 1),
("USAID", 1000000, "USD", "2026-01-30", "Increase litearcy among school aged children", 2, 2);

INSERT INTO GOALS (goal_ID, title, sdg_target, cohort_definition, baseline_value, metric, target_value, due_date, goal_status, school_ID, government_ID) VALUES
(1, 'Improve Grade 9 Mathematics Performance', 'SDG 4.1', 'All Grade 9 students at Langevin', 65, 'Average Mathematics Score', 85, '2027-06-30', 'In Progress', 1, 1),
(2, 'Improve Student Literacy Rates', 'SDG 4.6', 'All Grade 8 students at Langevin', 55, 'Average Literacy Score', 80, '2027-06-30', 'In Progress', 1, 1),
(3, 'Increase Literacy Performance in Karachi', 'SDG 4.6', 'All Grade 9 students at Karachi Public School', 50, 'Average Literacy Score', 85, '2027-12-31', 'In Progress', 2, 5),
(4, 'Improve Overall School Attendance', 'SDG 4.1', 'All enrolled students at Langevin', 85, 'Attendance Rate', 95, '2027-06-30', 'Assigned', 1, 3),
(5, 'Increase Access to Quality Education', 'SDG 4.1', 'All enrolled students at Karachi Public School', 70, 'Enrollment Rate', 95, '2027-12-31', 'In Progress', 2, 5);

INSERT INTO ACTIONITEM (actionitem_ID, title, item_description, item_status, due_date, completed_on, goal_ID, teacher_ID, student_ID, school_ID) VALUES
(1, 'Conduct Mathematics Review Sessions', 'Organize additional mathematics review sessions for Grade 9 students.', 'In Progress', '2026-12-15', NULL, 1, 2, 1, 1),
(2, 'Complete Literacy Assessments', 'Conduct literacy assessments for all enrolled Grade 8 students.', 'Not Started', '2026-12-20', NULL, 2, 2, 2, 1),
(3, 'Develop Literacy Improvement Program', 'Create and implement a literacy improvement program for Grade 9 students.', 'In Progress', '2027-01-15', NULL, 3, 4, 3, 2),
(4, 'Improve Student Attendance', 'Monitor student attendance and contact guardians regarding repeated absences.', 'Completed', '2026-10-30', '2026-10-25', 4, 2, 1, 1),
(5, 'Complete Additional Mathematics Practice', 'Complete additional mathematics exercises to improve assessment performance.', 'In Progress', '2026-12-10', NULL, 1, 2, 3, 1),
(6, 'Organize Community Enrollment Campaign', 'Organize an outreach campaign to increase school enrollment.', 'Not Started', '2027-03-01', NULL, 5, 4, 2, 2);

INSERT INTO REMINDERS (reminder_ID, reminder_message, reminder_status, sent_at, scheduled_at, school_ID, actionitem_ID, user_ID) VALUES
(1, 'Submit monthly literacy progress report', 'sent', '2026-10-01 08:00:00', '2026-11-01 08:00:00', 1, 1, 1),
(2, 'Complete student attendance records', 'received', '2026-11-01 08:00:00', '2026-11-02 08:00:00', 1, 2, 2),
(3, 'Review funding allocation for literacy program', 'sent', '2026-10-15 10:00:00', '2026-10-20 10:00:00', 2, 3, 5),
(4, 'Submit updated student assessment scores', 'viewed', '2026-11-15 12:00:00', '2026-11-25 12:00:00', 2, 3, 4),
(5, 'Review school literacy performance', 'viewed', '2026-09-01 09:00:00', '2026-12-01 09:00:00', 1, 4, 3);

INSERT INTO COUNTRY_STATISTICS (country_ID, statistics_year, male_pop, female_pop, gdp_per_capita, adult_literacy_rate) VALUES
(1, 2024, 20000000, 20500000, 53400, 99.0),
(1, 2025, 20200000, 20700000, 54800, 99.0),
(1, 2026, 20400000, 20900000, 56000, 99.1),
(2, 2024, 125000000, 120000000, 1500, 58.0),
(2, 2025, 127000000, 122000000, 1580, 59.0),
(2, 2026, 129000000, 124000000, 1650, 60.0);
