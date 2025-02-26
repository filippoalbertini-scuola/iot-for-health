-- ========================================================
-- 1. PATIENTS
-- ========================================================
CREATE TABLE patients (
    patient_id     SERIAL PRIMARY KEY,
    surname        VARCHAR(50) NOT NULL,
    name           VARCHAR(50) NOT NULL,
    password       VARCHAR(100) NOT NULL,
    phone_number   VARCHAR(20),
    username       VARCHAR(50) NOT NULL,
    birth_city     VARCHAR(50),
    email          VARCHAR(255) NOT NULL,
    CONSTRAINT uq_patients_email UNIQUE (email),
    CONSTRAINT uq_patients_username UNIQUE (username)
);

-- ========================================================
-- 2. CLINICIANS
-- ========================================================
CREATE TABLE clinicians (
    clinician_id   SERIAL PRIMARY KEY,
    surname        VARCHAR(50) NOT NULL,
    name           VARCHAR(50) NOT NULL,
    password       VARCHAR(100) NOT NULL,
    phone_number   VARCHAR(20),
    username       VARCHAR(50) NOT NULL,
    birth_date     DATE,
    email          VARCHAR(255) NOT NULL,
    CONSTRAINT uq_clinicians_email UNIQUE (email),
    CONSTRAINT uq_clinicians_username UNIQUE (username)
);


-- ========================================================
-- 3. PARAMETERS (1:1 with FREEZINGS)
-- ========================================================
CREATE TABLE parameters (
    parameter_id  SERIAL PRIMARY KEY,
    timestamp      TIMESTAMP NOT NULL,
    patient_id     INT NOT NULL,
    step_length    NUMERIC(5,2),
    frequency      NUMERIC(5,2),
    freeze_index   NUMERIC(5,2),
    energy         NUMERIC(5,2),
    CONSTRAINT fk_parameters_patients
        FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE
);

-- Index for faster lookups on patient_id
CREATE INDEX idx_parameters_patients
    ON parameters (patient_id);

-- ========================================================
-- 4. FREEZINGS (1..1 with PARAMETERS)
-- ========================================================
CREATE TABLE freezings (
    freezing_id    SERIAL PRIMARY KEY,
    parameter_id     INT NOT NULL,
    freeze_ts      TIMESTAMP NOT NULL,
    duration       INTERVAL,
    CONSTRAINT uq_freezings_parameter_id UNIQUE (parameter_id),
    CONSTRAINT fk_freezings_parameters
        FOREIGN KEY (parameter_id)
        REFERENCES parameters (parameter_id)
        ON DELETE CASCADE
);

-- Index for faster joins on parameter_id
CREATE INDEX idx_freezings_parameters
    ON freezings (parameter_id);

-- ========================================================
-- 5. DRUGS
-- ========================================================
CREATE TABLE drugs (
    drug_id        SERIAL PRIMARY KEY,
    company        VARCHAR(50),
    type           VARCHAR(50),
    dosage         VARCHAR(50)
);

-- ========================================================
-- 6. PHARMACOLOGICAL_THERAPIES (links PATIENTS, CLINICIAN and DRUGS)
-- ========================================================
CREATE TABLE pharmacological_therapies (
    pharm_therapy_id SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    clinician_id   INT NOT NULL,
    drug_id          INT NOT NULL,
    CONSTRAINT fk_pharm_therapies_patients
        FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_pharm_therapies_clinicians
        FOREIGN KEY (clinician_id)
        REFERENCES clinicians (clinician_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_pharm_therapies_drugs
        FOREIGN KEY (drug_id)
        REFERENCES drugs (drug_id)
        ON DELETE CASCADE
);

-- Indexes for foreign key columns
CREATE INDEX idx_pharm_therapies_patients
    ON pharmacological_therapies (patient_id);

CREATE INDEX idx_pharm_therapies_clinicians
    ON pharmacological_therapies (clinician_id);

CREATE INDEX idx_pharm_therapies_drugs
    ON pharmacological_therapies (drug_id);

-- ========================================================
-- 7. MOTOR_EXERCISES
-- ========================================================
CREATE TABLE motor_exercises (
    exercise_id     SERIAL PRIMARY KEY,
    description     TEXT,
    type            VARCHAR(50)
);

-- ========================================================
-- 8. REHABILITATION_THERAPIES (links PATIENTS, CLINICIAN and MOTOR_EXERCISES)
-- ========================================================
CREATE TABLE rehabilitation_therapies (
    rehab_therapy_id SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    clinician_id   INT NOT NULL,
    exercise_id      INT NOT NULL,
    CONSTRAINT fk_rehab_therapies_patients
        FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_rehab_therapies_clinicians
        FOREIGN KEY (clinician_id)
        REFERENCES clinicians (clinician_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_rehab_therapies_motor_exercises
        FOREIGN KEY (exercise_id)
        REFERENCES motor_exercises (exercise_id)
        ON DELETE CASCADE
);

-- Indexes for foreign key columns
CREATE INDEX idx_rehab_therapies_patients
    ON rehabilitation_therapies (patient_id);

CREATE INDEX idx_rehab_therapies_clinicians
    ON rehabilitation_therapies (clinician_id);

CREATE INDEX idx_rehab_therapies_motor_exercises
    ON rehabilitation_therapies (exercise_id);
