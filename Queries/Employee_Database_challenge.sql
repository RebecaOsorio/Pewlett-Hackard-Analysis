------------------------------------------------------------------------------------------
-- Deliverable 1: The Number of Retiring Employees by Title
-- Get the titles for employees who were born between 1952 and 1955.
SELECT em.emp_no, em.first_name, em.last_name, tt.title, tt.from_date, tt.to_date
INTO retirement_titles
FROM employees AS em
LEFT JOIN titles AS tt ON em.emp_no = tt.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY em.emp_no;

-- Get the latest title for each employee
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Retrieve the number of titles
SELECT COUNT(emp_no) emp_count,title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY emp_count DESC;

------------------
-- ADDITIONAL QUERIES

-- Count retiring_titles
SELECT COUNT(title) FROM retiring_titles;
-- Sum emp_count
SELECT SUM(emp_count)
FROM retiring_titles;

-- Re-do UNIQUE_TITLES table
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title,
to_date
INTO current_unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01' -- Only take the current employees
ORDER BY emp_no, to_date DESC;

-- Retrieve the current number of titles
SELECT COUNT(emp_no) emp_count,title
INTO current_retiring_titles
FROM current_unique_titles
GROUP BY title
ORDER BY emp_count DESC;

-- Count current_retiring_titles
SELECT COUNT(title) FROM current_retiring_titles;

-- Sum emp_count
SELECT SUM(emp_count)
FROM current_retiring_titles;
------------------------------------------------------------------------------------
-- Deliverable 2: The Employees Eligible for the Mentorship Program
SELECT DISTINCT ON (em.emp_no) em.emp_no, em.first_name, em.last_name, em.birth_date, de.from_date, de.to_date, tt.title
INTO mentorship_elegibilty
FROM employees AS em
INNER JOIN dept_employees AS de ON em.emp_no = de.emp_no
INNER JOIN titles As tt ON em.emp_no = tt.emp_no
WHERE (em.birth_date BETWEEN '1965-01-01' AND '19655-12-31')
	AND (de.to_date = '9999-01-01')
ORDER BY em.emp_no, de.to_date DESC;

------------------
-- ADDITIONAL QUERIES
SELECT * FROM mentorship_elegibilty;

-- Retrieve the current number of titles of employees eligible for the mentorship program
SELECT COUNT(emp_no) emp_count,title
-- INTO mentorship_titles
FROM mentorship_elegibilty
GROUP BY title
ORDER BY emp_count DESC;

-- Count mentorship_titles
SELECT COUNT(title) FROM mentorship_titles;

-- Sum emp_count
SELECT SUM(emp_count)
FROM mentorship_titles;

------------------------------------------------------------------------------------
-- SUPPORT AREA

-- SUMMARY. Question 2
-- Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

-- Create a similar ´unique_titles´ table in which we also take the last department where the employee worked. 
SELECT DISTINCT ON (rt.emp_no) rt.emp_no, rt.title, rt.to_date title_todate, de.dept_no, de.to_date dept_todate
INTO unique_titles_and_depts
FROM retirement_titles AS rt
INNER JOIN dept_employees AS de ON rt.emp_no = de.emp_no
ORDER BY rt.emp_no, title_todate DESC, dept_todate DESC;

-- Last Title and Department reported for each Employee
SELECT utd.emp_no, utd.title, departments.dept_name
INTO prep_retiring_titles_depts
FROM unique_titles_and_depts AS utd
INNER JOIN departments ON utd.dept_no = departments.dept_no;

-- Determine the number of retiring employees per title, and department
SELECT COUNT(emp_no) emp_count, title,dept_name
INTO retiring_titles_dept
FROM prep_retiring_titles_depts
GROUP BY title, dept_name
ORDER BY dept_name, emp_count DESC;

-- Determine the number of employees elegibles for the mentorship per title and department
SELECT * FROM mentorship_elegibilty;

-- Mentorship Elegible Employees. DEPARTMENT RELATION
SELECT me.emp_no, me.first_name,me.last_name,me.title,de.dept_no,departments.dept_name,de.to_date dept_todate
INTO mentorship_unique_titles_depts
FROM mentorship_elegibilty AS me
INNER JOIN dept_employees AS de ON me.emp_no = de.emp_no
INNER JOIN departments ON de.dept_no = departments.dept_no
WHERE de.to_date = '9999-01-01'

-- Final Table with the number of employees eligible for mentorship per title, and department
SELECT COUNT(emp_no) emp_count, title,dept_name
INTO mentorship_titles_dept
FROM mentorship_unique_titles_depts
GROUP BY title, dept_name
ORDER BY dept_name, emp_count DESC;

-- Comparition between retirement-ready employees and 
-- employees elegibles for the mentorship
SELECT mtd.emp_count mentorship_emp_count,
rtd.emp_count retirement_emp_count,
mtd.title,
mtd.dept_name
FROM mentorship_titles_dept AS mtd 
LEFT JOIN retiring_titles_dept AS rtd
	ON  rtd.title = mtd.title and 
		rtd.dept_name = mtd.dept_name;

-------------------------------------------
-- Get the % of employees ready for the retirement
SELECT SUM(count) FROM retiring_titles;
SELECT COUNT(emp_no) FROM employees;


-- Get the Distribution of Promotions
-- From the retirement-ready-employees
SELECT COUNT(title) no_titles, emp_no -- run one time
INTO number_titles_retemp
FROM retirement_titles 
GROUP BY emp_no;

-- Results
SELECT no_titles-1 promotions, COUNT(emp_no) 
FROM no_titles 
GROUP BY no_titles 
ORDER BY no_titles;


-- Find if the employees are in more than 1 departments
SELECT COUNT(emp_no), emp_no
FROM dept_employees
GROUP BY emp_no
ORDER BY count DESC;

-- Are the employees working in 2 departments at the same time?
SELECT *
FROM dept_employees
WHERE emp_no = '22614'; -- No
SELECT *
FROM dept_employees
WHERE emp_no = '17551'; -- No
SELECT *
FROM dept_employees
WHERE emp_no = '249418'; -- No