
  
    

create or replace transient table MEDICAL_DB.bronze.bronze_appointments
    

    
    as (

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
  '8ddbe747-2519-4551-8319-62c228b382f1' AS dbt_batch_id
FROM MEDICAL_DB.RAW.appointments
WHERE appointment_id IS NOT NULL
    )
;


  