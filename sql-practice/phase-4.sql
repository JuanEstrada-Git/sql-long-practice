-- =========================
-- PHASE 4 — THE OFFICE
-- =========================

DROP TABLE IF EXISTS relationships;
DROP TABLE IF EXISTS performance_reviews;
DROP TABLE IF EXISTS office_parties;
DROP TABLE IF EXISTS employees;

-- -------------------------
-- Employees
-- -------------------------
CREATE TABLE employees (
  id INTEGER PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  department TEXT NOT NULL,
  role TEXT NOT NULL
);

-- -------------------------
-- Romantic Relationships
-- -------------------------
CREATE TABLE relationships (
  id INTEGER PRIMARY KEY,
  employee_1_id INTEGER NOT NULL,
  employee_2_id INTEGER NOT NULL,
  started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  ended_at TIMESTAMP,
  FOREIGN KEY (employee_1_id) REFERENCES employees(id),
  FOREIGN KEY (employee_2_id) REFERENCES employees(id)
);

-- -------------------------
-- Performance Reviews
-- -------------------------
CREATE TABLE performance_reviews (
  id INTEGER PRIMARY KEY,
  employee_id INTEGER NOT NULL,
  score REAL NOT NULL CHECK (score >= 0 AND score <= 10),
  reviewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (employee_id) REFERENCES employees(id)
);

-- -------------------------
-- Office Parties
-- -------------------------
CREATE TABLE office_parties (
  id INTEGER PRIMARY KEY,
  location_type TEXT NOT NULL CHECK (location_type IN ('onsite', 'offsite')),
  budget REAL NOT NULL,
  scheduled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  canceled INTEGER DEFAULT 0
);

-- =========================
-- EVENTS
-- =========================

-- Employees added
INSERT INTO employees (first_name, last_name, department, role)
VALUES
('Michael', 'Scott', 'Management', 'Regional Manager'),
('Dwight', 'Schrute', 'Sales', 'Assistant Regional Manager'),
('Jim', 'Halpert', 'Sales', 'Sales Representative'),
('Pam', 'Beesly', 'Reception', 'Receptionist'),
('Kelly', 'Kapoor', 'Product Oversight', 'Customer Service Representative'),
('Angela', 'Martin', 'Accounting', 'Head of Accounting'),
('Roy', 'Anderson', 'Warehouse', 'Warehouse Staff');

-- Roy + Pam relationship
INSERT INTO relationships (employee_1_id, employee_2_id)
SELECT e1.id, e2.id
FROM employees e1, employees e2
WHERE e1.last_name = 'Anderson' AND e2.last_name = 'Beesly';

-- Ryan hired
INSERT INTO employees (first_name, last_name, department, role)
VALUES ('Ryan', 'Howard', 'Reception', 'Temp');

-- Office party #1
INSERT INTO office_parties (location_type, budget)
VALUES ('onsite', 100);

-- Performance reviews
INSERT INTO performance_reviews (employee_id, score)
SELECT id, 3.3 FROM employees WHERE last_name = 'Schrute';

INSERT INTO performance_reviews (employee_id, score)
SELECT id, 4.2 FROM employees WHERE last_name = 'Halpert';

-- Update reviews
UPDATE performance_reviews
SET score = 9.0
WHERE employee_id = (SELECT id FROM employees WHERE last_name = 'Schrute');

UPDATE performance_reviews
SET score = 9.3
WHERE employee_id = (SELECT id FROM employees WHERE last_name = 'Halpert');

-- Promotions
UPDATE employees
SET role = 'Assistant Regional Manager'
WHERE last_name = 'Halpert';

UPDATE employees
SET department = 'Sales', role = 'Sales Representative'
WHERE last_name = 'Howard';

-- Office party #2
INSERT INTO office_parties (location_type, budget)
VALUES ('onsite', 200);

-- Angela + Dwight relationship
INSERT INTO relationships (employee_1_id, employee_2_id)
SELECT e1.id, e2.id
FROM employees e1, employees e2
WHERE e1.last_name = 'Martin' AND e2.last_name = 'Schrute';

-- Angela review
INSERT INTO performance_reviews (employee_id, score)
SELECT id, 6.2 FROM employees WHERE last_name = 'Martin';

-- Ryan + Kelly relationship
INSERT INTO relationships (employee_1_id, employee_2_id)
SELECT e1.id, e2.id
FROM employees e1, employees e2
WHERE e1.last_name = 'Howard' AND e2.last_name = 'Kapoor';

-- Office party #3
INSERT INTO office_parties (location_type, budget)
VALUES ('onsite', 50);

-- Jim leaves office
DELETE FROM relationships
WHERE employee_1_id = (SELECT id FROM employees WHERE last_name = 'Halpert')
   OR employee_2_id = (SELECT id FROM employees WHERE last_name = 'Halpert');

DELETE FROM performance_reviews
WHERE employee_id = (SELECT id FROM employees WHERE last_name = 'Halpert');

DELETE FROM employees WHERE last_name = 'Halpert';

-- Roy + Pam breakup
UPDATE relationships
SET ended_at = CURRENT_TIMESTAMP
WHERE ended_at IS NULL;

-- Pam review
INSERT INTO performance_reviews (employee_id, score)
SELECT id, 7.6 FROM employees WHERE last_name = 'Beesly';

-- Dwight review
INSERT INTO performance_reviews (employee_id, score)
SELECT id, 8.7 FROM employees WHERE last_name = 'Schrute';

-- Ryan quits
DELETE FROM relationships
WHERE employee_1_id = (SELECT id FROM employees WHERE last_name = 'Howard')
   OR employee_2_id = (SELECT id FROM employees WHERE last_name = 'Howard');

DELETE FROM performance_reviews
WHERE employee_id = (SELECT id FROM employees WHERE last_name = 'Howard');

DELETE FROM employees WHERE last_name = 'Howard';

-- Jim returns
INSERT INTO employees (first_name, last_name, department, role)
VALUES ('Jim', 'Halpert', 'Sales', 'Sales Representative');

-- Karen joins
INSERT INTO employees (first_name, last_name, department, role)
VALUES ('Karen', 'Filippelli', 'Sales', 'Sales Representative');

-- Karen + Jim relationship
INSERT INTO relationships (employee_1_id, employee_2_id)
SELECT e1.id, e2.id
FROM employees e1, employees e2
WHERE e1.last_name = 'Filippelli' AND e2.last_name = 'Halpert';

-- Office party #4
INSERT INTO office_parties (location_type, budget)
VALUES ('onsite', 120);

-- Cancel previous party + add offsite party
UPDATE office_parties
SET canceled = 1
WHERE id = (SELECT MAX(id) - 1 FROM office_parties);

INSERT INTO office_parties (location_type, budget)
VALUES ('offsite', 300);

-- Karen + Jim breakup
UPDATE relationships
SET ended_at = CURRENT_TIMESTAMP
WHERE ended_at IS NULL;

-- Pam + Jim relationship
INSERT INTO relationships (employee_1_id, employee_2_id)
SELECT e1.id, e2.id
FROM employees e1, employees e2
WHERE e1.last_name = 'Beesly' AND e2.last_name = 'Halpert';