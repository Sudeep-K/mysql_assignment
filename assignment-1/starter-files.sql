USE employee;

CREATE TABLE employees (
    employee_name VARCHAR(255) PRIMARY KEY,
    street VARCHAR(255),
    city VARCHAR(255)
);

CREATE TABLE works (
    employee_name VARCHAR(255) PRIMARY KEY,
    company_name VARCHAR(255),
    salary INT,
    FOREIGN KEY (employee_name) REFERENCES employees(employee_name)
);

CREATE TABLE companies (
    company_name VARCHAR(255) PRIMARY KEY,
    city VARCHAR(255)
);

CREATE TABLE manages (
    employee_name VARCHAR(255) PRIMARY KEY,
    manager_name VARCHAR(255),
    FOREIGN KEY (employee_name) REFERENCES employees(employee_name),
    FOREIGN KEY (manager_name) REFERENCES employees(employee_name)
);


INSERT INTO employees (employee_name, street, city)
VALUES ('John Smith', '123 Main St', 'New York'),
       ('Jane Doe', '456 Market St', 'Chicago'),
       ('Bob Johnson', '789 Park Ave', 'New York'),
       ('Alice Williams', '321 Maple St', 'Chicago');
       
INSERT INTO works (employee_name, company_name, salary)
VALUES ('John Smith', 'First Bank Corporation', 75000),
       ('Jane Doe', 'First Bank Corporation', 80000),
       ('Bob Johnson', 'Second National Bank', 90000),
       ('Alice Williams', 'Chicago Financial Group', 65000);
       
INSERT INTO companies (company_name, city)
VALUES ('First Bank Corporation', 'New York'),
       ('Second National Bank', 'New York'),
       ('Chicago Financial Group', 'Chicago');
       
INSERT INTO manages (employee_name, manager_name)
VALUES ('John Smith', 'Jane Doe'),
       ('Bob Johnson', 'Jane Doe'),
       ('Alice Williams', 'John Smith');