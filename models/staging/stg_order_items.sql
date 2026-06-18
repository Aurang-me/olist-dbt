with source as (
    select * from {{ source('raw', 'order_items') }}
),

cleaned as (
    select
        order_id,
        cast(order_item_id as int)                  as order_item_id,
        product_id,
        seller_id,
        cast(shipping_limit_date as datetime2)      as shipping_limit_date,
        cast(price as float)                        as price,
        cast(freight_value as float)                as freight_value
    from source
    where order_id is not null
)

select * from cleaned
