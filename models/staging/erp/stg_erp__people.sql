with 
    src_people as (
        select 
            cast(BUSINESSENTITYID as int) as pk_people
            , cast(PERSONTYPE as varchar) as person_type
            , cast(FIRSTNAME as varchar) || ' ' || cast(LASTNAME as varchar) as person_name
            -- Keep the western starndard name even if the namestyle is eastern.
            -- NAMESTYLE
            --TITLE
            --MIDDLENAME
            --SUFFIX
            --EMAILPROMOTION
            --ADDITIONALCONTACTINFO
            --DEMOGRAPHICS
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'person') }}
    )
select *
from src_people