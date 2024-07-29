with 
    src_state as (
        select
            cast(STATEPROVINCEID as int) as pk_state_code
            , cast(STATEPROVINCECODE as varchar) as state_code 
            , cast(COUNTRYREGIONCODE as varchar) as fk_country_code
            , cast(NAME as varchar) as state_name
            --ISONLYSTATEPROVINCEFLAG this columns wil not be used
            --TERRITORYID
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'stateprovince') }}
    )
select *
from src_state