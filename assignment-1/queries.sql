-- 2a
SELECT employee_name
FROM employees
WHERE employee_name IN (SELECT employee_name
FROM works
WHERE company_name = 'First Bank Corporation');

-- 2b
SELECT employee_name, city
FROM employees
WHERE employee_name IN (
	SELECT employee_name
	FROM works
	WHERE company_name = 'First Bank Corporation');
 
-- 2c
SELECT employee_name, street, city
FROM employees
WHERE employee_name IN (
	SELECT employee_name
	FROM works
	WHERE company_name = 'First Bank Corporation' AND salary > 10000);

-- 2d
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

-- 2e
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

-- 2f
SELECT employee_name
FROM employees
WHERE employee_name NOT IN (
	SELECT employee_name
    FROM works
    WHERE company_name  = 'First Bank Corporation'
); 

-- 2g
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

-- 2h
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

-- 2i
SELECT salary, employee_name, company_name
FROM works
WHERE salary > (
	SELECT AVG(salary)
    FROM works w
    WHERE w.company_name = works.company_name);

-- 2j
SELECT company_name, COUNT(*) as max_employee
FROM works
GROUP BY company_name
ORDER BY max_employee DESC
LIMIT 1;

-- 2k
SELECT MIN(salary) as min_salary, company_name
FROM works
GROUP BY company_name
LIMIT 1;

-- 2l
SELECT salary, employee_name
FROM works
WHERE salary > (
	SELECT AVG(SALARY)
    FROM works w2
    WHERE w2.company_name = 'First Bank Corporation'
    );
    
-- 3a
UPDATE employees
SET city = 'Newtown'
WHERE employee_name LIKE('Jones%');

-- 3b
UPDATE works
SET salary = salary + (salary * 0.1) 
WHERE company_name = 'First Bank Corporation';

-- 3c
UPDATE works, manages
SET salary = salary + (salary * 0.1)
WHERE works.employee_name = manages.employee_name AND works.company_name = 'First Bank Corporation';

-- 3d
UPDATE works, manages
SET salary = 
    CASE 
        WHEN salary * 1.1 <= 100000 THEN salary * 1.1 
        ELSE salary * 1.03 
    END
WHERE works.employee_name = manages.employee_name
		AND works.company_name = 'First Bank Corporation';
        
-- 3e 
DELETE employees, manages
FROM works
LEFT JOIN employees ON employees.employee_name = works.employee_name
LEFT JOIN manages ON manages.manager_name = works.employee_name
WHERE works.company_name = 'First Bank Corporation';