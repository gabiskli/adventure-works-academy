with 
    sales_person as (
        select *
        from {{ ref('stg_erp__sales_person') }}
    )
    , people as (
        select *
        from {{ ref('stg_erp__people') }}
    )
    , joined as (
        select
            sales_person.PK_VENDOR
            , people.PERSON_NAME as vendor_name
        from sales_person
        left join people
            on sales_person.pk_vendor = people.pk_people
    )
select *
from joined