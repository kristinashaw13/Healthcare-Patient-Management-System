USE healthcare_db;

-- Procedure to book an appointment
DELIMITER//
CREATE PROCEDURE BookAppointment (
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_appointment_date DATETIME
)
BEGIN
    DECLARE doctor_slots INT;

    -- Check doctor availability
    SELECT available_slots INTO doctor_slots
    FROM doctors
    WHERE doctor_id = p_doctor_id;

    IF foctor_slots > 0 THEN
        -- Insert appointment
        INSERT INTO appointments (patient_id, doctor_id, appointment_date, status)
        VALUES (p_patient_id, p_doctor_id, p_appointment_date, 'Scheduled');

        -- Decrease available slots
        UPDATE doctors
        SET available_slots = available_slots - 1
        WHERE doctor_id = p_doctor_id;

        SELECT 'Appointment booked successfully!' AS message;
    ELSE
        SIGNAM SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No available slots for this doctor.';
    END IF;
END//
DELIMITER ;

-- Procedure to generate a bill
DELIMITER //
CREATE PROCEDURE GenerateBill (
    IN p_appointment_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_patient_id INT;

    -- Get the patient ID from the appointment
    SELECT patient_id INTO v_patient_id
    FROM appointments
    WHERE appointment_id = p_appointment_id;

    -- Insert bill
    INSERT INTO bills (patient_id, appointment_id, amount, issue_date, due_date, payment_status)
    VALUES (v_patient_id, p_appointment_id, p_amount, CURDATE(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 'Pending');

    SELECT 'Bill generated successfully!' AS message;
END //
DELIMITER ;

-- Test procedures
CALL BookAppointment(2, 3, '2025-05-14 15:00:00');
CALL GenerateBill(4, 175.00);
