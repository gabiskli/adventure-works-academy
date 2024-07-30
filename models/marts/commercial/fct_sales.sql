with 
    dim_product as (
        select *
        from {{ ref('dim_products') }}
    )
    , dim_customers as (
        select *
        from {{ ref('dim_customers') }}
    )
    , dim_territories as (
        select *
        from {{ ref('dim_territories') }}
    )
    , dim_sales_reason as (
        select *
        from {{ ref('dim_sales_reason') }}
    )
    , int_sales as (
        select *
        from {{ ref('int_commercial__sales_order_detail') }}
    )
    , joined as (
        select *
        from int_sales
    )
select *
from joined