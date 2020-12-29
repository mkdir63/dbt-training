{% macro get_column_values(column_name, relation) %}

{% set relation_query %}
select distinct
{{ column_name }}
from {{ relation }}
order by 1
{% endset %}

{% set results = run_query(relation_query) %}        {# run_query() runs the argument query, which we defined #}
                                                     {# in {% set name_query %} etc {% endset %} #}

{# We use the 'execute' variable to ensure that the code runs during the parse stage of dbt (otherwise gives error). #}
{% if execute %}
{% set results_list = results.columns[0].values() %}		{# Return the first column #}
{% else %}
{% set results_list = [] %}
{% endif %}

{{ return(results_list) }}

{% endmacro %}


{% macro get_payment_methods() %}

{# {{ return(["bank_transfer", "credit_card", "gift_card"]) }}      -- hardcoded, not-optimal macro #}

{{ return(get_column_values('payment_method', ref('raw_payments'))) }}

{% endmacro %}