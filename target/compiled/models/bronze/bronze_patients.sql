

SELECT
  patient_id,
  first_name,
  last_name,
  date_of_birth,
  gender,
  blood_type,
  phone,
  email,
  address,
  city,
  state,
  zip_code,
  insurance_type,
  emergency_contact,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '6acb5c06-d99c-4605-8394-95ff1d18d83a' AS dbt_batch_id
FROM MEDICAL_DB.RAW.patients
WHERE patient_id IS NOT NULL