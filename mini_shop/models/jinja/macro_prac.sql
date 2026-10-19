{% set discount_rate = 0.3 %}

SELECT
    p.payment_value AS "Original payment",
    ({{ discount_rate }} * 100) AS discount,
    {{ calculate_discount('p.payment_value', discount_rate) }} AS "Final payment"
FROM {{ ref('stg_payments') }} AS p