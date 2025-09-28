

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
  '6acb5c06-d99c-4605-8394-95ff1d18d83a' AS dbt_batch_id
FROM MEDICAL_DB.RAW.medical_records
WHERE record_id IS NOT NULL