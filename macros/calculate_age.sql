{% macro calculate_age(date_column) %}
  DATEDIFF('year', {{ date_column }}, CURRENT_DATE())
{% endmacro %}

{% macro age_group_category(age_expr) %}
  CASE
    WHEN {{ age_expr }} < 18 THEN 'Minor'
    WHEN {{ age_expr }} BETWEEN 18 AND 39 THEN 'Young Adult'
    WHEN {{ age_expr }} BETWEEN 40 AND 59 THEN 'Middle Age'
    WHEN {{ age_expr }} BETWEEN 60 AND 79 THEN 'Senior'
    ELSE 'Elderly'
  END
{% endmacro %}

{% macro business_days_between(start_date, end_date) %}
  CASE 
    WHEN {{ start_date }} IS NULL OR {{ end_date }} IS NULL THEN NULL
    ELSE DATEDIFF('day', {{ start_date }}, {{ end_date }}) - (DATEDIFF('week', {{ start_date }}, {{ end_date }}) * 2)
  END
{% endmacro %}
