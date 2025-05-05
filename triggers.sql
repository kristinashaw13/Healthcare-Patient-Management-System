USE healthcare_db;

-- Trigger to update doctor slots after appointment cancellation
DELIMITER //
CREATE TRIGGER after_appointment_update
AFTER UPDATE ON appointments
FOR EACH ROW
BEGIN
    IF NEW.status = 'Cancelled' AND OLD.status = 'Scheduled' THEN
        UPDATE doctors
        SET available_slots = available_slots + 1
        WHERE doctor_id = NEW.doctor_id;
    END IF;
END //
DELIMITER ;

-- Trigger to mark bills as overdue
DELIMITER //
CREATE TRIGGER before_bill_select
BEFORE SELECT ON bills
FOR EACH ROW
BEGIN
    IF NEW.payment_status = 'Pending' AND NEW.due_date < CURDATE() THEN
        SET NEW.payment_status = 'Overdue';
    END IF;
END //
DELIMITER ;

-- Test triggers by cancelling an appointment
UPDATE appointments
SET status = 'Cancelled'
WHERE appointment_id = 1;
