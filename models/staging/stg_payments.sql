with source as (
    select * from {{ source('raw', 'payments') }}
),

cleaned as (
    select
        order_id,
        cast(payment_sequential as int)             as payment_sequential,
        payment_type,
        cast(payment_installments as int)           as payment_installments,
        cast(payment_value as float)                as payment_value
    from source
    where order_id is not null
)

select * from cleaned
