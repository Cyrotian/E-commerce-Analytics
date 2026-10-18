{% set include_cancelled =  false %}


SELECT * 
    FROM {{ ref('stg_orders')}} as o
    {% if not include_cancelled %}
        WHERE o.order_status != 'cancelled'
    {% endif %}
