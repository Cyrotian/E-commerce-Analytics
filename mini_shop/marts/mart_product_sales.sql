{{config(materialized='ephemeral')}}

SELECT
    Product_category,
    count(*) as items_sold,
    sum(price) as total_revenue
from {{ ref('int_order_items_enriched') }}
group by product_category