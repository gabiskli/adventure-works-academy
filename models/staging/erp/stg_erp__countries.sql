with 
    src_country as (
        select
            cast(COUNTRYREGIONCODE as varchar) as pk_country_code
            , cast(NAME as varchar) as country_name
            -- MODIFIEDDATE this column will not be used
        from {{ source('erp', 'countryregion') }}
    )
select *
from src_country