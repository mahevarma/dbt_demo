{% macro create_run_end_results_table() %}

   create table if not exists {{ target.database }}.{{ target.schema }}.dbt_run_results (
      run_invocation_id text not null,
      model_identifier text not null,
      model_status text not null,
      model_message text not null,
      ROWS_AFFECTED text not null,
      execution_time text,
      updated_at timestamp not null
  );

{% endmacro %}

{% macro log_run_end_results_t(results) %}

    {% if execute %}  
        

        {% for res in results %}        
            
            {% set tidy_message = res.message.replace("'", '"') %}
            {% set query -%}
                insert into {{ target.database }}.{{ target.schema }}.dbt_run_results values (
                    '{{ invocation_id }}',
                    '{{ res.node.unique_id }}',
                    '{{ res.status }}', 
                    '{{ tidy_message }}',
                    '{{ res.adapter_response.rows_affected }}',
                    '{{ res.execution_time }}',
                    current_timestamp()
                );
            {%- endset %}
            {% do run_query(query) %}
            
        {% endfor %}
        
    {% endif %}

{% endmacro %}