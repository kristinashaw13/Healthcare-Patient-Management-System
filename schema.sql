CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;

-- Table for departments
CREATE TABLE departments (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    head_doctor_id INT,
    UNIQUE (name)
);

-- Table for doctors
CREATE TABLE doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty ENUM('Cardiology', 'Neurology', 'Pediatrics', 'Orthopedics', 'General') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department_id INT,
    available_slots INT DEFAULT 10 CHECK (available_slots >= 0),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Table for patients
CREATE TABLE patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- Table for appointments
CREATE TABLE appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled' 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    UNIQUE (doctor_id, appointment_date)
);

-- Table for patient medical records
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    visit_date DATE NOT NULL,
    diagnosis TEXT NOT NULL,
    treatment TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Table for patient bills
CREATE TABLE bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    payment_status ENUM('Pending', 'Paid', 'Overdue') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- Updates departments table to reference head_doctor_id (after the doctors table exists)
ALTER TABLE departments
ADD CONSTRAINT fk_head_doctor
FOREIGN KEY (head_doctor_id) REFERENCE doctors(doctor_id);

-- Indexes for better performance
CREATE INDEX idx_patient_email ON patients(email);
CREATE INDEX idx_doctor_email ON doctors(email);
CREATE INDEX idx_appointment_date ON appointments(appointment_date);
