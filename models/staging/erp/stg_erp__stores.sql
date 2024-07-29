with 
    src_stores as (
        select
            cast(BUSINESSENTITYID as int) as pk_store
            , cast(NAME as varchar) as store_name
            --SALESPERSONID these columns will not be used
            --DEMOGRAPHICS
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'store') }}
    )
select *
from src_stores