
{% macro calculate_discount(price_column, discount_rate) %}
    {{ price_column }} - ( {{ price_column }} * {{ discount_rate }})
{% endmacro %}
