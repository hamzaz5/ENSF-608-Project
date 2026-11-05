USE ensf_608_project;
SHOW TABLES;

SELECT * FROM USERS WHERE username="sobiakhan2";

-- 1.	What is the literacy rate for a particular area?

-- Literacy rate for a country
SELECT COUNTRY.adult_literacy_rate, COUNTRY.country_name 
FROM COUNTRY;

-- Literacy rate among kids using only their best score for a locality
SELECT AVG(LITERACY.score), LITERACY.student_ID
FROM LITERACY
WHERE LITERACY.score IN (SELECT MAX(LITERACY.score)
                        FROM LITERACY
                        GROUP BY LITERACY.student_ID)

-- Get locality from literacy -> class -> school (locality)

-- 2.	Which schools have the lowest average literacy scores in a country?
-- 3.	What is the attendance ratio for boys vs girls in a locality?
-- 4.	Which schools in this country received the most funding?
-- 5.	What are the goals that are being worked on and their current progress?

