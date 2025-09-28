

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
  '6acb5c06-d99c-4605-8394-95ff1d18d83a' AS dbt_batch_id
FROM MEDICAL_DB.RAW.billing
WHERE billing_id IS NOT NULL