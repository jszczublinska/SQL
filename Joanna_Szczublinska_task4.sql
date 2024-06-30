--1 
SELECT MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary,
    MAX(salary)-MIN(salary) AS difference
FROM employees;
--2
SELECT COUNT(*) AS employees_without_dept
FROM employees
WHERE dept_id IS NULL;
--3
SELECT COUNT(*) AS professors
FROM employees
WHERE job = 'PROFESSOR';
--4
SELECT job, ROUND(AVG(salary ),2) AS job_average_salary
FROM employees
GROUP BY job
ORDER BY job_average_salary DESC;
--5
SELECT job, ROUND(AVG(salary +COALESCE(add_salary, 0)),2) AS job_average_salary,
 COUNT(*) AS employees
FROM employees
GROUP BY job
ORDER BY job_average_salary DESC;
--6
SELECT job, ROUND(AVG(salary +COALESCE(add_salary, 0)),2) AS job_average_salary,
 COUNT(*) AS employees
FROM employees
GROUP BY job
HAVING COUNT(*) > 1
ORDER BY job_average_salary DESC;
--7
SELECT dept_id, COUNT(add_salary)
FROM employees
WHERE dept_id IS NOT NULL
GROUP BY dept_id
ORDER BY dept_id;
--8
SELECT dept_id, COUNT(add_salary),
 AVG(add_salary) AS avg_add_salary,
 SUM(add_salary) AS sum_of_add_salaries
FROM employees
WHERE dept_id IS NOT NULL
GROUP BY dept_id
ORDER BY dept_id;
--9
SELECT boss_id, COUNT(boss_id) AS number_of_subordinates
FROM employees
WHERE boss_id IS NOT NULL
GROUP BY boss_id
ORDER BY boss_id;
--10
SELECT TO_CHAR(HIRE_DATE,'YYYY') AS year_of_employment, 
COUNT(*) AS number_of_employees
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE,'YYYY')
ORDER BY year_of_employment;
--11
SELECT LENGTH(surname) AS surname_length, COUNT(*)
FROM EMPLOYEES
GROUP BY LENGTH(surname)
ORDER BY surname_length;
--12
SELECT COUNT(surname) AS surnames_with_a
FROM EMPLOYEES
WHERE LOWER(surname) LIKE '%a%';
SELECT COUNT(surname) AS surnames_with_e
FROM EMPLOYEES
WHERE LOWER(surname) LIKE '%e%';
--13
SELECT SUM(
CASE INSTR(LOWER(surname), 'a')
WHEN 0 THEN NULL
ELSE 1
END) AS surnames_with_a,
SUM(
CASE INSTR(LOWER(surname), 'e')
WHEN 0 THEN NULL
ELSE 1
END) AS surnames_with_e
FROM employees;