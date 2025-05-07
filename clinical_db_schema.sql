-- Create database
CREATE DATABASE clinical_trials_db;
USE clinical_trials_db;

-- This table stores information about investigators (doctors) conducting clinical trials.
CREATE TABLE investigators (
    investigator_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100),
    UNIQUE (first_name, last_name)
);

-- Insert investigators
INSERT INTO investigators (first_name, last_name, specialty) VALUES
		('James', 'Carter', 'Oncology'),
		('Lisa', 'Nguyen', 'Cardiology'),
		('Ahmed', 'Hassan', 'Endocrinology'),
		('Emily', 'Stewart', 'Neurology'),
		('Raj', 'Patel', 'Immunology');

-- This table stores research site details where clinical trials are conducted.
CREATE TABLE sites (
    site_id INT PRIMARY KEY AUTO_INCREMENT,
    site_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- Insert sites
INSERT INTO sites (site_name, location) 
	VALUES
		('Alpha Research Center', 'New York, NY'),
		('Beta Health Institute', 'Chicago, IL'),
		('Gamma Clinical Labs', 'Los Angeles, CA');

-- This table stores site_investigators
-- Many-to-Many table linking investigators to sites.
-- Includes a flag to designate the Principal Investigator (PI) per site.
-- ===================================================================================================
CREATE TABLE site_investigators (
    investigator_id INT NOT NULL,
    site_id INT NOT NULL,
    is_principal BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (investigator_id, site_id),
    FOREIGN KEY (investigator_id) REFERENCES investigators(investigator_id),
    FOREIGN KEY (site_id) REFERENCES sites(site_id)
);

-- Link investigators to sites
-- Ensure one PI per site (is_principal = TRUE)
-- Some investigators are linked to multiple sites
-- =========================================================================================================
INSERT INTO site_investigators (investigator_id, site_id, is_principal) 
	VALUES
		(1, 1, TRUE),    -- James Carter is PI at Alpha
		(2, 2, TRUE),    -- Lisa Nguyen is PI at Beta
		(3, 3, TRUE),    -- Ahmed Hassan is PI at Gamma
		(4, 1, FALSE),   -- Emily Stewart works at Alpha
		(5, 2, FALSE),   -- Raj Patel works at Beta
		(3, 1, FALSE);   -- Ahmed Hassan also works at Alpha

-- This table stores clinical study-level information.
CREATE TABLE studies (
    study_id INT PRIMARY KEY AUTO_INCREMENT,
    study_title VARCHAR(255) NOT NULL,
    therapeutic_area VARCHAR(100),
    start_date DATE NOT NULL,
    end_date DATE
);

-- Insert studies
INSERT INTO studies (study_title, therapeutic_area, start_date, end_date) 
	VALUES
		('Study A: Cancer Immunotherapy', 'Oncology', '2023-01-01', '2024-01-01'),
		('Study B: Heart Failure Drug', 'Cardiology', '2023-06-01', NULL);

-- This table stores participant data linked to a specific study and site.
CREATE TABLE subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_number VARCHAR(20) NOT NULL UNIQUE,
    site_id INT NOT NULL,
    study_id INT NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    birth_date DATE NOT NULL,
    enrollment_date DATE NOT NULL,
    FOREIGN KEY (site_id) REFERENCES sites(site_id),
    FOREIGN KEY (study_id) REFERENCES studies(study_id)
);

-- Insert subjects
INSERT INTO subjects (subject_number, site_id, study_id, gender, birth_date, enrollment_date) 
	VALUES
		('SUB001', 1, 1, 'Male', '1980-02-14', '2023-01-15'),
		('SUB002', 1, 1, 'Female', '1975-06-30', '2023-02-10'),
		('SUB003', 2, 2, 'Male', '1968-11-22', '2023-06-20'),
		('SUB004', 2, 2, 'Female', '1990-08-12', '2023-07-05'),
		('SUB005', 3, 1, 'Other', '1985-04-03', '2023-03-01');

-- This table Tracks subject visits with date and optional notes.
CREATE TABLE visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_id INT NOT NULL,
    visit_name VARCHAR(100) NOT NULL,
    visit_date DATE NOT NULL,
    notes TEXT,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Insert visits
INSERT INTO visits (subject_id, visit_name, visit_date, notes) 
	VALUES
		(1, 'Screening', '2023-01-15', 'Initial blood work done.'),
		(1, 'Baseline', '2023-01-20', 'No adverse events.'),
		(2, 'Screening', '2023-02-10', 'Subject eligible.'),
		(3, 'Baseline', '2023-06-20', 'Enrolled with mild hypertension.'),
		(4, 'Screening', '2023-07-05', 'ECG normal.'),
		(5, 'Baseline', '2023-03-01', 'Completed pre-dose assessment.');

-- This table stores vital signs data per visit.
CREATE TABLE vitals (
    vital_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    heart_rate INT,
    systolic_bp INT,
    diastolic_bp INT,
    temperature DECIMAL(4,1),
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
);

-- Insert vitals
INSERT INTO vitals (visit_id, heart_rate, systolic_bp, diastolic_bp, temperature) 
	VALUES
		(1, 72, 120, 80, 36.6),
		(2, 78, 118, 79, 36.8),
		(3, 66, 122, 84, 37.1),
		(4, 85, 140, 90, 37.2),
		(5, 70, 110, 75, 36.5),
		(6, 88, 130, 85, 36.9);