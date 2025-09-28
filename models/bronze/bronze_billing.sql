{{ config(materialized='table', schema='bronze', tags=['bronze','billing'], description='Raw billing data with minimal transformations') }}

SELECT
  billing_id,
  appointment_id,
  patient_id,
  total_amount,
  insurance_paid,
  patient_paid,
  billing_date,
  payment_status,
  insurance_claim_number,
  created_at,
  created_at AS updated_at,
  CURRENT_TIMESTAMP() AS dbt_loaded_at,
  '{{ invocation_id }}' AS dbt_batch_id
FROM {{ source('medical_raw','billing') }}
WHERE billing_id IS NOT NULL
