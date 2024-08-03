{% macro log_run_end_results_test(results) %}

    {% if execute %}

        {% set run_results_json = load_file('target/run_results.json') %}

        {% set query -%}
            insert into {{ target.database }}.{{ target.schema }}.dbt_run_results_test values (
                '{{ run_results_json }}',
                current_timestamp()
            );
        {%- endset %}
        {% do run_query(query) %}

    {% endif %}

{% endmacro %}