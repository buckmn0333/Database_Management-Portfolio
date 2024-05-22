CREATE DATABASE projects2;

USE projects2;

SELECT * FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

DESCRIBE hr;
SELECT birthdate FROM hr;

SET sql_safe_updates = 0;

UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'),'%Y-%m-%d')
	ELSE NULL
END;

UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'),'%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'),'%Y-%m-%d')
	ELSE NULL
END;

UPDATE hr
SET termdate=date(str_to_date(termdate,'%Y-%m-%d%H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate!='';

SELECT termdate FROM hr;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;


ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT birthdate FROM hr;


UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT birthdate, age from hr;

ALTER TABLE hr ADD COLUMN age INT;


UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());


SELECT 
   min(age) AS youngest,
   max(age) AS oldest
FROM hr;



SELECT race, COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY race
ORDER BY count(*) DESC;