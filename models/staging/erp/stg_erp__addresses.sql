with 
    src_address as (
        select
            cast(ADDRESSID as int) as pk_address
           , cast(CITY as varchar) as city_name
           , cast(STATEPROVINCEID as int) as fk_state_code
            --SPATIALLOCATION
            --POSTALCODE this will not be used
            --ADDRESSLINE1
            --ADDRESSLINE2
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'address') }}
    )
select *
from src_address