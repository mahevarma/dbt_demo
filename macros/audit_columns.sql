{% macro add_audit_columns() %}
current_timestamp as sf_insert_dttm,
current_timestamp as sf_update_dttm
{% endmacro %}