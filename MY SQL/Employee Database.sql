CREATE TABLE employee(
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20),
    birth_date DATE,
    sex VARCHAR(1),
    salary INT,
    super_id INT,
    branch_id INT
);

CREATE TABLE branch(
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(25),
    mgr_id INT,
    mrr_start_date DATE,
    FOREIGN KEY(mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

ALTER TABLE employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
    client_id INT PRIMARY KEY,
    client_name VARCHAR(25),
    branch_id INT,
    FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with(
    emp_id INT,
    client_id INT,
    total_sales INT,
    PRIMARY KEY(emp_id,client_id),
    FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
    FOREIGN KEY(client_id) REFERENCES client(client_id) ON DELETE CASCADE
);

CREATE TABLE branch_supplier(
    branch_id INT,
    supplier_name VARCHAR(25) NOT NULL,
    supply_type VARCHAR(25),
    PRIMARY KEY(branch_id,supplier_name),
    FOREIGN key(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

DESCRIBE employee;
SELECT * FROM client; 

INSERT INTO employee VALUES(100,'David','Wallace','1967-11-17','M',250000,NULL,NULL);

INSERT INTO branch VALUES(3,'Stamford',106,'1998-02-13');

UPDATE employee
SET branch_id=3
WHERE emp_id=106;

INSERT INTO employee VALUES(109,'oscar','martina','1968-02-19','M',69000,106,3);

INSERT INTO branch_supplier VALUES(3,'Stamford Lables','Custom Forms');

CREATE TABLE trigger_test(
    message VARCHAR(100)
);

DELIMITER $$
CREATE
        TRIGGER my_trigger BEFORE INSERT
        ON employee
        FOR EACH ROW BEGIN
            INSERT INTO trigger_test VALUES('added new employee');
        END$$
DELIMITER ;

SELECT * FROM trigger_test;