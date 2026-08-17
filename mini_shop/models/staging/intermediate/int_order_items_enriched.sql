{{config(materialized='ephemeral')}}

SELECT
    oi.*,
    p.product_category
from {{ ref('stg_order_items') }} as oi
left join {{ ref('stg_products') }} as p 
    on oi.product_id = p.product_id