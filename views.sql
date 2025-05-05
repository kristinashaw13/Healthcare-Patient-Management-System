USE healthcare_db;

-- View for patient summaries
CREATE VIEW patient_summary AS
SELECT p.patient_id, p.first_name, p.last_name, p.email, COUNT(a.appointment_id) AS total_appointments, SUM(b.amount) AS total_billed
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id
LEFT JOIN bills b ON p.patient_id = b.patient_id
GROUP BY p.patient_id;

-- View for department workload
CREATE VIEW department_workload AS
SELECT d.name, COUNT(a.appointment_id) AS appointments, COUNT(DISTINCT dc.doctor_id) AS doctors
FROM departments d
JOIN doctors dc ON d.department_id = dc.department_id
LEFT JOIN appointments a ON dc.doctor_id = a.doctor_id
GROUP BY d.department_id;

-- Test views
SELECT * FROM patient_summary;
SELECT * FROM department_workload;
