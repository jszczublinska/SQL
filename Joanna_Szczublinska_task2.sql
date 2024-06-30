--1
SELECT surname, emp_id, (UPPER(SUBSTR(surname,1,2)) || '' || emp_id) AS login
FROM employees
ORDER BY surname;
--2
SELECT surname
FROM employees
WHERE surname LIKE '%L%' or surname LIKE '%l%'
ORDER BY surname;
--3
SELECT surname
FROM employees
WHERE (INSTR(surname, 'L') BETWEEN 1 AND (LENGTH(surname)/2)) OR
(INSTR(surname, 'l') BETWEEN 1 AND (LENGTH(surname)/2))
ORDER BY surname;
--4
SELECT surname, salary AS original_salary, ROUND(salary*1.15) AS increased_salary
FROM employees
ORDER BY surname;
--5
SELECT TO_CHAR(CURRENT_DATE, 'DAY') AS "Today is"
FROM dual;
--6
SELECT TO_CHAR(DATE '2003-01-22', 'DAY') AS "I was born"
FROM dual;
--7
SELECT surname, TO_CHAR(hire_date, 'FMDD FMMonth YYYY') || ', ' || TO_CHAR(hire_date,'DAY') AS hire_date
FROM employees
ORDER BY surname;
--8
SELECT surname, job, hire_date, (DATE '2000-01-01' - hire_date) YEAR TO MONTH AS experience_in_2000
FROM employees
WHERE job IN ('PROFESSOR','LECTURER','ASSISTANT')
ORDER BY experience_in_2000 DESC, surname;
--9
SELECT surname, job, hire_date, (DATE '2000-01-01' - hire_date) YEAR TO MONTH AS experience_in_2000
FROM employees
WHERE job IN ('PROFESSOR','LECTURER','ASSISTANT') AND 
(DATE '2000-01-01' - hire_date) YEAR TO MONTH > INTERVAL '10' YEAR
ORDER BY experience_in_2000 DESC, surname;
--10
SELECT surname, job, hire_date, EXTRACT(YEAR FROM (DATE '2000-01-01' - hire_date) YEAR TO MONTH) AS experience_in_2000
FROM employees
WHERE job IN ('PROFESSOR','LECTURER','ASSISTANT') AND 
(DATE '2000-01-01' - hire_date) YEAR TO MONTH > INTERVAL '10' YEAR
ORDER BY experience_in_2000 DESC, surname;