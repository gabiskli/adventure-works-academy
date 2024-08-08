with 
    src_sales_orders as (
        select
            cast(SALESORDERID as int) as pk_order
            , cast(ORDERDATE as datetime)::date as dt_order
            , cast(DUEDATE as datetime)::date as dt_due
            , cast(CUSTOMERID as int) as fk_customer
            , cast(BILLTOADDRESSID as int) as fk_territory
            , cast(CREDITCARDID as int) as fk_card
            , cast(SUBTOTAL as numeric(18,4)) as gross_profit
            , cast(TAXAMT as numeric(18,4)) as tax_amount
            , cast(FREIGHT as numeric(18,4)) as freight
            , cast(TOTALDUE as numeric(18,4)) as net_profit
            , case
                when SALESPERSONID::int is null then 0
                else SALESPERSONID::int
            end as fk_vendor
            , case
                when status = 1 then 'In progress'
                when status = 2 then 'Approved'
                when status =3 then 'Backordered'
                when status = 4 then 'Rejected'
                when status = 5 then 'Shipped'
                when status = 6 then 'Cancelled'
                else null
            end as status
            , case 
                when ONLINEORDERFLAG = 'True' then 'Online'
                when ONLINEORDERFLAG = 'False' then 'Vendor'
            end as order_type
            --REVISIONNUMBER
            --SHIPDATE
            --PURCHASEORDERNUMBER
            --ACCOUNTNUMBER
            --TERRITORYID
            --SHIPTOADDRESSID
            --SHIPMETHODID
            --CREDITCARDAPPROVALCODE
            --CURRENCYRATEID
            --COMMENT
            --ROWGUID
            --MODIFIEDDATE
        from {{ source('erp', 'salesorderheader') }}
    )
select *
from src_sales_orders