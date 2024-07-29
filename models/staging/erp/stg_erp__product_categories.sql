with 
    src_product_categories as (
        select
            cast(PRODUCTCATEGORYID as int) as pk_product_category
            , cast(NAME as varchar) as category_name
            , cast(MODIFIEDDATE as datetime) as dt_modified
            --ROWGUID
        from {{ source('erp', 'productcategory') }}
    )
select *
from src_product_categories