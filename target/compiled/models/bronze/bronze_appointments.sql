

SELECT
  appointment_id,
  patient_id,
  doctor_id,
  appointment_date,
  appointment_type,
  status,
  duration_minutes,
  notes,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '6acb5c06-d99c-4605-8394-95ff1d18d83a' AS dbt_batch_id
FROM MEDICAL_DB.RAW.appointments
WHERE appointment_id IS NOT NULL