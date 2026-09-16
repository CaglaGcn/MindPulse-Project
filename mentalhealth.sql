/* =========================================================
   MINDPULSE - SQL DATA EXPLORATION & CLEANING
   ========================================================= */

/* 1. Preview data */
SELECT TOP 10 *
FROM train;


/* 2. Row count */
SELECT COUNT(*) AS total_rows
FROM train;


/* 3. Column structure */
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'train'
ORDER BY ORDINAL_POSITION;


/* 4. Null value analysis */
SELECT
    COUNT(*) AS total_rows,

    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_null,
    SUM(CASE WHEN Name IS NULL THEN 1 ELSE 0 END) AS name_null,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS gender_null,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS age_null,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS city_null,
    SUM(CASE WHEN Working_Professional_or_Student IS NULL THEN 1 ELSE 0 END) AS working_status_null,
    SUM(CASE WHEN Profession IS NULL THEN 1 ELSE 0 END) AS profession_null,
    SUM(CASE WHEN Academic_Pressure IS NULL THEN 1 ELSE 0 END) AS academic_pressure_null,
    SUM(CASE WHEN Work_Pressure IS NULL THEN 1 ELSE 0 END) AS work_pressure_null,
    SUM(CASE WHEN CGPA IS NULL THEN 1 ELSE 0 END) AS cgpa_null,
    SUM(CASE WHEN Study_Satisfaction IS NULL THEN 1 ELSE 0 END) AS study_satisfaction_null,
    SUM(CASE WHEN Job_Satisfaction IS NULL THEN 1 ELSE 0 END) AS job_satisfaction_null,
    SUM(CASE WHEN Sleep_Duration IS NULL THEN 1 ELSE 0 END) AS sleep_duration_null,
    SUM(CASE WHEN Dietary_Habits IS NULL THEN 1 ELSE 0 END) AS dietary_habits_null,
    SUM(CASE WHEN Degree IS NULL THEN 1 ELSE 0 END) AS degree_null,
    SUM(CASE WHEN Have_you_ever_had_suicidal_thoughts IS NULL THEN 1 ELSE 0 END) AS suicidal_thoughts_null,
    SUM(CASE WHEN Work_Study_Hours IS NULL THEN 1 ELSE 0 END) AS work_study_hours_null,
    SUM(CASE WHEN Financial_Stress IS NULL THEN 1 ELSE 0 END) AS financial_stress_null,
    SUM(CASE WHEN Family_History_of_Mental_Illness IS NULL THEN 1 ELSE 0 END) AS family_history_null,
    SUM(CASE WHEN Depression IS NULL THEN 1 ELSE 0 END) AS depression_null
FROM train;


/* 5. Student vs working professional distribution */
SELECT 
    Working_Professional_or_Student,
    COUNT(*) AS total_count,
    CAST(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER ()
        AS DECIMAL(5,2)
    ) AS percentage
FROM train
GROUP BY Working_Professional_or_Student
ORDER BY total_count DESC;


/* 6. Missing fields among students */
SELECT
    COUNT(*) AS total_students,

    SUM(CASE WHEN Academic_Pressure IS NULL THEN 1 ELSE 0 END) AS academic_pressure_null,
    SUM(CASE WHEN CGPA IS NULL THEN 1 ELSE 0 END) AS cgpa_null,
    SUM(CASE WHEN Study_Satisfaction IS NULL THEN 1 ELSE 0 END) AS study_satisfaction_null,
    SUM(CASE WHEN Work_Pressure IS NULL THEN 1 ELSE 0 END) AS work_pressure_null,
    SUM(CASE WHEN Job_Satisfaction IS NULL THEN 1 ELSE 0 END) AS job_satisfaction_null,
    SUM(CASE WHEN Profession IS NULL THEN 1 ELSE 0 END) AS profession_null
FROM train
WHERE Working_Professional_or_Student = 'Student';


/* 7. Missing fields among working professionals */
SELECT
    COUNT(*) AS total_workers,

    SUM(CASE WHEN Work_Pressure IS NULL THEN 1 ELSE 0 END) AS work_pressure_null,
    SUM(CASE WHEN Job_Satisfaction IS NULL THEN 1 ELSE 0 END) AS job_satisfaction_null,
    SUM(CASE WHEN Profession IS NULL THEN 1 ELSE 0 END) AS profession_null,
    SUM(CASE WHEN Academic_Pressure IS NULL THEN 1 ELSE 0 END) AS academic_pressure_null,
    SUM(CASE WHEN CGPA IS NULL THEN 1 ELSE 0 END) AS cgpa_null,
    SUM(CASE WHEN Study_Satisfaction IS NULL THEN 1 ELSE 0 END) AS study_satisfaction_null
FROM train
WHERE Working_Professional_or_Student = 'Working Professional';


/* 8. Depression distribution */
SELECT 
    Depression,
    COUNT(*) AS total_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM train
GROUP BY Depression
ORDER BY Depression;


/* 9. Numeric range checks */
SELECT
    MIN(Age) AS MinAge,
    MAX(Age) AS MaxAge,

    MIN(Academic_Pressure) AS MinAcademicPressure,
    MAX(Academic_Pressure) AS MaxAcademicPressure,

    MIN(Work_Pressure) AS MinWorkPressure,
    MAX(Work_Pressure) AS MaxWorkPressure,

    MIN(CGPA) AS MinCGPA,
    MAX(CGPA) AS MaxCGPA,

    MIN(Study_Satisfaction) AS MinStudySatisfaction,
    MAX(Study_Satisfaction) AS MaxStudySatisfaction,

    MIN(Job_Satisfaction) AS MinJobSatisfaction,
    MAX(Job_Satisfaction) AS MaxJobSatisfaction,

    MIN(Work_Study_Hours) AS MinWorkStudyHours,
    MAX(Work_Study_Hours) AS MaxWorkStudyHours,

    MIN(Financial_Stress) AS MinFinancialStress,
    MAX(Financial_Stress) AS MaxFinancialStress
FROM train;


/* 10. Normalized / scaled output */
SELECT
    id,
    Name,
    Gender,
    Age / 10.0 AS Age,
    City,
    Working_Professional_or_Student,
    Profession,
    Academic_Pressure / 10.0 AS Academic_Pressure,
    Work_Pressure / 10.0 AS Work_Pressure,
    CGPA,
    Study_Satisfaction / 10.0 AS Study_Satisfaction,
    Job_Satisfaction / 10.0 AS Job_Satisfaction,
    Sleep_Duration,
    Dietary_Habits,
    Degree,
    Have_you_ever_had_suicidal_thoughts,
    Work_Study_Hours / 10.0 AS Work_Study_Hours,
    Financial_Stress / 10.0 AS Financial_Stress,
    Family_History_of_Mental_Illness,
    Depression
FROM train;