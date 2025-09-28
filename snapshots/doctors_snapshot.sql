{% snapshot doctors_snapshot %}
{{
  config(
    target_schema='snapshots',
    unique_key='doctor_id',
    strategy='timestamp',
    updated_at='hired_date'
  )
}}
SELECT * FROM {{ ref('silver_doctors') }}
{% endsnapshot %}
