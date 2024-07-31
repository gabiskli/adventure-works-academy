with 
    src_sales_reason as (
        select
        cast(SALESREASONID as int) as pk_reason
        , cast(NAME as varchar) as reason_name
        , cast(REASONTYPE as varchar) as reason_type
        --MODIFIEDDATE
        from {{ source('erp', 'salesreason') }}
    )
select *
from src_sales_reason