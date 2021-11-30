-- CONFIRM THAT THE TABLES ARE WELL CREATED
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_employees;
SELECT * FROM titles;


---------------------------
-- QUERY DATES

-- SELECT THE EMPLOYEES BORNED IN 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';


---------------------------
-- FILTER DATA

-- SELECT THE EMPLOYEES ELEGIBLES FOR RETIREMENT. Employees born between 1952 and 1955, who were also hired between 1985 and 1988.
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- NUMBER OF EMPLOYEES RETIRING
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


----------------------------
-- CREATE A TABLE OF EMPLOYEES READY FOR RETIREMENT

-- SAVE THE EMPLOYEES READY FOR RETIREMENT INTO A NEW TABLE
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;


----------------------------
-- JOINS IN ACTION

-- JOINING departments AND dept_manager TABLES
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- ADD to_date COLUMN to retirement_info table by
-- joining retirement_info and dept_emp tables
-- USE ALIASES FOR THE JOIN
SELECT ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
INTO current_emp -- add the data into current_emp (new table)
FROM retirement_info AS ri
LEFT JOIN dept_employees AS de ON ri.emp_no = de.emp_no
WHERE de.to_date = ('9999-01-01'); -- filter eployees that continue working in PH

SELECT * FROM current_emp;


--- USE COUNT, GROUP BY, AND ORDER BY
-- Employee count by department number
SELECT COUNT(ce.emp_no), de.dept_no
INTO count_dept
FROM current_emp as ce
LEFT JOIN dept_employees as de
ON ce.emp_no = de.emp_no
GROUP BY de.dept_no
ORDER BY de.dept_no;

SELECT * FROM count_dept;


------------------------------------------
-- LIST 1: EMPLOYEE INFORMATION

-- METHOD. USE CURRENT_EMPLOYE TABLE (employees ready for retirement) AND JOIN THE SALARY
SELECT ce.emp_no, ce.last_name, ce.first_name, em.gender, sal.salary
FROM current_emp as ce
INNER JOIN employees as em ON em.emp_no = ce.emp_no
INNER JOIN salaries as sal ON em.emp_no = sal.emp_no;

-- METHOD. CREATE A NEW TABLE, FILTER AND JOIN THE SALARIES
SELECT e.emp_no,
    e.first_name,
		e.last_name,
    e.gender,
    s.salary,
    de.to_date
INTO emp_info -- save the new data in the new table
FROM employees as e
INNER JOIN salaries as s ON (e.emp_no = s.emp_no)
INNER JOIN dept_employees as de ON (e.emp_no = de.emp_no) -- add to_date
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
	AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	AND (de.to_date = '9999-01-01'); -- filter by the to_date, to ensure current workers
	

------------------------------------------
-- LIST 2: MANAGMENT
SELECT mg.dept_no,
	d.dept_name,
	mg.emp_no,
	em.last_name,
	em.first_name,
	mg.from_date,
	mg.to_date
INTO manager_info
FROM dept_manager as mg
INNER JOIN departments AS d ON mg.dept_no=d.dept_no
INNER JOIN employees AS em ON mg.emp_no=em.emp_no;
	

------------------------------------------
-- LIST 3:
SELECT ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
INTO dept_info
FROM current_emp as ce
INNER JOIN dept_employees AS de
ON (ce.emp_no = de.emp_no)
INNER JOIN departments AS d
ON (de.dept_no = d.dept_no)
ORDER BY ce.first_name,ce.last_name;


---------------------------------
-- RETIREMENT INFORMATION TAILORED FOR THE SALES
SELECT di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
FROM dept_info AS di
WHERE di.dept_name='Sales';


---------------------------------
-- RETIREMENT INFORMATION TAILORED BOTH SALES AND DEVELOPMENT
SELECT di.emp_no,
	di.first_name,
	di.last_name,
	di.dept_name
FROM dept_info AS di
WHERE dept_name IN ('Sales','Development');