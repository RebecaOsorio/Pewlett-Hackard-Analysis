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

-- NUMBER OF EMPLOYEES RETIRING
SELECT COUNT(first_name)
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

-- SAVE THE EMPLOYEES READY FOR RETIREMENT INTO A NEW TABLE
SELECT emp_no, first_name, last_name
INTO retirement_info
FROM employees
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;


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
SELECT retirement_info.emp_no,
	retirement_info.first_name,
	retirement_info.last_name,
	dept_employees.to_date
FROM retirement_info
LEFT JOIN dept_employees ON retirement_info.emp_no = dept_employees.emp_no;

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
