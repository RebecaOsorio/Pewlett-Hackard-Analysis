-- CONFIRM THAT THE TABLES ARE WELL CREATED
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM dept_manager;
SELECT * FROM salaries;
SELECT * FROM dept_employees;
SELECT * FROM titles;

--
-- QUERY DATES
--

-- SELECT THE EMPLOYEES READY FOR RETIREMENT
SELECT first_name, last_name 
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31';

-- SELECT THE EMPLOYEES BORNED IN 1952
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

-- SELECT THE EMPLOYEES BORNED IN 1953
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

-- SELECT THE EMPLOYEES BORNED IN 1954
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

-- SELECT THE EMPLOYEES BORNED IN 1955
SELECT first_name, last_name
FROM employees
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31';

-- SELECT THE EMPLOYEES ELEGIBLES FOR RETIREMENT. Employees born between 1952 and 1955, who were also hired between 1985 and 1988.
SELECT first_name, last_name
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Number of employees retiring
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- Save the employees ready for retirement into a new table
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

--
-- JOINS IN ACTION
--

-- Joining departments and dept_manager tables
SELECT departments.dept_name,
     dept_manager.emp_no,
     dept_manager.from_date,
     dept_manager.to_date
FROM departments
INNER JOIN dept_manager
ON departments.dept_no = dept_manager.dept_no;

-- Add to_date column to retirement_info table by
-- joining retirement_info and dept_emp tables
SELECT RETIREMENT_INFO.EMP_NO,
	RETIREMENT_INFO.FIRST_NAME,
	RETIREMENT_INFO.LAST_NAME,
	DEPT_EMPLOYEES.TO_DATE
FROM RETIREMENT_INFO
LEFT JOIN DEPT_EMPLOYEES ON RETIREMENT_INFO.EMP_NO = DEPT_EMPLOYEES.EMP_NO;

-- Use Aliases for the JOIN
SELECT RI.EMP_NO,
	RI.FIRST_NAME,
	RI.LAST_NAME,
	DE.TO_DATE
INTO CURRENT_EMP -- add the data into current_emp (new table)
FROM RETIREMENT_INFO AS RI
LEFT JOIN DEPT_EMPLOYEES AS DE ON RI.EMP_NO = DE.EMP_NO
WHERE de.to_date = ('9999-01-01'); -- filter eployees that continue working in PH

SELECT * FROM CURRENT_EMP;