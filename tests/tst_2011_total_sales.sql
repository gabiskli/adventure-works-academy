/*  
    This test guarantees that 2011 sales are correct
    according to accounting. 
*/

{{
    config(
        severity = 'error'
    )
}}

with
    sales_in_2011 as (
        select sum(total_sold) as total_sold
        from {{ ref('fct_sales') }}
        where dt_order between '2011-01-01' and '2011-12-31'
    ) -- R$ 12646112.1607

select total_sold
from sales_in_2011
where total_sold not between 12646112.1107 and 12646112.2107