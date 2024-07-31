with 
    src_credit_cards as (
        select
            cast(CREDITCARDID as int) as pk_credit_card
            , cast(CARDTYPE as varchar) as card_type
            --CARDNUMBER these columns won't be used
            --EXPMONTH
            --EXPYEAR
            --MODIFIEDDATE
        from {{ source('erp', 'creditcard') }}
    )
select *
from src_credit_cards