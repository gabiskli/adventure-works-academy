with 
    orders as (
        select *
        from {{ ref('stg_erp__sales_orders') }}
    )
    , order_details as (
        select *
        from {{ ref('stg_erp__sales_orders_detail') }}
    )
    , credit_card as (
        select *
        from {{ ref('stg_erp__credit_cards') }}
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
            , credit_card.card_type
            , order_details.UNIT_PRICE
            , order_details.DISCOUNT
            , order_details.QUANTITY
            , orders.TAX_AMOUNT
            , orders.FREIGHT
        from order_details
        left join orders
            on order_details.fk_order = orders.pk_order
        left join credit_card
            on orders.FK_CARD = credit_card.pk_credit_card
    )
    , metrics as (
        select
            PK_ORDER_DETAIL
            , fk_order
            , FK_CUSTOMER
            , FK_TERRITORY
            , FK_PRODUCT
            , DT_ORDER
            , DT_DUE
            , STATUS
            , case 
                when CARD_TYPE is null then 'Other'
                else CARD_TYPE
            end as CARD_TYPE
            , UNIT_PRICE
            , DISCOUNT
            , QUANTITY
            , unit_price * quantity as total_sold
            , unit_price * (1 - discount) * quantity as net_total_sold
            , freight / count(*) over (partition by fk_order)::numeric(18,4) as prorated_freight
            , (tax_amount 
                * total_sold 
                / sum(total_sold) over (partition by fk_order))::numeric(18,4) as prorated_taxes
            , (unit_price 
                * (1 - discount) 
                * quantity)
                + freight / count(*) over (partition by fk_order)
                + tax_amount / count(*) over (partition by fk_order)::numeric(18,4)
            as profit
            , sum(unit_price * (1 - discount) * quantity) over (partition by fk_order) 
            / count(*) over (partition by fk_order) as ticket
            , datediff(day, dt_order, dt_due) as expected_lead_time
        from joined
    )
select *
from metrics