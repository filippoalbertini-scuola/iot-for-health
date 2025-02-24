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
    CONSTRAINT uq_patients_email UNIQUE (email)
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
    CONSTRAINT uq_clinicians_email UNIQUE (email)
);

-- ========================================================
-- 3. EPISODES
-- ========================================================
CREATE TABLE episodes (
    episode_id     SERIAL PRIMARY KEY
    -- Add additional attributes here if needed
);

-- ========================================================
-- 4. PARAMETERS (1:1 with EPISODES)
-- ========================================================
CREATE TABLE parameters (
    parameters_id  SERIAL PRIMARY KEY,
    episode_id     INT UNIQUE NOT NULL,
    step_length    NUMERIC(5,2),
    frequency      NUMERIC(5,2),
    freeze_index   NUMERIC(5,2),
    energy         NUMERIC(5,2),
    CONSTRAINT fk_parameters_episodes
        FOREIGN KEY (episode_id)
        REFERENCES episodes (episode_id)
        ON DELETE CASCADE
);

-- Index for faster lookups on episode_id
CREATE INDEX idx_parameters_episodes
    ON parameters (episode_id);

-- ========================================================
-- 5. FREEZINGS (0..n with EPISODES)
-- ========================================================
CREATE TABLE freezings (
    freezing_id    SERIAL PRIMARY KEY,
    episode_id     INT NOT NULL,
    freeze_ts      TIMESTAMP NOT NULL,
    duration       INTERVAL,
    CONSTRAINT fk_freezings_episodes
        FOREIGN KEY (episode_id)
        REFERENCES episodes (episode_id)
        ON DELETE CASCADE
);

-- Index for faster joins on episode_id
CREATE INDEX idx_freezings_episodes
    ON freezings (episode_id);

-- ========================================================
-- 6. MONITORINGS (links PATIENTS and EPISODES)
-- ========================================================
CREATE TABLE monitorings (
    monitoring_id  SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    episode_id     INT NOT NULL,
    flag_therapy   BOOLEAN,
    CONSTRAINT fk_monitorings_patients
        FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_monitorings_episodes
        FOREIGN KEY (episode_id)
        REFERENCES episodes (episode_id)
        ON DELETE CASCADE
);

-- Indexes for foreign key columns
CREATE INDEX idx_monitorings_patients
    ON monitorings (patient_id);

CREATE INDEX idx_monitorings_episodes
    ON monitorings (episode_id);

-- ========================================================
-- 7. ASSISTANCES (links PATIENTS and CLINICIANS)
-- ========================================================
CREATE TABLE assistances (
    assistance_id  SERIAL PRIMARY KEY,
    patient_id     INT NOT NULL,
    clinician_id   INT NOT NULL,
    CONSTRAINT fk_assistances_patients
        FOREIGN KEY (patient_id)
        REFERENCES patients (patient_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_assistances_clinicians
        FOREIGN KEY (clinician_id)
        REFERENCES clinicians (clinician_id)
        ON DELETE CASCADE
);

-- Indexes for foreign key columns
CREATE INDEX idx_assistances_patients
    ON assistances (patient_id);

CREATE INDEX idx_assistances_clinicians
    ON assistances (clinician_id);

-- ========================================================
-- 8. DRUGS
-- ========================================================
CREATE TABLE drugs (
    drug_id        SERIAL PRIMARY KEY,
    company        VARCHAR(50),
    type           VARCHAR(50),
    dosage         VARCHAR(50)
);

-- ========================================================
-- 9. PHARMACOLOGICAL_THERAPIES (links ASSISTANCES and DRUGS)
-- ========================================================
CREATE TABLE pharmacological_therapies (
    pharm_therapy_id SERIAL PRIMARY KEY,
    assistance_id    INT NOT NULL,
    drug_id          INT NOT NULL,
    CONSTRAINT fk_pharm_therapies_assistances
        FOREIGN KEY (assistance_id)
        REFERENCES assistances (assistance_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_pharm_therapies_drugs
        FOREIGN KEY (drug_id)
        REFERENCES drugs (drug_id)
        ON DELETE CASCADE
);

-- Indexes for foreign key columns
CREATE INDEX idx_pharm_therapies_assistances
    ON pharmacological_therapies (assistance_id);

CREATE INDEX idx_pharm_therapies_drugs
    ON pharmacological_therapies (drug_id);

-- ========================================================
-- 10. MOTOR_EXERCISES
-- ========================================================
CREATE TABLE motor_exercises (
    exercise_id     SERIAL PRIMARY KEY,
    description     TEXT,
    type            VARCHAR(50)
);

-- ========================================================
-- 11. REHABILITATION_THERAPIES (links ASSISTANCES and MOTOR_EXERCISES)
-- ========================================================
CREATE TABLE rehabilitation_therapies (
    rehab_therapy_id SERIAL PRIMARY KEY,
    assistance_id    INT NOT NULL,
    exercise_id      INT NOT NULL,
    CONSTRAINT fk_rehab_therapies_assistances
        FOREIGN KEY (assistance_id)
        REFERENCES assistances (assistance_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_rehab_therapies_motor_exercises
        FOREIGN KEY (exercise_id)
        REFERENCES motor_exercises (exercise_id)
        ON DELETE CASCADE
);

-- Indexes for foreign key columns
CREATE INDEX idx_rehab_therapies_assistances
    ON rehabilitation_therapies (assistance_id);

CREATE INDEX idx_rehab_therapies_motor_exercises
    ON rehabilitation_therapies (exercise_id);
