--1
WITH
    jobs_salary AS
    (SELECT job, AVG(salary) AS avg_sal_for_job
    FROM EMPLOYEES
    GROUP BY job)
SELECT surname, job, salary, avg_sal_for_job
FROM EMPLOYEES JOIN jobs_salary USING(job)
WHERE salary > avg_sal_for_job
ORDER BY surname;

--2
WITH sum_dept AS
    (SELECT dept_id, dept_name, sum(salary) AS sum_sal
    FROM EMPLOYEES INNER JOIN DEPARTMENTS USING(dept_id)
    GROUP BY dept_id, dept_name)

SELECT dept_name, SUM(salary) AS sum_of_sal
FROM EMPLOYEES JOIN sum_dept USING (dept_id)
GROUP BY dept_name
HAVING SUM(salary) = ( SELECT MAX(sum_sal) FROM sum_dept);

--3
WITH boss_info AS
    (SELECT DISTINCT b.emp_id AS boss_id, b.name AS boss_name, b.surname AS boss_surname, b.salary AS boss_salary
    FROM EMPLOYEES e INNER JOIN EMPLOYEES b ON e.boss_id=b.emp_id)

SELECT e.surname, e.salary, b.boss_name, b.boss_salary
FROM EMPLOYEES e INNER JOIN boss_info b
    ON e.BOSS_ID = b.boss_id
WHERE e.salary >= 0.6*b.boss_salary
ORDER BY e.surname;

--4
SELECT surname, hire_date
FROM EMPLOYEES
ORDER BY hire_date
FETCH FIRST 1 ROWS ONLY;

--5
WITH 
    longest_work AS
    (SELECT surname , hire_date AS longest_days
    FROM EMPLOYEES
    ORDER BY hire_date
    FETCH FIRST 1 ROWS ONLY
    )
SELECT e.surname, e.hire_date - longest_days AS num_of_days
FROM EMPLOYEES e CROSS JOIN longest_work
ORDER BY e.hire_date-longest_days;

--6
WITH grands AS(
    SELECT emp_id, 
        CASE ROUND(salary/1000,0)
            WHEN 0 THEN 'zero'
            WHEN 1 THEN 'one'
            WHEN 2 THEN 'two'
            WHEN 3 THEN 'three'
            WHEN 4 THEN 'four'
            WHEN 5 THEN 'five'
        END AS grand
        FROM EMPLOYEES
)
SELECT e.surname || ' earns ' || g.grand || ' grand' AS sentence
FROM EMPLOYEES e INNER JOIN GRANDS g USING(emp_id)
ORDER BY surname;

--7
WITH emp_hierarchy(emp_id, boss_id, boss_surname, surname, name, they )AS(
    SELECT emp_id, boss_id, surname, 'Smith',name, name || ' ' || surname
    FROM employees
    WHERE job = 'PRINCIPAL'
    UNION ALL
    SELECT e.emp_id, e.boss_id,h.surname, e.surname,e.name, they || ' -> ' || e.name || ' ' || e.surname 
    FROM employees e JOIN emp_hierarchy h
    ON e.boss_id = h.emp_id
)
    SEARCH DEPTH FIRST
    BY surname SET sibl_order

SELECT name || ' ' || surname AS employee, they AS HIERARCHY
FROM emp_hierarchy
ORDER BY sibl_order;