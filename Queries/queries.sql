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

-- Save the employees ready for retirement into a new table & add the Employee ID
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;