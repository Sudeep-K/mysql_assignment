-- 4.1 Finds the names of all instructors in the History department
USE university;

SELECT instructor_name
FROM instructor
JOIN department
	ON department.department_name = instructor.department_name
WHERE instructor.department_name = 'History';

-- 4.2 Finds the instructor ID and department name of all instructors
-- associated with a department with budget of greater than $95,000

SELECT instructor_id, instructor.department_name
FROM instructor
JOIN department
	ON department.department_name = instructor.department_name
WHERE department.budget > 95000;

-- 4.3 Finds the names of all instructors in the Comp. Sci. department together with the
-- course titles of all the courses that the instructors teach

SELECT instructor.instructor_name, course.course_title
FROM teaches
JOIN course
	ON teaches.course_id = course.course_id
JOIN instructor
	ON teaches.instructor_id = instructor.instructor_id
WHERE course.department_name = 'Computer Science';

-- 4.4 Find the names of all students who have taken the course title of “Game Design”

-- 4.5 For each department, find the maximum salary of instructors in that department. You
-- may assume that every department has at least one instructor.

SELECT department_name, MAX(salary)
FROM instructor
GROUP BY department_name;

-- Find the lowest, across all departments, of the per-department maximum salary
-- computed by the preceding query

SELECT department_name, salary
FROM instructor
WHERE salary
	IN (
		SELECT MAX(salary)
		FROM instructor
		GROUP BY department_name
	)
ORDER BY salary
LIMIT 1;

-- Find the ID and names of all students who do not have an advisor
