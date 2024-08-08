with 
    src_customers as (
        select
            cast(CUSTOMERID as int) as pk_customer
            , cast(PERSONID as int) as fk_person
            , cast(STOREID as int) as fk_store
            , case 
                when fk_store is null then 'Person'
                when fk_store is not null then 'Store'
            end as customer_type
            --TERRITORYID
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'customer') }}
        where PERSONID is not null -- Excluding duplicated values in STOREID field.
    )
select *
from src_customers