-- Find the names of all employees who work for First Bank Corporation  

SELECT employee_name
FROM employees
WHERE employee_name IN (SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation');

-- Find the names and cities of residence of all employees who work for First Bank Corporation

SELECT employee_name, city
FROM employees
WHERE employee_name IN (
	SELECT employee_name
	FROM works
	WHERE company_name = 'First Bank Corporation');
 
-- Find the names, street addresses, and cities of residence of all employees who work for
-- First Bank Corporation and earn more than $10,000.

SELECT employee_name, street, city
FROM employees
WHERE employee_name IN (
	SELECT employee_name
	FROM works
	WHERE company_name = 'First Bank Corporation' AND salary > 10000);

-- Find all employees in the database who live in the same cities as the companies for
-- which they work

SELECT employee_name
FROM employees
WHERE EXISTS (
	SELECT 1
    FROM works
    WHERE works.employee_name = employees.employee_name
			AND EXISTS (
				SELECT 1
                FROM companies
                WHERE companies.company_name = works.company_name
						AND employees.city = companies.city
            )
);

-- Find all employees in the database who live in the same cities and on the same streets
-- as do their managers
SELECT employee_name
FROM employees e
WHERE EXISTS (
	SELECT 1
    FROM manages
    WHERE manages.employee_name = e.employee_name
		AND EXISTS (
			SELECT 1
            FROM employees e2
            WHERE e2.employee_name = manages.manager_name
				AND e.city = e2.city
                AND e.street = e2.street
        )
);

-- Find all employees in the database who do not work for First Bank Corporation
SELECT employee_name
FROM employees
WHERE employee_name NOT IN (
	SELECT employee_name
    FROM works
    WHERE company_name  = 'First Bank Corporation'
); 

-- Find all employees in the database who earn more than each employee of Small Bank
-- Corporation

SELECT employee_name
FROM employees
WHERE EXISTS (
	SELECT 1
    FROM works
    WHERE works.salary > ALL (
		SELECT w2.salary
		FROM works w2
        WHERE w2.company_name = 'Small Bank Corporation'
    )
);

-- Assume that the companies may be located in several cities. Find all companies located
-- in every city in which Small Bank Corporation is located

SELECT company_name
FROM companies c
WHERE c.company_name <> 'Small Bank Corporation'
AND EXISTS (
	SELECT 1
    FROM companies
    WHERE company_name = 'Small Bank Corporation'
			AND city
            IN (
				SELECT city
                FROM companies
                WHERE company_name = c.company_name
                )
);

-- Find all employees who earn more than the average salary of all employees of their
-- company

SELECT salary, employee_name, company_name
FROM works
WHERE salary > (
	SELECT AVG(salary)
    FROM works w
    WHERE w.company_name = works.company_name);

-- Find the company that has the most employees

SELECT company_name, COUNT(*) as max_employee
FROM works
GROUP BY company_name
ORDER BY max_employee DESC
LIMIT 1;

-- Find the company that has the smallest payroll

SELECT MIN(salary) as min_salary, company_name
FROM works
GROUP BY company_name
ORDER BY salary
LIMIT 1;

-- Find those companies whose employees earn a higher salary, on average, than the
-- average salary at First Bank Corporation

SELECT salary, employee_name
FROM works
WHERE salary > (
	SELECT AVG(SALARY)
    FROM works w2
    WHERE w2.company_name = 'First Bank Corporation'
    );
    
-- Modify the database so that Jones now lives in Newtown

UPDATE employees
SET city = 'Newtown'
WHERE employee_name LIKE('Jones%');

-- Give all employees of First Bank Corporation a 10 percent raise
UPDATE works
SET salary = salary + (salary * 0.1) 
WHERE company_name = 'First Bank Corporation';

-- Give all managers of First Bank Corporation a 10 percent raise
UPDATE works, manages
SET salary = salary + (salary * 0.1)
WHERE works.employee_name = manages.employee_name AND works.company_name = 'First Bank Corporation';

-- Give all managers of First Bank Corporation a 10 percent raise
-- unless the salary becomes greater than $100,000; in such cases, give only a 3 percent raise.
UPDATE works, manages
SET salary = 
    CASE 
        WHEN salary * 1.1 <= 100000 THEN salary * 1.1 
        ELSE salary * 1.03 
    END
WHERE works.employee_name = manages.employee_name
		AND works.company_name = 'First Bank Corporation';
        
-- Delete all tuples in the works relation for employees of Small Bank Corporation 
DELETE employees, manages
FROM works
LEFT JOIN employees ON employees.employee_name = works.employee_name
LEFT JOIN manages ON manages.manager_name = works.employee_name
WHERE works.company_name = 'First Bank Corporation';