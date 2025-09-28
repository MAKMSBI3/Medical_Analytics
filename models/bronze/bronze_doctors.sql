{{ config(materialized='table', schema='bronze', tags=['bronze','doctors'], description='Raw doctor data with minimal transformations') }}

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
  '{{ invocation_id }}' AS dbt_batch_id
FROM {{ source('medical_raw','doctors') }}
WHERE doctor_id IS NOT NULL
