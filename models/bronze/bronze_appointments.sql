{{ config(materialized='table', schema='bronze', tags=['bronze','appointments'], description='Raw appointment data with minimal transformations') }}

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
  '{{ invocation_id }}' AS dbt_batch_id
FROM {{ source('medical_raw','appointments') }}
WHERE appointment_id IS NOT NULL
