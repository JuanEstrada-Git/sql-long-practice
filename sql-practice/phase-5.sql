CREATE TABLE party_attendees (
  party_id INTEGER,
  employee_id INTEGER,
  PRIMARY KEY (party_id, employee_id),
  FOREIGN KEY (party_id) REFERENCES office_parties(id),
  FOREIGN KEY (employee_id) REFERENCES employees(id)
);

CREATE TABLE vacations (
  id INTEGER PRIMARY KEY,
  employee_id INTEGER NOT NULL,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (employee_id) REFERENCES employees(id)
);