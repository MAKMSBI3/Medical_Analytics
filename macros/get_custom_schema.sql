{% macro get_schema_reference(schema_name) %}
  {{ target.database }}.{{ schema_name }}
{% endmacro %}

{% macro create_table_name(table_name, layer) %}
  {{ layer }}_{{ table_name }}
{% endmacro %}
