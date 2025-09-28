{{ config(materialized='table', schema='silver', tags=['silver','billing'], description='Cleaned billing data with financial calculations') }}

SELECT
  billing_id,
  appointment_id,
  patient_id,
  total_amount,
  insurance_paid,
  patient_paid,
  ROUND((insurance_paid / NULLIF(total_amount, 0)) * 100, 2) AS insurance_coverage_percentage,
  CASE 
    WHEN total_amount >= {{ var('high_amount_threshold') }} THEN 'High Value'
    WHEN total_amount >= 500 THEN 'Medium Value'
    ELSE 'Low Value' END AS revenue_tier,
  CASE 
    WHEN (insurance_paid / NULLIF(total_amount, 0)) >= 0.9 THEN 'Excellent Coverage'
    WHEN (insurance_paid / NULLIF(total_amount, 0)) >= 0.7 THEN 'Good Coverage'
    WHEN (insurance_paid / NULLIF(total_amount, 0)) >= 0.5 THEN 'Fair Coverage'
    ELSE 'Poor Coverage' END AS coverage_quality,
  billing_date,
  DATEDIFF('day', billing_date, CURRENT_DATE()) AS days_since_billing,
  payment_status,
  CASE 
    WHEN payment_status = 'Paid' THEN 'Collected'
    WHEN payment_status = 'Pending' THEN 'Outstanding'
    WHEN payment_status = 'Denied' THEN 'Collection'
    ELSE 'Review' END AS collection_status,
  CASE WHEN payment_status != 'Paid' AND DATEDIFF('day', billing_date, CURRENT_DATE()) > 30 THEN 1 ELSE 0 END AS is_overdue,
  insurance_claim_number,
  created_at,
  updated_at,
  dbt_loaded_at,
  dbt_batch_id
FROM {{ ref('bronze_billing') }}
WHERE billing_id IS NOT NULL
