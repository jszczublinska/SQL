--1
SELECT surname, job
FROM EMPLOYEES
WHERE DEPT_ID = ( 
    SELECT dept_id
    FROM EMPLOYEES
    WHERE surname LIKE 'Johnson') 
AND surname NOT LIKE 'Johnson'
ORDER BY surname;
--2
SELECT e.surname, e.job, d.DEPT_NAME
FROM EMPLOYEES e LEFT JOIN DEPARTMENTS d ON
    e.DEPT_ID = d.DEPT_ID
WHERE e.DEPT_ID = ( 
    SELECT dept_id
    FROM EMPLOYEES
    WHERE surname LIKE 'Johnson') 
AND e.surname NOT LIKE 'Johnson'
ORDER BY e.surname;
--3
SELECT surname, job, hire_date
FROM EMPLOYEES
WHERE hire_date = (
    SELECT min(hire_date)
    FROM EMPLOYEES
    WHERE job LIKE 'LECTURER'
) AND
JOB LIKE 'LECTURER';
--4
SELECT d.DEPT_NAME, e.surname, e.hire_date
FROM EMPLOYEES e LEFT JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
WHERE (e.DEPT_ID, e.HIRE_DATE) IN (
    SELECT dept_id, MAX(hire_date)
    FROM EMPLOYEES
    GROUP BY DEPT_ID
)
ORDER BY d.DEPT_NAME;
--5
SELECT dept_id, dept_name, address
FROM DEPARTMENTS
WHERE dept_id NOT IN (
    SELECT dept_id
    FROM EMPLOYEES
    WHERE dept_id IS NOT NULL
);
--6
SELECT surname, job, salary
FROM EMPLOYEES 
WHERE emp_id NOT IN (
    SELECT BOSS_ID
    FROM EMPLOYEES 
    WHERE JOB = 'PHD STUDENT' 
) AND job LIKE 'PROFESSOR'
ORDER BY surname;
--7
SELECT d.dept_name, COUNT(e.surname) AS num_of_empl
FROM EMPLOYEES e RIGHT JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
GROUP BY d.DEPT_NAME
HAVING COUNT(e.SURNAME) > (
    SELECT COUNT(e.surname)
    FROM EMPLOYEES e RIGHT JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
    WHERE d.dept_name LIKE 'ADMINISTRATION'
);
--8
SELECT EXTRACT(YEAR FROM hire_date) AS year,
COUNT(emp_id) AS number_of_professors
FROM EMPLOYEES 
WHERE job LIKE 'PROFESSOR'
GROUP BY EXTRACT(YEAR FROM hire_date)
HAVING COUNT(emp_id) = (
    SELECT MAX( COUNT(emp_id))
    FROM EMPLOYEES
    WHERE job LIKE 'PROFESSOR'
    GROUP BY EXTRACT(YEAR FROM hire_date)
)
ORDER BY EXTRACT(YEAR FROM hire_date);
--9
SELECT d.DEPT_NAME as department,
SUM(e.salary+COALESCE(e.ADD_SALARY,0)) AS max_sum
FROM DEPARTMENTS d RIGHT JOIN EMPLOYEES e
    ON d.DEPT_ID = e.DEPT_ID
GROUP BY d.DEPT_NAME
HAVING SUM(e.salary+COALESCE(e.ADD_SALARY,0))=(
    SELECT MAX(SUM(e.salary+COALESCE(e.ADD_SALARY,0)))
    FROM DEPARTMENTS d RIGHT JOIN EMPLOYEES e
        ON d.DEPT_ID = e.DEPT_ID
    GROUP BY d.DEPT_NAME
);