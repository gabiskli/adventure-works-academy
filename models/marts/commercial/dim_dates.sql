{{
    config(
        materialized = "table"
    )
}}

with raw_dates as (
    {{ dbt_date.get_date_dimension("2011-01-01", "2014-12-31") }}
    )
    , selected_columns as (
        select
            DATE_DAY as pk_date
            , DAY_OF_WEEK_ISO as day_of_week_number --Monday = 1 and Sunday = 7
            , DAY_OF_WEEK_NAME as day_of_week
            , DAY_OF_WEEK_NAME_SHORT as day_of_week_short
            , DAY_OF_MONTH
            , DAY_OF_YEAR
            , ISO_WEEK_START_DATE as week_start_date
            , ISO_WEEK_END_DATE as week_end_sate
            , MONTH_OF_YEAR
            , MONTH_NAME
            , MONTH_NAME_SHORT
            , YEAR_NUMBER
            --, DAY_OF_WEEK
            --, WEEK_START_DATE
            --, WEEK_END_DATE
            --, WEEK_OF_YEAR
            --, ISO_WEEK_OF_YEAR
            --, MONTH_START_DATE
            --, MONTH_END_DATE
            --, QUARTER_OF_YEAR
            --, QUARTER_START_DATE
            --, QUARTER_END_DATE
            --PRIOR_DATE_DAY
            --NEXT_DATE_DAY
            --PRIOR_YEAR_DATE_DAY
            --PRIOR_YEAR_OVER_YEAR_DATE_DAY
            --PRIOR_YEAR_WEEK_START_DATE
            --PRIOR_YEAR_WEEK_END_DATE
            --prior_year_iso_week_start_date
            --PRIOR_YEAR_WEEK_OF_YEAR
            --PRIOR_YEAR_ISO_WEEK_OF_YEAR
            --PRIOR_YEAR_MONTH_START_DATE
            --PRIOR_YEAR_MONTH_END_DATE
            --YEAR_START_DATE
            --YEAR_END_DATE
        from raw_dates
    )
select *
from selected_columns
