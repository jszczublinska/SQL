--1
SELECT * FROM DEPARTMENTS;
--2
SELECT * FROM EMPLOYEES;
--3
SELECT surname, job, salary*12 FROM EMPLOYEES;
--4
SELECT surname, job, salary*12 AS "yearly_income" FROM EMPLOYEES;
--5
SELECT surname, job, salary + COALESCE(add_salary, 0) AS "monthly_income" FROM EMPLOYEES
ORDER BY "monthly_income";
--6
SELECT name || ' ' || surname AS "assistants" FROM EMPLOYEES
WHERE job = 'ASSISTANT'
ORDER BY name, surname;
--7
SELECT name || ' ' || surname AS "employee", job, salary, dept_id FROM EMPLOYEES
WHERE dept_id = 30 OR dept_id = 40
ORDER BY salary DESC;
--8
SELECT name || ' ' || surname AS "employee", job, salary FROM EMPLOYEES
WHERE salary BETWEEN 1000 AND 2000
ORDER BY salary;
--9
SELECT name, surname FROM EMPLOYEES
WHERE surname LIKE '%son';
--10
SELECT name, surname FROM EMPLOYEES
WHERE dept_id IS NULL;
--11
SELECT name, surname, boss_id, salary FROM EMPLOYEES
WHERE boss_id IS NOT NULL AND salary > 2000;
--12
SELECT name, surname, dept_id FROM EMPLOYEES
WHERE dept_id = 20 AND ( surname LIKE 'W%' OR surname LIKE '%son');
--13
SELECT name, surname, salary+COALESCE(add_salary, 0) AS "monthly_salary" FROM EMPLOYEES
WHERE salary+COALESCE(add_salary, 0) > 4000;
--14
SELECT 'Employee ' || name || ' ' || surname || 'works as ' || job 
|| ' and earns ' || (salary+coalesce(ADD_SALARY,0)) AS "employees" 
FROM EMPLOYEES
ORDER BY surname, name;