CREATE DATABASE gym;
USE gym;

CREATE TABLE Membership_Plan (
    MP_type INT PRIMARY KEY AUTO_INCREMENT,
    MP_name VARCHAR(100) NOT NULL,
    MP_duration INT,  -- In months
    MP_cost DECIMAL(10,2),
    MP_features TEXT
);

CREATE TABLE Member (
    M_id INT PRIMARY KEY AUTO_INCREMENT,
    M_name VARCHAR(100) NOT NULL,
    M_age INT,
    M_gender ENUM('Male', 'Female', 'Other'),
    M_contact_info VARCHAR(255),
    MP_type INT,
    M_registration_date DATE DEFAULT (CURDATE()),
    M_status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (MP_type) REFERENCES Membership_Plan(MP_type) 
    ON DELETE SET NULL ON UPDATE CASCADE
);



-- (Supertype)
CREATE TABLE Payment (
    P_id INT PRIMARY KEY AUTO_INCREMENT,
    M_id INT,
    P_amount DECIMAL(10,2) NOT NULL,
    P_date DATE DEFAULT (CURDATE()),
    P_method ENUM('Cash', 'Card', 'Online') NOT NULL, 
    FOREIGN KEY (M_id) REFERENCES Member(M_id) ON DELETE CASCADE
);

-- (Subtype)
CREATE TABLE Online_Payment (
    P_id INT PRIMARY KEY,
    Transaction_ID VARCHAR(100),
    Payment_Gateway VARCHAR(100),
    FOREIGN KEY (P_id) REFERENCES Payment(P_id) ON DELETE CASCADE
);

-- (Subtype)
CREATE TABLE Cash_Payment (
    P_id INT PRIMARY KEY,
    Cash_Received_By VARCHAR(100),
    Counter_ID INT,
    FOREIGN KEY (P_id) REFERENCES Payment(P_id) ON DELETE CASCADE
);

CREATE TABLE Invoice (
    I_id INT PRIMARY KEY AUTO_INCREMENT,
    M_id INT,
    I_due_date DATE,
    I_amount DECIMAL(10,2) NOT NULL,
    I_status ENUM('Paid', 'Pending', 'Overdue') DEFAULT 'Pending',
    FOREIGN KEY (M_id) REFERENCES Member(M_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- (Supertype)
CREATE TABLE Trainer (
    T_id INT PRIMARY KEY AUTO_INCREMENT,
    T_name VARCHAR(100) NOT NULL,
    T_specialization VARCHAR(100),
    T_experience INT CHECK (T_experience >= 0),
    T_contact_info VARCHAR(255),
    T_availability ENUM('Available', 'Unavailable') DEFAULT 'Available',
    T_type ENUM('Full-Time', 'Part-Time') NOT NULL
);

-- (Subtype)
CREATE TABLE Full_Time_Trainer (
    T_id INT PRIMARY KEY,
    Salary DECIMAL(10,2),
    Fixed_Hours INT,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) ON DELETE CASCADE
);

-- (Subtype)
CREATE TABLE Part_Time_Trainer (
    T_id INT PRIMARY KEY,
    Hour_Rate DECIMAL(10,2),
    Schedule TEXT,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) ON DELETE CASCADE
);


CREATE TABLE Trainer_Assignment (
    T_id INT,
    M_id INT,
    TA_start_date DATE DEFAULT (CURDATE()),
    TA_end_date DATE,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (M_id) REFERENCES Member(M_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Workout_Program (
    WP_id INT PRIMARY KEY AUTO_INCREMENT,
    WP_name VARCHAR(100) NOT NULL,
    WP_description TEXT,
    WP_difficulty_level ENUM('Beginner', 'Intermediate', 'Advanced'),
    WP_duration INT  -- Duration in minutes
);


CREATE TABLE Workout_Log (
    M_id INT,
    WP_id INT,
    WL_date DATE DEFAULT (CURDATE()),
    WL_duration INT,  -- Duration in minutes
    WL_amount_of_time_in_gym INT,  -- Total gym time in minutes
    FOREIGN KEY (M_id) REFERENCES Member(M_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (WP_id) REFERENCES Workout_Program(WP_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Class_Schedule (
    C_id INT PRIMARY KEY AUTO_INCREMENT,
    C_name VARCHAR(100),
    C_date DATE,
    C_time TIME,
    C_location VARCHAR(255),
    T_id INT,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Attendance (
    M_id INT,
    T_id INT,
    C_id INT,
    A_check_in_time TIME DEFAULT (CURRENT_TIME),
    A_check_out_time TIME,
    FOREIGN KEY (M_id) REFERENCES Member(M_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (C_id) REFERENCES Class_Schedule(C_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE User_Account (
    M_id INT,
    T_id INT,
    UA_Username VARCHAR(100) UNIQUE NOT NULL,
    UA_password VARCHAR(255) NOT NULL,
    UA_role ENUM('Admin', 'Member', 'Trainer') NOT NULL,
    FOREIGN KEY (M_id) REFERENCES Member(M_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE Feedback_Review (
    M_id INT,
    T_id INT,
    FR_rating INT CHECK (FR_rating BETWEEN 1 AND 5),
    FR_comments TEXT,
    FR_date DATE DEFAULT (CURDATE()),
    FOREIGN KEY (M_id) REFERENCES Member(M_id) 
    ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (T_id) REFERENCES Trainer(T_id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

Drop table User_Account;
