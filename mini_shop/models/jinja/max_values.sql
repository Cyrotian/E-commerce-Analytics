{% set payment_col = ["payment_value", "payment_installments", "payment_sequential"] %}


SELECT
    {% for payment in payment_col%}
        {% if loop.last %}
            MAX({{payment}}) AS max_{{payment}}
        {% else %}
            MAX({{payment}}) AS max_{{payment}},
        {% endif%}
    {% endfor %}
FROM
    {{ ref ('stg_payments')}}