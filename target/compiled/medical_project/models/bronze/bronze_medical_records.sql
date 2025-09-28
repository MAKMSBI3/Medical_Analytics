

SELECT
  record_id,
  appointment_id,
  patient_id,
  diagnosis,
  treatment_plan,
  prescription,
  follow_up_required,
  severity,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '8ddbe747-2519-4551-8319-62c228b382f1' AS dbt_batch_id
FROM MEDICAL_DB.RAW.medical_records
WHERE record_id IS NOT NULL