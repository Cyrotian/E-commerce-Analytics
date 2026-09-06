{% snapshot customers_check_scd %}

{{
    config(
        schema='snapshots',
        unique_key='customer_unique_id',
        strategy='check',
        check_cols=['customer_zip_code_prefix', 'customer_city','customer_state']
    )
}}

SELECT * FROM {{ ref('int_customer_record_latest') }}



{% endsnapshot %}