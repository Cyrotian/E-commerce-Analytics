{% set min_order_value = 50 %}

SELECT so.order_id, p.payment_value
FROM {{ ref('stg_orders') }} as so
INNER JOIN {{ ref('stg_payments')}} as p
ON so.order_id = p.order_id
WHERE p.payment_value >=  {{min_order_value}}