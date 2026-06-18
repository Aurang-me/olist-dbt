with sellers as (
    select * from {{ ref('stg_sellers') }}
),

order_items as (
    select
        seller_id,
        count(distinct order_id)                    as total_orders,
        sum(price)                                  as total_revenue,
        avg(price)                                  as avg_order_value
    from {{ ref('stg_order_items') }}
    group by seller_id
)

select
    s.seller_id,
    s.city,
    s.state,
    s.zip_code,
    coalesce(oi.total_orders, 0)                    as total_orders,
    coalesce(oi.total_revenue, 0)                   as total_revenue,
    oi.avg_order_value
from sellers s
left join order_items oi
    on s.seller_id = oi.seller_id
