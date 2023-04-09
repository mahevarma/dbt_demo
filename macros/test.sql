{% macro get_dependencies(model_name) %}

    {% set sources_list = sources() %}
    {% set refs_list = ref(model_name) %}

    {% set dependencies = [] %}
    {% for source in sources_list %}
        {% if source.name in refs_list %}
            {% set _ = dependencies.append(source.name) %}
        {% endif %}
    {% endfor %}

    {{ dependencies }}

{% endmacro %}
