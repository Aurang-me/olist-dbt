with source as (
    select * from {{ source('raw', 'orders') }}
),

cleaned as (
    select
        order_id,
        customer_id,
        order_status,
        cast(order_purchase_timestamp as datetime2)   as ordered_at,
        cast(order_approved_at as datetime2)          as approved_at,
        cast(order_delivered_carrier_date as datetime2) as shipped_at,
        cast(order_delivered_customer_date as datetime2) as delivered_at,
        cast(order_estimated_delivery_date as datetime2) as estimated_delivery_at
    from source
    where order_id is not null
)

select * from cleaned