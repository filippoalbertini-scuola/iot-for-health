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
-- 3. Insert into episodes
--    (We'll rely on default values for the primary key)
-- =========================================
INSERT INTO episodes
DEFAULT VALUES;  -- 1st episode (ID = 1)
INSERT INTO episodes
DEFAULT VALUES;  -- 2nd episode (ID = 2)

-- =========================================
-- 4. Insert into parameters
--    (1:1 relationship with episodes)
-- =========================================
INSERT INTO parameters (
    episode_id, 
    step_length, 
    frequency, 
    freeze_index, 
    energy
)
VALUES
(1, 1.5, 2.0, 0.5, 10.0),  -- parameters for episode_id=1
(2, 2.0, 2.5, 0.4, 12.0);  -- parameters for episode_id=2

-- =========================================
-- 5. Insert into freezings
--    (references episodes)
-- =========================================
INSERT INTO freezings (
    episode_id, 
    freeze_ts, 
    duration
)
VALUES
(1, '2023-01-01 10:00:00', '00:00:30'),
(1, '2023-01-01 10:05:00', '00:00:20'),
(2, '2023-01-02 11:00:00', '00:00:40');

-- =========================================
-- 6. Insert into monitorings
--    (links patients and episodes)
-- =========================================
--   patients:   ID=1 (John Doe),   ID=2 (Jane Smith)
--   episodes:   ID=1,              ID=2
INSERT INTO monitorings (
    patient_id, 
    episode_id, 
    flag_therapy
)
VALUES
(1, 1, TRUE),
(1, 2, FALSE),
(2, 1, TRUE);

-- =========================================
-- 7. Insert into assistances
--    (links patients and clinicians)
-- =========================================
--   patients:   ID=1 (John Doe),   ID=2 (Jane Smith)
--   clinicians: ID=1 (Alice Brown),ID=2 (Bob Green)
INSERT INTO assistances (
    patient_id, 
    clinician_id
)
VALUES
(1, 1),
(2, 2);

-- =========================================
-- 8. Insert into drugs
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
-- 9. Insert into pharmacological_therapies
--    (links assistances and drugs)
-- =========================================
--   assistances:  ID=1 (patient=1,clinician=1), ID=2 (patient=2,clinician=2)
--   drugs:        ID=1,2,3
INSERT INTO pharmacological_therapies (
    assistance_id, 
    drug_id
)
VALUES
(1, 1),  -- assistance 1, drug 1
(1, 2),  -- assistance 1, drug 2
(2, 3);  -- assistance 2, drug 3

-- =========================================
-- 10. Insert into motor_exercises
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
-- 11. Insert into rehabilitation_therapies
--     (links assistances and motor_exercises)
-- =========================================
--   assistances:       ID=1,2
--   motor_exercises:   ID=1,2,3
INSERT INTO rehabilitation_therapies (
    assistance_id, 
    exercise_id
)
VALUES
(1, 1),  -- assistance 1, exercise 1
(1, 2),  -- assistance 1, exercise 2
(2, 3);  -- assistance 2, exercise 3
