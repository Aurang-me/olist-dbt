CREATE EXTERNAL TABLE dbt_dev.orders (
    order_id NVARCHAR(50),
    customer_id NVARCHAR(50),
    order_status NVARCHAR(50),
    order_purchase_timestamp NVARCHAR(50),
    order_approved_at NVARCHAR(50),
    order_delivered_carrier_date NVARCHAR(50),
    order_delivered_customer_date NVARCHAR(50),
    order_estimated_delivery_date NVARCHAR(50)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'orders/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.order_items (
    order_id NVARCHAR(50),
    order_item_id NVARCHAR(10),
    product_id NVARCHAR(50),
    seller_id NVARCHAR(50),
    shipping_limit_date NVARCHAR(50),
    price NVARCHAR(20),
    freight_value NVARCHAR(20)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'items/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.customers (
    customer_id NVARCHAR(50),
    customer_unique_id NVARCHAR(50),
    customer_zip_code_prefix NVARCHAR(10),
    customer_city NVARCHAR(100),
    customer_state NVARCHAR(10)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'customers/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.products (
    product_id NVARCHAR(50),
    product_category_name NVARCHAR(100),
    product_name_length NVARCHAR(20),
    product_description_length NVARCHAR(20),
    product_photos_qty NVARCHAR(20),
    product_weight_g NVARCHAR(20),
    product_length_cm NVARCHAR(20),
    product_height_cm NVARCHAR(20),
    product_width_cm NVARCHAR(20)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'products/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.payments (
    order_id NVARCHAR(50),
    payment_sequential NVARCHAR(20),
    payment_type NVARCHAR(50),
    payment_installments NVARCHAR(20),
    payment_value NVARCHAR(20)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'payments/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.reviews (
    review_id NVARCHAR(50),
    order_id NVARCHAR(50),
    review_score NVARCHAR(10),
    review_comment_title NVARCHAR(100),
    review_comment_message NVARCHAR(MAX),
    review_creation_date NVARCHAR(50),
    review_answer_timestamp NVARCHAR(50)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'reviews/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.sellers (
    seller_id NVARCHAR(50),
    seller_zip_code_prefix NVARCHAR(10),
    seller_city NVARCHAR(100),
    seller_state NVARCHAR(10)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'sellers/',
    FILE_FORMAT = parquet_format
);

CREATE EXTERNAL TABLE dbt_dev.geolocation (
    geolocation_zip_code_prefix NVARCHAR(10),
    geolocation_lat NVARCHAR(20),
    geolocation_lng NVARCHAR(20),
    geolocation_city NVARCHAR(100),
    geolocation_state NVARCHAR(10)
)
WITH (
    DATA_SOURCE = silver_adls,
    LOCATION = 'geolocations/',
    FILE_FORMAT = parquet_format
);
