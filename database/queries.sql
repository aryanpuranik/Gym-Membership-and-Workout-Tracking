--  Retrieve All Active Members

SELECT M_id, M_name AS Name, M_age AS Age, M_gender AS Gender, M_contact_info AS Contact_Information, MP_name AS Membership_Type
FROM Member
JOIN Membership_Plan ON Member.MP_type = Membership_Plan.MP_type
WHERE M_status = 'Active';

-- Track Workout Progress of Each Member

SELECT M.M_name AS Name, WP.WP_name as Workout_Name, WL.WL_date AS Date, WL.WL_duration As Duration, WL.WL_amount_of_time_in_gym AS Amount_Of_Time_In_Gym_Monthly
FROM Workout_Log WL
JOIN Member M ON WL.M_id = M.M_id
JOIN Workout_Program WP ON WL.WP_id = WP.WP_id
ORDER BY WL.WL_date DESC;

-- Monitor Attendance (Class Check-Ins)

SELECT M.M_name AS Name, C.C_name As Class_name, A.A_check_in_time As Check_in_Time, A.A_check_out_time as Check_out_time
FROM Attendance A
JOIN Member M ON A.M_id = M.M_id
JOIN Class_Schedule C ON A.C_id = C.C_id
ORDER BY A.A_check_in_time DESC;