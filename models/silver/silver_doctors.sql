{{ config(materialized='table', schema='silver', tags=['silver','doctors'], description='Cleaned doctor data with experience categorization') }}

WITH specialty_mapping AS (
  SELECT * FROM {{ ref('medical_specialties') }}
)
SELECT
  d.doctor_id,
  TRIM(d.doctor_name) AS doctor_name,
  TRIM(d.specialty) AS specialty,
  COALESCE(sm.specialty_category,'Other') AS specialty_category,
  d.department_id,
  d.phone,
  LOWER(TRIM(d.email)) AS email,
  d.license_number,
  d.years_experience,
  CASE 
    WHEN d.years_experience < 5 THEN 'Junior'
    WHEN d.years_experience BETWEEN 5 AND 15 THEN 'Mid-Level'
    WHEN d.years_experience BETWEEN 16 AND 25 THEN 'Senior'
    ELSE 'Expert' END AS experience_level,
  CASE 
    WHEN d.specialty IN ('Emergency Medicine','Surgery') THEN 'Critical Care'
    WHEN d.specialty IN ('Cardiology','Neurology','Oncology') THEN 'Specialty Care'
    WHEN d.specialty IN ('Internal Medicine','Pediatrics') THEN 'Primary Care'
    ELSE 'Other Care' END AS care_category,
  d.is_active,
  CASE WHEN d.is_active = 'Y' THEN TRUE ELSE FALSE END AS is_active_flag,
  d.hired_date,
  DATEDIFF('year', d.hired_date, CURRENT_DATE()) AS tenure_years,
  d.dbt_loaded_at,
  d.dbt_batch_id
FROM {{ ref('bronze_doctors') }} d
LEFT JOIN specialty_mapping sm ON d.specialty = sm.specialty_name
WHERE d.doctor_id IS NOT NULL
