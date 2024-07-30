with
    reason as (
        select *
        from {{ ref('stg_erp__sales_reason') }}
    )
    , order_reason as (
        select *
        from {{ ref('stg_erp__sales_order_reason') }}
    )
    , joined as (
        select
            reason.PK_REASON
            , order_reason.FK_ORDER 
            , reason.REASON_NAME
            , reason.REASON_TYPE
            , row_number() over (partition by order_reason.fk_order order by reason.pk_reason) as num_rows 
        from order_reason
        left join reason
            on order_reason.fk_reason = reason.pk_reason
    )
    , deduplicate as (
        select
            PK_REASON
            , FK_ORDER
            , REASON_NAME
            , REASON_TYPE
        from joined
        where num_rows = 1
    )
select *
from deduplicate