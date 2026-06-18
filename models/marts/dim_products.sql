with products as (
    select * from {{ ref('stg_products') }}
),

order_items as (
    select
        product_id,
        count(order_id)                             as total_orders,
        avg(price)                                  as avg_price,
        min(price)                                  as min_price,
        max(price)                                  as max_price
    from {{ ref('stg_order_items') }}
    group by product_id
)

select
    p.product_id,
    p.category_name,
    p.weight_g,
    p.length_cm,
    p.height_cm,
    p.width_cm,
    p.photos_qty,
    coalesce(oi.total_orders, 0)                    as total_orders,
    oi.avg_price,
    oi.min_price,
    oi.max_price
from products p
left join order_items oi
    on p.product_id = oi.product_id
