USE healthcare_db;

-- Insert departments
INSERT INTO departments (name) VALUES
('Cardiology'),
('Neurology'),
('Pediatrics'),
('Orthopedics');

-- Insert doctors
INSERT INTO doctors (first_name, last_name, specialty, email, department_id, available_slots) VALUES
('Alice', 'Brown', 'Cardiology', 'alice.brown@hospital.com', 1, 8),
('Bob', 'Smith', 'Neurology', 'bob.smith@hospital.com', 2, 10),
('Clara', 'Jones', 'Pediatrics', 'clara.jones@hospital.com', 3, 12),
('David', 'Lee', 'Orthopedics', 'david.lee@hospital.com', 4, 7);

-- Update departments with head doctors
UPDATE departments SET head_doctor_id = 1 WHERE department_id = 1;
UPDATE departments SET head_doctor_id = 2 WHERE department_id = 2;
UPDATE departments SET head_doctor_id = 3 WHERE department_id = 3;
UPDATE departments SET head_doctor_id = 4 WHERE department_id = 4;

-- Insert patients
INSERT INTO patients (first_name, last_name, dob, email, phone, address) VALUES
('Emma', 'Wilson', '1985-03-15', 'emma.wilson@email.com', '(123)-555-0101', '123 Maple St'),
('James', 'Taylor', '1990-07-22', 'james.taylor@email.com', '(123)-555-0102', '456 Oak Ave'),
('Sophia', 'Martinez', '2000-11-30', 'sophia.martinez@email.com', '(123)-555-0103', '789 Pine Rd');

-- Insert appointments
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status) VALUES
(1, 1, '2025-05-10 09:00:00', 'Completed'),
(2, 2, '2025-05-11 14:00:00', 'Scheduled'),
(3, 3, '2025-05-12 10:30:00', 'Scheduled'),
(4, 4, '2025-05-13 11:00:00', 'Scheduled');

-- Insert medical records
INSERT INTO medical_records (patient_id, doctor_id, visit_date, diagnosis, treatment) VALUES
(3, 3, '2025-05-12', 'Common cold', 'Rest, hydration, over-the-counter medication'),
(1, 1, '2025-04-20', 'Hypertension', 'Prescribed ACE inhibitors, lifestyle changes');

-- Insert bills
INSERT INTO bills (patient_id, appointment_id, amount, issue_date, due_date, payment_status) VALUES
(1, 1, 150.00, '2025-05-10', '2025-05-24', 'Paid'),
(2, 2, 200.00, '2025-05-11', '2025-05-25', 'Pending'),
(3, 3, 100,00, '2025-05-12', '2025-05-26', 'Pending');
