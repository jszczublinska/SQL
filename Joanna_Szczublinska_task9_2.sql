--CONSTRAINTS
--2
ALTER TABLE PROJECTS
    ADD CONSTRAINT pk_projects PRIMARY KEY(project_id)
    ADD CONSTRAINT uk_projects_name UNIQUE(project_name)
    MODIFY project_name NOT NULL
    MODIFY start_date NOT NULL
    ADD CONSTRAINT chk_projects_end_start_date CHECK (end_date> start_date)
    ADD CONSTRAINT chk_projects_budget CHECK(project_budget>0)
    ADD CONSTRAINT chk_projects_no_of_emp CHECK(number_of_emp >= 0);

--3
ALTER TABLE PROJECTS
MODIFY number_of_emp NOT NULL;
-- I do not succeed, because null values were found

UPDATE PROJECTS
SET number_of_emp=0;

ALTER TABLE PROJECTS
MODIFY number_of_emp NOT NULL;
-- now I succeed

--4
ALTER TABLE PROJECTS
ADD manager_id number(4)
ADD CONSTRAINT projects_fk_emps FOREIGN KEY(manager_id) REFERENCES EMPLOYEES (emp_id);

--5
UPDATE PROJECTS
SET MANAGER_ID = 300;
-- foreign key works because parent key is not found

--6
UPDATE PROJECTS
SET MANAGER_ID = 180
WHERE project_name LIKE 'Advanced Data Analysis';

DELETE FROM EMPLOYEES
WHERE EMP_ID = 180;
-- I did not succeed, because the child record was found

--7
CREATE TABLE Assignments (
    project_id numeric NOT NULL,
    CONSTRAINT ass_fk_proj FOREIGN KEY(project_id) REFERENCES PROJECTS(project_id),
    emp_id numeric(4) NOT NULL,
    CONSTRAINT ass_fk_emp FOREIGN KEY(emp_id) REFERENCES EMPLOYEES(emp_id),
    function varchar(100) NOT NULL,
    CONSTRAINT function_check CHECK( function IN ('designer', 'programmer', 'tester')),
    start_date date DEFAULT CURRENT_DATE NOT NULL,
    end_date date,
    CONSTRAINT end_date_check CHECK( end_date > start_date),
    salary numeric(8,2) NOT NULL CONSTRAINT salary_check CHECK( salary > 0),
    CONSTRAINT pk_assignments PRIMARY KEY(project_id, emp_id, start_date)
);

--8
INSERT INTO ASSIGNMENTS(project_id, emp_id, function, start_date, end_date, salary)
VALUES(1, 110, 'programmer', '2019-05-26', '2022-06-25', 3000);
INSERT INTO ASSIGNMENTS(project_id, emp_id, function, start_date, end_date, salary)
VALUES(1, 120, 'designer', '2019-05-26', '2022-06-25', 2400);
INSERT INTO ASSIGNMENTS(project_id, emp_id, function, start_date, end_date, salary)
VALUES(1, 130, 'tester', '2019-05-26', '2022-06-25', 5000);
INSERT INTO ASSIGNMENTS(project_id, emp_id, function, start_date, end_date, salary)
VALUES(2, 150, 'programmer', '2015-03-14', '2020-01-01', 6000);

--9
INSERT INTO ASSIGNMENTS(project_id, emp_id, function, start_date, end_date, salary)
VALUES(2, 140, 'artist', '2015-03-14', '2020-01-01', 4000);

--10
ALTER TABLE ASSIGNMENTS
DROP CONSTRAINT function_check;

INSERT INTO ASSIGNMENTS(project_id, emp_id, function, start_date, end_date, salary)
VALUES(2, 140, 'artist', '2015-03-14', '2020-01-01', 4000);


-- VIEWS
--1
CREATE VIEW PROFESSORS(name, surname, hire_date, salary, add_salary, add_percent) AS
SELECT name, surname, hire_date, salary, add_salary, ROUND((add_salary/salary)*100,2)
FROM EMPLOYEES 
WHERE JOB LIKE 'PROFESSOR';

SELECT *
FROM PROFESSORS
ORDER BY surname;

--2
CREATE VIEW DEPARTMENTS_TOTAL(dept_id, dept_name, avg_salary, num_of_empls) AS
SELECT d.dept_id, d.dept_name, ROUND(AVG(e.salary),2), COUNT(e.salary)
FROM DEPARTMENTS d LEFT JOIN EMPLOYEES e ON d.dept_id = e.dept_id
GROUP BY d.dept_id, d.dept_name
ORDER BY d.dept_name;

SELECT *
FROM DEPARTMENTS_TOTAL;

--3
SELECT e.surname, e.name, e.salary, d.dept_name, d.avg_salary, e.salary-d.avg_salary AS diff
FROM EMPLOYEES e INNER JOIN DEPARTMENTS_TOTAL d ON e.dept_id = d.dept_id
WHERE e.SALARY > d.AVG_SALARY
ORDER BY e.surname;

--4
SELECT dept_name, num_of_empls
FROM DEPARTMENTS_TOTAL
ORDER BY num_of_empls DESC
FETCH FIRST 1 ROWS ONLY;

--5
CREATE VIEW EMPS_AND_BOSSES( employee, emp_salary, boss, boss_salary) AS
SELECT e.surname || ' ' || e.name, e.salary,  b.surname || ' ' || b.name, b.salary AS boss_salary
FROM EMPLOYEES e INNER JOIN EMPLOYEES b ON e.boss_id = b.emp_id;

SELECT * 
FROM EMPS_AND_BOSSES
ORDER BY employee;