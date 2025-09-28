{{ config(materialized='table', schema='bronze', tags=['bronze','medical_records'], description='Raw medical records with minimal transformations') }}

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
  '{{ invocation_id }}' AS dbt_batch_id
FROM {{ source('medical_raw','medical_records') }}
WHERE record_id IS NOT NULL
