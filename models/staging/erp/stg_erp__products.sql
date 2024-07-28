with 
    src_products as (
        select
            cast(PRODUCTID as int) as pk_product
            , cast(NAME as varchar) as product_name
            , cast(PRODUCTNUMBER as varchar) as product_number
            , cast(PRODUCTLINE as varchar) as product_line
            , cast(CLASS as varchar) as product_class
            , cast(STYLE as varchar) as product_style
            , cast(PRODUCTSUBCATEGORYID as int) as fk_product_subcategory
            , cast(MODIFIEDDATE as datetime) as dt_modified
            , case
                when DISCONTINUEDDATE is null then false
                when DISCONTINUEDDATE is not null then true
                else null
            end as is_discontinued
            --MAKEFLAG  -- this lines won't be used
            --FINISHEDGOODSFLAG
            --COLOR
            --SAFETYSTOCKLEVEL
            --REORDERPOINT
            --STANDARDCOST
            --LISTPRICE
           ---SIZE
            --SIZEUNITMEASURECODE
            --WEIGHTUNITMEASURECODE
            --WEIGHT
            --DAYSTOMANUFACTURE
            --PRODUCTMODELID
            --SELLSTARTDATE
            --SELLENDDATE
            -- ROWGUID
        from {{ source('erp', 'product') }}
    )
select *
from src_products