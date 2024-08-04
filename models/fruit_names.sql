{% set payment_methods = dbt_utils.get_column_values(table=ref('stg_payment'), column='paymentmethod') %}


{% for i in payment_methods  %}
    select {{ i }}

{% endfor %}