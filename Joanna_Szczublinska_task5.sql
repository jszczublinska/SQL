--1
SELECT e.name, e.surname, d.dept_name, d.address 
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d 
    ON e.DEPT_ID = d.DEPT_ID
ORDER BY e.surname;
--2
SELECT 'Employee ' || e.name || ' ' || e.surname || ' works in ' || d.dept_name
|| ' located at ' || d.address  AS sentence
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d 
    ON e.DEPT_ID = d.DEPT_ID
ORDER BY e.surname;
--3
SELECT e.surname, e.salary
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
WHERE d.address LIKE '47TH STR'
ORDER BY e.surname;
--4
SELECT COUNT(e.surname) AS employees_at_47th_str,
ROUND(AVG(e.salary),2) AS avg_salary
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
WHERE d.address LIKE '47TH STR'
ORDER BY e.surname;
--5
SELECT e.surname, e.job, e.salary,
j.min_salary AS job_min_salary, 
j.max_salary AS job_max_salary
    FROM EMPLOYEES e INNER JOIN JOBS j
    ON e.JOB = j.NAME
ORDER BY e.surname;
--6
SELECT e.surname, e.job, e.salary,
j.min_salary AS job_min_salary,
j.max_salary AS job_max_salary
    FROM employees e INNER JOIN jobs j
    ON e.job = j.name
WHERE e.SALARY NOT BETWEEN j.min_salary AND j.max_salary
ORDER BY e.surname;
--7
SELECT e.surname, e.job, e.salary,
j.min_salary AS job_min_salary,
j.max_salary AS job_max_salary
    FROM employees e INNER JOIN jobs j
    ON e.salary
    BETWEEN j.min_salary
    AND j.max_salary
WHERE j.name = 'ASSISTANT'
ORDER BY e.surname;
--8
SELECT d.dept_name AS department,
COUNT(e.surname) AS employees_at_dept,
SUM(e.salary) AS salaries_at_dept
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
GROUP BY d.dept_name
ORDER BY d.dept_name;
--9
SELECT d.dept_name AS department,
COUNT(e.surname) AS employees_at_dept,
SUM(e.salary) AS salaries_at_dept
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
GROUP BY d.dept_name
HAVING COUNT(e.surname) > 1
ORDER BY d.dept_name;
--10
SELECT d.dept_name AS department,
    CASE  
        WHEN COUNT(e.surname) < 3 THEN 'small'
        WHEN COUNT(e.surname) > 6 THEN 'big'
        ELSE  'medium'
    END AS label
    FROM EMPLOYEES e INNER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
GROUP BY d.dept_name
ORDER BY d.dept_name;