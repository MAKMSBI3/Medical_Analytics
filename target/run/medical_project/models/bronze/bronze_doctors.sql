
  
    

create or replace transient table MEDICAL_DB.bronze.bronze_doctors
    

    
    as (

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
  '8ddbe747-2519-4551-8319-62c228b382f1' AS dbt_batch_id
FROM MEDICAL_DB.RAW.doctors
WHERE doctor_id IS NOT NULL
    )
;


  