--1
SELECT surname, salary,
    CASE
        WHEN salary < 1500 THEN 'low paid'
        WHEN salary > 3000 THEN 'well paid'
        ELSE 'average paid'
        END AS label
FROM employees
ORDER BY surname;
--2
SELECT DISTINCT boss_id 
FROM employees
WHERE boss_id IS NOT NULL
ORDER BY boss_id;
--3
SELECT DISTINCT dept_id, job
FROM employees
WHERE dept_id IS NOT NULL
ORDER BY dept_id;
--4
SELECT DISTINCT TO_CHAR(hire_date, 'YYYY') AS years
FROM employees
ORDER BY years;
--5
SELECT dept_id FROM departments
EXCEPT
SELECT dept_id FROM employees WHERE dept_id IS NOT NULL;
--6
SELECT surname, salary , 'low paid' AS label FROM employees WHERE salary < 1500 
UNION
SELECT surname, salary, 'average paid' AS label FROM employees WHERE salary BETWEEN 1500 AND 3000
UNION
SELECT surname, salary,'well paid' AS lable FROM employees WHERE salary > 3000
ORDER BY surname;