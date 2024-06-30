--1
SELECT e.name, e.SURNAME, d.DEPT_NAME, d.ADDRESS
FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
ORDER BY e.SURNAME;
--2
SELECT e.name, e.SURNAME, COALESCE(d.DEPT_NAME, 'no department') AS dept_name,
COALESCE(d.ADDRESS, 'no department') AS adress
FROM EMPLOYEES e LEFT OUTER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
ORDER BY e.SURNAME;
--3
SELECT COALESCE(e.NAME, 'no employee') AS name,
COALESCE(e.SURNAME, 'no employee') AS surname,
COALESCE(d.DEPT_NAME, 'no department') AS dept_name,
COALESCE(d.ADDRESS, 'no department') AS adress
FROM EMPLOYEES e FULL OUTER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
ORDER BY e.SURNAME;
--4
SELECT d.DEPT_NAME AS department,
COUNT(e.NAME) AS emloyess_at_dept,
SUM(e.SALARY) as salaries_at_dept
FROM EMPLOYEES e RIGHT OUTER JOIN DEPARTMENTS d
    ON e.DEPT_ID = d.DEPT_ID
GROUP BY d.DEPT_NAME
ORDER BY d.DEPT_NAME;
--5
SELECT e.surname AS employee, COALESCE(b.surname, 'no boss') AS boss
FROM EMPLOYEES e LEFT OUTER JOIN EMPLOYEES b
    ON e.BOSS_ID = b.EMP_ID
ORDER BY e.surname;
--6
SELECT e.surname AS employee, COALESCE(b.surname, 'no boss') AS boss
FROM EMPLOYEES e LEFT OUTER JOIN EMPLOYEES b
    ON e.BOSS_ID = b.EMP_ID
WHERE b.surname in ('Smith', 'Wilson') OR b.surname IS NULL
ORDER BY e.surname;
--7
SELECT e.surname AS employee, 12*e.salary+COALESCE(e.add_salary, 0) AS emp_annual_salary,
(12*b.salary+COALESCE(b.add_salary, 0))-(12*e.salary+COALESCE(e.add_salary, 0)) AS less_than_boss
FROM EMPLOYEES e LEFT OUTER JOIN EMPLOYEES b
    ON e.BOSS_ID = b.EMP_ID
ORDER BY e.surname;
--8
SELECT b.SURNAME, COUNT(e.NAME)
FROM EMPLOYEES e RIGHT OUTER JOIN EMPLOYEES b
    ON e.BOSS_ID = b.EMP_ID
GROUP BY b.surname
ORDER BY b.surname;
--9
SELECT e.name || ' '|| e.surname AS employee,
d.dept_name AS employee_department,
b.name || ' ' || b.surname AS boss,
db.dept_name AS boss_department
FROM EMPLOYEES e INNER JOIN EMPLOYEES b
    ON e.BOSS_ID = b.EMP_ID
    INNER JOIN DEPARTMENTS d 
        ON e.DEPT_ID = d.DEPT_ID
    INNER JOIN DEPARTMENTS db
        ON b.DEPT_ID = db.DEPT_ID  
ORDER BY e.name;
--10
SELECT e.name || ' '|| e.surname  AS employee,
COALESCE(d.dept_name, 'no department') AS employee_department,
COALESCE(b.name,'no boss') || ' ' || COALESCE(b.surname,'') AS boss ,
COALESCE(db.dept_name, 'no department') AS boss_department
FROM EMPLOYEES e LEFT OUTER JOIN EMPLOYEES b
    ON e.BOSS_ID = b.EMP_ID
    LEFT OUTER JOIN DEPARTMENTS d 
        ON e.DEPT_ID = d.DEPT_ID
    LEFT OUTER JOIN DEPARTMENTS db
        ON b.DEPT_ID = db.DEPT_ID  
ORDER BY e.name;
--11
SELECT COUNT(surname) AS rows_of_cartesion_product
FROM EMPLOYEES CROSS JOIN DEPARTMENTS CROSS JOIN JOBS;