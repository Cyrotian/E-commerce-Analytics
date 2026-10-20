{% set tax_rate = 0.20%}


SELECT p.order_id as order_number,p.payment_value,
     p.payment_value * (1 + {{tax_rate}}) as order_value_with_tax
FROM
{{ ref ('stg_orders')}} as so
INNER JOIN {{ ref ('stg_payments')}} as p
ON so.order_id = p.order_id