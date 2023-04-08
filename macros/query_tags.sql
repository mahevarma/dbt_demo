{% macro set_query_tag() -%}
    {% set original_query_tag = get_current_query_tag() %}
    
    {% set dependencies = model.extra_dependencies %}
    {% set dependency_list = [] %}
    {% for dep in dependencies %}
        {% set dep_info = { "database": dep.database, "schema": dep.schema, "package": dep.package_name, "name": dep.name } %}
        {% set dep_str = '"dependency_{}":{}'.format(loop.index0,dep_info) %}
        {% do dependency_list.append(dep_str) %}
    {% endfor %}
    
    {% set new_query_tag = '{{ "query_tag_type" : "DBT_MODEL", "database" : "{}", "model_name" : "{}", "package" : "{}", "schema" : "{}", "dependencies_new" : {} }}'.format(model.database, model.name, model.package_name, model.schema, dependency_list | join(", ")) %}
    
    {{ log("setting query_tag to  " + new_query_tag)}}
    {% do run_query("alter session set query_tag = '{}'".format(new_query_tag)) %}
    
    {{ return(original_query_tag)}}
{% endmacro %}
