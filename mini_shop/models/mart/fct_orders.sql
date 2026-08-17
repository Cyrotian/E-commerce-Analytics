{{config(materialized = "incremental",
        unique_key='order_id'   
)}}


SELECT *
FROM {{ ref('stg_orders') }} as orders

{% if is_incremental() %}
    WHERE order_purchase_timestamp > (select coalesce(max(order_purchase_timestamp)) from {{ this }})
{% endif %}

