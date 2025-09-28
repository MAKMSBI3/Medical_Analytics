

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
  '8ddbe747-2519-4551-8319-62c228b382f1' AS dbt_batch_id
FROM MEDICAL_DB.RAW.patients
WHERE patient_id IS NOT NULL