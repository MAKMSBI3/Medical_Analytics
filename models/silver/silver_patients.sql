{{ config(materialized='table', schema='silver', tags=['silver','patients'], description='Cleaned and standardized patient data with business logic') }}

SELECT
  patient_id,
  TRIM(UPPER(first_name)) AS first_name,
  TRIM(UPPER(last_name)) AS last_name,
  TRIM(UPPER(first_name)) || ' ' || TRIM(UPPER(last_name)) AS full_name,
  date_of_birth,
  {{ calculate_age('date_of_birth') }} AS age,
  {{ age_group_category(calculate_age('date_of_birth')) }} AS age_group,
  CASE WHEN {{ calculate_age('date_of_birth') }} >= {{ var('senior_age_threshold') }} THEN 'Senior' ELSE 'Non-Senior' END AS senior_status,
  UPPER(gender) AS gender,
  blood_type,
  CASE 
    WHEN blood_type IN ('O+','O-') THEN 'Universal Donor'
    WHEN blood_type IN ('AB+','AB-') THEN 'Universal Recipient'
    ELSE 'Standard' END AS blood_type_category,
  phone,
  LOWER(TRIM(email)) AS email,
  address,
  TRIM(UPPER(city)) AS city,
  UPPER(state) AS state,
  zip_code,
  insurance_type,
  CASE 
    WHEN insurance_type IN ('Medicare','Medicaid') THEN 'Government'
    WHEN insurance_type = 'Private' THEN 'Commercial'
    ELSE 'Other' END AS insurance_category,
  emergency_contact,
  created_at,
  updated_at,
  dbt_loaded_at,
  dbt_batch_id
FROM {{ ref('bronze_patients') }}
WHERE patient_id IS NOT NULL
