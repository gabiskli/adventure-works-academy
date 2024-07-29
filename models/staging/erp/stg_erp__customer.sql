with 
    src_customers as (
        select
            cast(CUSTOMERID as int) as pk_customer
            , cast(PERSONID as int) as fk_person
            , cast(STOREID as int) as fk_store
            --TERRITORYID
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'customer') }}
    )
select *
from src_customers