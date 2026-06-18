with source as (
    select * from {{ source('raw', 'reviews') }}
),

cleaned as (
    select
        review_id,
        order_id,
        cast(review_score as int)                       as review_score,
        review_comment_title                            as comment_title,
        review_comment_message                          as comment_message,
        cast(review_creation_date as datetime2)         as review_created_at,
        cast(review_answer_timestamp as datetime2)      as review_answered_at
    from source
    where review_id is not null
),

deduped as (
    select *,
        row_number() over (
            partition by review_id
            order by review_answered_at desc
        ) as row_num
    from cleaned
)

select * from deduped
where row_num = 1