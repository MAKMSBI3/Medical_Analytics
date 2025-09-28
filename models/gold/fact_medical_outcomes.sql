{{ config(materialized='table', schema='gold', tags=['gold','fact'], description='Medical outcomes fact table with clinical context') }}

SELECT 
  mr.record_id,
  mr.appointment_id,
  mr.patient_id,
  mr.diagnosis,
  mr.diagnosis_category,
  mr.treatment_plan,
  mr.treatment_category,
  mr.severity,
  mr.severity_score,
  mr.needs_follow_up,
  -- Appointment context
  a.appointment_date,
  a.appointment_type,
  a.doctor_id,
  -- Patient context
  p.age_group AS patient_age_group,
  p.senior_status AS patient_senior_status,
  -- Doctor context
  d.specialty AS treating_specialty,
  d.care_category AS treating_care_category,
  -- Risk assessment
  CASE 
    WHEN mr.severity = 'High' AND p.age >= {{ var('senior_age_threshold') }} THEN 'Critical Risk'
    WHEN mr.severity = 'High' OR p.age >= 75 THEN 'High Risk'
    WHEN mr.severity = 'Medium' AND p.age >= 50 THEN 'Moderate Risk'
    ELSE 'Low Risk' END AS patient_risk_level,
  mr.created_at,
  CURRENT_TIMESTAMP() AS last_updated
FROM {{ ref('silver_medical_records') }} mr
LEFT JOIN {{ ref('fact_appointments') }} a ON mr.appointment_id = a.appointment_id
LEFT JOIN {{ ref('dim_patients') }} p ON mr.patient_id = p.patient_id
LEFT JOIN {{ ref('dim_doctors') }} d ON a.doctor_id = d.doctor_id
