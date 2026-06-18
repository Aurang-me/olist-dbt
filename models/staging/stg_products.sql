with source as (
    select * from {{ source('raw', 'products') }}
),

cleaned as (
    select
        product_id,
        product_category_name                           as category_name,
        cast(product_name_length as int)                as name_length,
        cast(product_description_length as int)         as description_length,
        cast(product_photos_qty as int)                 as photos_qty,
        cast(product_weight_g as int)                   as weight_g,
        cast(product_length_cm as int)                  as length_cm,
        cast(product_height_cm as int)                  as height_cm,
        cast(product_width_cm as int)                   as width_cm
    from source
    where product_id is not null
)

select * from cleaned
