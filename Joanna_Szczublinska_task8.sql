--1
INSERT INTO EMPLOYEES
VALUES(300, 'Snow', 'Jack', 'PROFESSOR', (SELECT emp_id FROM EMPLOYEES WHERE name LIKE 'John' AND surname LIKE 'Smith'), DATE '2013-05-02', 4750, NULL, (SELECT dept_id FROM DEPARTMENTS WHERE dept_name='EXPERT SYSTEMS'));
INSERT INTO EMPLOYEES
VALUES (310, 'Cook', 'Robin', 'PROFESSOR',(SELECT emp_id FROM EMPLOYEES WHERE name LIKE 'John' AND surname LIKE 'Smith'), DATE '2016-10-16', 3500, 1250,(SELECT dept_id FROM DEPARTMENTS WHERE dept_name='ALGORITHMS'));
INSERT INTO EMPLOYEES
VALUES (320, 'Dormand', 'Francis', 'ASSISTANT', (SELECT emp_id FROM EMPLOYEES WHERE name LIKE 'Carl' AND surname LIKE 'Jones'), DATE '2018-01-02', 3900, NULL,(SELECT dept_id FROM DEPARTMENTS WHERE dept_name='ALGORITHMS'));

SELECT EMP_ID, NAME, SURNAME, JOB, BOSS_ID, HIRE_DATE, SALARY, ADD_SALARY, DEPT_ID
FROM EMPLOYEES
WHERE EMP_ID IN (300,310,320);

--2
INSERT INTO DEPARTMENTS
VALUES(70, 'DATABASE SYSTEMS', DEFAULT);

SELECT dept_id, dept_name, address
FROM DEPARTMENTS
WHERE dept_id=70;

--3
UPDATE EMPLOYEES
SET dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'DATABASE SYSTEMS')
WHERE emp_id IN (300,310,320);

SELECT surname, name, salary, add_salary
FROM EMPLOYEES 
WHERE dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'DATABASE SYSTEMS')
ORDER BY surname;

--4
UPDATE EMPLOYEES e
SET (e.salary, e.add_salary) = (
    SELECT e2.SALARY*1.1, 
        CASE 
        WHEN e2.add_salary IS NULL THEN 100
        ELSE e2.add_salary*1.2
        END AS additional_salary
    FROM EMPLOYEES e2
    WHERE e2.emp_id=e.emp_id
)
WHERE e.dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'DATABASE SYSTEMS');

SELECT surname, name, salary, add_salary
FROM EMPLOYEES 
WHERE dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'DATABASE SYSTEMS')
ORDER BY surname;

--5
UPDATE EMPLOYEES e1
SET e1.salary = ( 
    SELECT e1.salary + 0.1*(SELECT AVG(salary) FROM EMPLOYEES 
    WHERE dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'ADMINISTRATION'))
    FROM EMPLOYEES e2
    WHERE e1.emp_id = e2.emp_id
)
WHERE e1.dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'DATABASE SYSTEMS');

SELECT surname, name, salary, add_salary
FROM EMPLOYEES 
WHERE dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name LIKE 'DATABASE SYSTEMS')
ORDER BY surname;

--6
DELETE FROM DEPARTMENTS
WHERE DEPT_NAME = 'DATABASE SYSTEMS';
-- This operation finish with error, because it has got child record. It means that this value is used in another query

--7
DELETE FROM EMPLOYEES
WHERE salary < 5000 AND dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name = 'DATABASE SYSTEMS');

UPDATE EMPLOYEES
SET dept_id = NULL
WHERE dept_id = (SELECT dept_id FROM DEPARTMENTS WHERE dept_name = 'DATABASE SYSTEMS');

SELECT *
FROM EMPLOYEES;

--8
DELETE FROM DEPARTMENTS
WHERE DEPT_NAME = 'DATABASE SYSTEMS';

SELECT *
FROM DEPARTMENTS;

--9
DELETE FROM EMPLOYEES
WHERE emp_id = 300 AND name LIKE 'Jack' AND surname LIKE 'Snow';

SELECT *
FROM EMPLOYEES;