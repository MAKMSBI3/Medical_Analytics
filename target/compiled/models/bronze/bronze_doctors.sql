

SELECT
  doctor_id,
  doctor_name,
  specialty,
  department_id,
  phone,
  email,
  license_number,
  years_experience,
  is_active,
  hired_date,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '6acb5c06-d99c-4605-8394-95ff1d18d83a' AS dbt_batch_id
FROM MEDICAL_DB.RAW.doctors
WHERE doctor_id IS NOT NULL