{% snapshot patients_snapshot %}
{{
  config(
    target_schema='snapshots',
    unique_key='patient_id',
    strategy='timestamp',
    updated_at='updated_at'
  )
}}
SELECT * FROM {{ ref('silver_patients') }}
{% endsnapshot %}
