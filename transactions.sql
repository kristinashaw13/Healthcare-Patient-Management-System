USE healthcare_db;

-- Transaction for booking an appointment and generating a bill
START TRANSACTION;

SET @patient_id = 3;
SET @doctor_id = 4;
SET @appointment_date = '2025-05-15 09:30:00';
SET @amount = 180.00;

-- Book appointment
INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
VALUES (@patient_id, @doctor_id, @appointment_date, 'Scheduled');

-- Update doctor slots
UPDATE doctors
SET available_slots = available_slots - 1
WHERE doctor_id = @doctor_id;

-- Get a new appointment ID
SET @appointment_id = LAST_INSERT_ID();

-- Generate the bill
INSERT INTO bills (patient_id, appointment_id, amount, issue_date, due_date, payment_status)
VALUES (@patient_id, @appointment_id, @amount, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Pending');

COMMIT;

-- Verify the transaction
SELECT * FROM appointments WHERE appointment_id = @appointment_id;
SELECT * FROM bills WHERE appointment_id = @appointment_id;
