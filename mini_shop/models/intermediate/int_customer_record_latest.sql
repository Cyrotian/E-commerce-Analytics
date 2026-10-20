{{config(materialized='ephemeral')}}



select * from  (
	SELECT order_id, 
		o.customer_id,
		order_purchase_timestamp,
		c.customer_unique_id,
		c.customer_zip_code_prefix, 
		c.customer_city, 
		c.customer_state, 
		row_number() over (partition by C.customer_unique_id order by order_purchase_timestamp desc ) as latest_order
	FROM {{ ref('stg_orders') }} as o
	INNER JOIN {{ ref('stg_customers') }} as c on c.customer_id = o.customer_id
)
where latest_order = 1


