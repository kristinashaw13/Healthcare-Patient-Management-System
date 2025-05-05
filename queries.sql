USE healthcare_db;

-- Find upcoming appointments
SELECT a.appointment_id, p.first_name AS patient, d.first_name AS doctor, a.appointment_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
WHERE a.appointment_date > CURDATE() AND a.status = 'Scheduled'
ORDER BY a.appointment_date;

-- Lists patients with multiple visits
SELECT p.first_name, p.last_name, COUNT(m.record_id) AS visit_count
FROM patients p
JOIN medical_records m ON p.patient_id = m.patient_id
GROUP BY p.patient_id
HAVING visit_count > 1;

-- Identify overdue bills
SELECT b.bill_id, p.first_name, p.last_name, b.amount, b.due_date
FROM bills b
JOIN patients p ON b.patient_id = p.patient_id
WHERE b.payment_status = 'Pending' AND b.due_date < CURDATE();

-- Department workload (appointments per department)
SELECT d.name, COUNT(a.appointment_id) AS appointment_count
FROM departments d
JOIN doctors dc ON d.department_id = dc.department_id
LEFT JOIN appointments a ON dc.doctor_id = a.doctor_id
GROUP BY d.department_id
ORDER BY appointment_count DESC;

-- Doctor availability
SELECT first_name, last_name, specialty, available_slots
FROM doctors
WHERE available_slots > 0
ORDER BY available_slots DESC;
