--1
SELECT d.dept_id, d.dept_name, d.address
FROM DEPARTMENTS d
WHERE NOT EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.dept_id);

--2
SELECT surname, salary
FROM (SELECT job, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY job)
    JOIN EMPLOYEES e USING(job)
WHERE salary > avg_salary
ORDER BY surname;

--3
SELECT surname, salary, avg_salary
FROM (SELECT job, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY job)
    JOIN EMPLOYEES e USING(job)
WHERE salary > avg_salary
ORDER BY surname;

--4
SELECT e2.surname, e2.job, e2.salary
FROM(SELECT emp_id, 0.6*salary as boss_salary
    FROM EMPLOYEES) e1
    JOIN EMPLOYEES e2
    ON e2.BOSS_ID = e1.emp_id
WHERE  e2.SALARY > e1.boss_salary
ORDER BY e2.surname;

--5
SELECT MAX(sum_salary) AS max_sum
FROM (SELECT dept_id, sum(salary) AS sum_salary
    FROM employees
    GROUP BY dept_id)
    JOIN departments USING (dept_id); 

--6
SELECT d.dept_name, SUM(e.salary) AS sum_of_sal
FROM DEPARTMENTS d INNER JOIN EMPLOYEES e
ON d.dept_id = e.dept_id
GROUP BY d.dept_name
HAVING SUM(e.salary) = (
    SELECT MAX(sum_salary) AS max_sum
    FROM (SELECT dept_id, sum(salary) AS sum_salary
        FROM employees
        GROUP BY dept_id)
        JOIN departments USING (dept_id)
);

--7
SELECT n.dept_name AS department, e.surname AS employess, n.max_salary AS max_salary
FROM(
    SELECT dept_id, dept_name, max_salary
    FROM(SELECT dept_id, MAX(salary) AS max_salary
        FROM EMPLOYEES
        GROUP BY dept_id) 
        JOIN DEPARTMENTS USING(dept_id)
    ) n JOIN EMPLOYEES e 
    ON n.dept_id = e.dept_id
WHERE n.max_salary = e.salary
ORDER BY n.dept_name;

--8
SELECT surname, salary
FROM EMPLOYEES
WHERE salary >= (
    SELECT MAX(e3.salary)
    FROM EMPLOYEES e3
    WHERE e3.SALARY <(
        SELECT MAX(e2.salary) 
        FROM EMPLOYEES e2
        WHERE e2.salary <
            (SELECT max(e1.salary)
                FROM EMPLOYEES e1
            )
    )
)
ORDER BY salary DESC;