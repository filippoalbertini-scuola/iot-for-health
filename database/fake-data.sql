-- =========================================
-- 1. Insert into patients
-- =========================================
INSERT INTO patients (
    surname, 
    name, 
    password, 
    phone_number, 
    username, 
    birth_city, 
    email
)
VALUES
('Doe', 'John', 'password123', '555-1234', 'johndoe', 'New York', 'john.doe@example.com'),
('Smith', 'Jane', 'secretpass', '555-5678', 'janesmith', 'Los Angeles', 'jane.smith@example.com');

-- =========================================
-- 2. Insert into clinicians
-- =========================================
INSERT INTO clinicians (
    surname, 
    name, 
    password, 
    phone_number, 
    username, 
    birth_date, 
    email
)
VALUES
('Brown', 'Alice', 'pass123', '555-9999', 'alicebrown', '1975-06-15', 'alice.brown@clinic.org'),
('Green', 'Bob', 'mysecurepass', '555-8888', 'bobgreen', '1980-09-20', 'bob.green@clinic.org');


-- =========================================
-- 3. Insert into parameters
-- =========================================
INSERT INTO parameters (
	timestamp,
    patient_id, 
    step_length, 
    frequency, 
    freeze_index, 
    energy
)
VALUES
('2023-01-01 10:00:00',1, 1.5, 2.0, 0.5, 10.0),  
('2023-01-02 11:00:00',2, 2.0, 2.5, 0.4, 12.0), 
('2023-01-03 12:00:00',1, 1.8, 2.8, 0.3, 14.0),  
('2023-01-04 13:00:00',2, 2.2, 2.9, 0.1, 16.0);  

-- =========================================
-- 4. Insert into freezings
-- =========================================
INSERT INTO freezings (
    parameter_id, 
    freeze_ts, 
    duration
)
VALUES
(1, '2023-01-01 10:00:00', '00:00:30'),
(2, '2023-01-02 11:00:00', '00:00:40');

-- =========================================
-- 5. Insert into drugs
-- =========================================
INSERT INTO drugs (
    company, 
    type, 
    dosage
)
VALUES
('PharmaCorp', 'Antidepressant', '20mg'),
('MediHealth', 'Antiparkinsonian', '50mg'),
('WellnessInc', 'Analgesic', '10mg');

-- =========================================
-- 6. Insert into pharmacological_therapies
--    (links patients, clinicians and drugs)
-- =========================================
--   assistances:  ID=1 (patient=1,clinician=1), ID=2 (patient=2,clinician=2)
--   drugs:        ID=1,2,3
INSERT INTO pharmacological_therapies (
    patient_id, 
    clinician_id,
    drug_id
)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 1, 3);

-- =========================================
-- 7. Insert into motor_exercises
-- =========================================
INSERT INTO motor_exercises (
    description, 
    type
)
VALUES
('Treadmill walking', 'Aerobic'),
('Arm stretching', 'Flexibility'),
('Balance board', 'Balance');

-- =========================================
-- 8. Insert into rehabilitation_therapies
--     (links patients, clinicians and motor_exercises)
-- =========================================
--   assistances:       ID=1,2
--   motor_exercises:   ID=1,2,3
INSERT INTO rehabilitation_therapies (
    patient_id, 
    clinician_id,
    exercise_id
)
VALUES
(1, 1, 1),
(1, 2, 2),
(2, 1, 3);
