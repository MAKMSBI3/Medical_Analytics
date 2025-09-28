{{ config(materialized='table', schema='bronze', tags=['bronze','patients'], description='Raw patient data with minimal transformations') }}

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
  '{{ invocation_id }}' AS dbt_batch_id
FROM {{ source('medical_raw','patients') }}
WHERE patient_id IS NOT NULL
