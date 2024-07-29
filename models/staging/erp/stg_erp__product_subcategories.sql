with 
    src_product_subcategories as (
        select 
            cast(PRODUCTSUBCATEGORYID as int) as pk_product_subcategory
            , cast(PRODUCTCATEGORYID as int) as fk_product_category
            , cast(NAME as varchar) as subcategory_name
            , cast(MODIFIEDDATE as datetime) as dt_modified
            --ROWGUID will not be needed
        from {{ source('erp', 'productsubcategory') }}
    )
select *
from src_product_subcategories