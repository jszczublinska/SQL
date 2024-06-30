--1 
CREATE TABLE Projects (
    project_id integer GENERATED ALWAYS AS IDENTITY,
    project_name character varying(200),
    description character varying (1000),
    start_date date DEFAULT CURRENT_DATE,
    end_date date,
    budget numeric (10,2)
);

--2
INSERT INTO Projects(project_name, description, start_date, end_date, budget)
VALUES('New Technologies Survey','A project aimed at reviewing the area of advanced database technologies.',DATE '2018-01-01', NULL, 1500000 );
INSERT INTO Projects(project_name, description, start_date, end_date, budget)
VALUES('Advanced Data Analysis', 'Analyzing data obtained from various organizations', DATE '2017-09-20', DATE '2018-10-01', 2750000);

SELECT *
FROM PROJECTS;

--3
INSERT INTO Projects(project_id, project_name, description, start_date, end_date, budget)
VALUES(55,'Creating backbone network', 'Expanding the organizations network infrastructure', DATE '2019-06-01', DATE '2020-05-31', 5000000);
-- I have not succeed, because 'project_id' column is generated as identity column

--4
INSERT INTO Projects(project_name, description, start_date, end_date, budget)
VALUES('Creating backbone network', 'Expanding the organization''s network infrastructure', DATE '2019-06-01', DATE '2020-05-31', 5000000);

SELECT project_id, project_name
FROM PROJECTS
ORDER BY PROJECT_ID;

--5
UPDATE PROJECTS
SET PROJECT_ID = 100
WHERE PROJECT_NAME LIKE 'Creating backbone network';
-- i have not succeed, the same reason like in exercise 3

--6
CREATE TABLE Projects_Copy AS 
    SELECT *
    FROM Projects;

SELECT *
FROM Projects_Copy;

--7
INSERT INTO Projects_Copy(project_id, project_name, description, start_date, end_date, budget)
VALUES(100, 'Creating mobile network', 'Expanding the organization''s network infrastructure-part2', DATE '2020-06-01', DATE '2021-05-31', 4000000);

--It works now because 'project_id' column is not generated as identity column in this case

--8
DELETE FROM PROJECTS_COPY
WHERE PROJECT_NAME LIKE 'Creating backbone network';

SELECT *
FROM Projects_Copy;

--9
ALTER TABLE Projects
ADD number_of_emp number(3)
MODIFY description varchar(1500);

--10
SELECT MAX(length(project_name))
FROM Projects;

ALTER TABLE Projects
MODIFY project_name varchar(25);
-- Yes

--11
ALTER TABLE Projects
RENAME COLUMN budget TO project_budget;

--12
DROP TABLE Projects_Copy;