with 
    src_sales_orders_detail as (
        select
            cast(SALESORDERID as int) as fk_order
            , cast(SALESORDERDETAILID  as int) as pk_order_detail
            , cast(ORDERQTY as int) as quantity
            , cast(PRODUCTID as int) as fk_product
            , cast(UNITPRICE as numeric(18,4)) as unit_price
            , cast(UNITPRICEDISCOUNT as numeric(18,4)) as discount
            --CARRIERTRACKINGNUMBER
            --SPECIALOFFERID
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'salesorderdetail') }}
    )
select *
from src_sales_orders_detail