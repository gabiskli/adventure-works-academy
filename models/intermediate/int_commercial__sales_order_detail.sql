with 
    orders as (
        select *
        from {{ ref('stg_erp__sales_orders') }}
    )
    , order_details as (
        select *
        from {{ ref('stg_erp__sales_orders_detail') }}
    )
    , joined as (
        select
            order_details.PK_ORDER_DETAIL
            , orders.PK_ORDER as fk_order
            , orders.FK_CUSTOMER
            , orders.FK_TERRITORY
            , order_details.FK_PRODUCT
            , orders.FK_CARD
            , orders.DT_ORDER
            , orders.DT_DUE
            , orders.STATUS
            , order_details.UNIT_PRICE
            , order_details.DISCOUNT
            , order_details.QUANTITY
            , orders.TAX_AMOUNT
            , orders.FREIGHT
        from order_details
        left join orders
            on order_details.fk_order = orders.pk_order
    )
    , metrics as (
        select
            PK_ORDER_DETAIL
            , fk_order
            , FK_CUSTOMER
            , FK_TERRITORY
            , FK_PRODUCT
            , FK_CARD
            , DT_ORDER
            , DT_DUE
            , STATUS
            , UNIT_PRICE
            , DISCOUNT
            , QUANTITY
            , unit_price * quantity as total_sold
            , unit_price * (1 - discount) * quantity as net_total_sold
            , freight / count(*) over (partition by fk_order) as prorated_freight
            , tax_amount / count(*) over (partition by fk_order) as prorated_taxes
            , (unit_price 
                * (1 - discount) 
                * quantity)
                + freight / count(*) over (partition by fk_order)
                + tax_amount / count(*) over (partition by fk_order)
            as profit 
        from joined
    )
select *
from metrics