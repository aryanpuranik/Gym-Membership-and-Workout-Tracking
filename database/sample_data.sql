use gym_management;

INSERT INTO Membership_Plan (MP_name, MP_duration, MP_cost, MP_features) VALUES
('Basic', 1, 29.99, 'Access to gym equipment'),
('Premium', 6, 149.99, 'Access to gym equipment + group classes'),
('VIP', 12, 299.99, 'All-access + personal trainer sessions');

INSERT INTO Member (M_name, M_age, M_gender, M_contact_info, MP_type, M_status) VALUES
('John Doe', 25, 'Male', 'john@example.com', 1, 'Active'),
('Jane Smith', 30, 'Female', 'jane@example.com', 2, 'Active'),
('Mike Johnson', 35, 'Male', 'mike@example.com', 3, 'Inactive');

INSERT INTO Trainer (T_name, T_specialization, T_experience, T_contact_info, T_availability, T_type) VALUES
('Sarah Connor', 'Strength Training', 5, 'sarah@example.com', 'Available','Full-Time'),
('James Brown', 'Yoga', 8, 'james@example.com', 'Unavailable','Part-Time'),
('Alice Green', 'Cardio & Endurance', 4, 'alice@example.com', 'Available','Full-Time');

INSERT INTO Full_Time_Trainer (T_id, Salary, Fixed_Hours) VALUES
(1, 5000.00, 40),  -- Sarah Connor
(3, 4800.00, 38);  -- Alice Green

INSERT INTO Part_Time_Trainer (T_id, Hour_Rate, Schedule) VALUES
(2, 35.00, 'Mon-Wed-Fri: 6pm-9pm');  -- James Brown;

INSERT INTO Trainer_Assignment (T_id, M_id, TA_start_date, TA_end_date) VALUES
(1, 1, '2024-03-01', '2024-09-01'),
(2, 2, '2024-02-15', '2024-08-15'),
(3, 3, '2024-01-10', '2024-07-10');

INSERT INTO Workout_Program (WP_name, WP_description, WP_difficulty_level, WP_duration) VALUES
('Full Body Workout', 'Strength training for all muscles', 'Intermediate', 60),
('HIIT Training', 'High-intensity interval training', 'Advanced', 45),
('Yoga Basics', 'Beginner yoga poses', 'Beginner', 40);

INSERT INTO Workout_Log (M_id, WP_id, WL_date, WL_duration, WL_amount_of_time_in_gym) VALUES
(1, 1, '2024-03-07', 60, 75),
(2, 2, '2024-03-06', 45, 60),
(3, 3, '2024-03-05', 40, 50);

INSERT INTO Class_Schedule (C_name, C_date, C_time, C_location, T_id) VALUES
('Morning HIIT', '2024-03-10', '08:00:00', 'Room A', 2),
('Strength Training', '2024-03-11', '10:00:00', 'Room B', 1),
('Evening Yoga', '2024-03-12', '18:00:00', 'Studio C', 3);

INSERT INTO Attendance (M_id, T_id, C_id, A_check_in_time, A_check_out_time) VALUES
(1, 2, 1, '08:00:00', '09:00:00'),
(2, 1, 2, '10:00:00', '11:00:00'),
(3, 3, 3, '18:00:00', '19:00:00');

INSERT INTO Payment (M_id, P_amount, P_date, P_method) VALUES
(1, 29.99, '2024-03-01', 'Cash'),
(2, 149.99, '2024-02-15', 'Online'),
(3, 299.99, '2024-01-10', 'Cash');

INSERT INTO Online_Payment (P_id, Transaction_ID, Payment_Gateway) VALUES
(2, 'TXN789012', 'PayPal');

INSERT INTO Cash_Payment (P_id, Cash_Received_By, Counter_ID) VALUES
(1, 'Receptionist A', 1),
(3, 'Receptionist B', 2);

INSERT INTO Invoice (M_id, I_due_date, I_amount, I_status) VALUES
(1, '2024-04-01', 29.99, 'Paid'),
(2, '2024-08-15', 149.99, 'Pending'),
(3, '2024-07-10', 299.99, 'Overdue');

INSERT INTO User_Account (M_id, T_id, UA_Username, UA_password, UA_role) VALUES
(1, NULL, 'johndoe', 'hashedpassword1', 'Member'),
(2, NULL, 'janesmith', 'hashedpassword2', 'Member'),
(NULL, 1, 'sarahc', 'hashedpassword3', 'Trainer');

INSERT INTO Feedback_Review (M_id, T_id, FR_rating, FR_comments, FR_date) VALUES
(1, 1, 5, 'Great personal training session!', '2024-03-05'),
(2, 1, 4, 'Loved the yoga class.', '2024-03-06'),
(3, 1, 3, 'Decent cardio session.', '2024-03-07');


select * from User_Account;

SELECT @@hostname;
SELECT * from Member;

