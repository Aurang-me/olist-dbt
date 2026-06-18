with orders as (
    select * from {{ ref('stg_orders') }}
),

order_items as (
    select
        order_id,
        count(order_item_id)                        as total_items,
        sum(price)                                  as total_items_value,
        sum(freight_value)                          as total_freight_value,
        sum(price + freight_value)                  as total_order_value
    from {{ ref('stg_order_items') }}
    group by order_id
),

payments as (
    select
        order_id,
        sum(payment_value)                          as total_payment_value,
        count(distinct payment_type)                as payment_methods_used,
        max(payment_installments)                   as max_installments
    from {{ ref('stg_payments') }}
    group by order_id
),

reviews as (
    select
        order_id,
        avg(cast(review_score as float))            as avg_review_score,
        max(review_score)                           as max_review_score,
        count(review_score)                         as total_reviews
    from {{ ref('stg_reviews') }}
    group by order_id
),

final as (
    select
        o.order_id,
        o.customer_id,
        o.order_status,
        o.ordered_at,
        o.approved_at,
        o.shipped_at,
        o.delivered_at,
        o.estimated_delivery_at,

        -- delivery metrics
        datediff(day, o.ordered_at, o.delivered_at)         as days_to_deliver,
        datediff(day, o.delivered_at,
            o.estimated_delivery_at)                        as delivery_vs_estimate,

        -- item metrics
        coalesce(oi.total_items, 0)                         as total_items,
        coalesce(oi.total_items_value, 0)                   as total_items_value,
        coalesce(oi.total_freight_value, 0)                 as total_freight_value,
        coalesce(oi.total_order_value, 0)                   as total_order_value,

        -- payment metrics
        coalesce(p.total_payment_value, 0)                  as total_payment_value,
        coalesce(p.payment_methods_used, 0)                 as payment_methods_used,
        coalesce(p.max_installments, 0)                     as max_installments,

        -- review metrics
        r.avg_review_score,
        r.max_review_score,
        r.total_reviews

    from orders o
    left join order_items oi    on o.order_id = oi.order_id
    left join payments p        on o.order_id = p.order_id
    left join reviews r         on o.order_id = r.order_id
)

select * from final
