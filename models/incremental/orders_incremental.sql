{{ config(
    materialized="incremental",
) }}

select * from {{ source('jaffle_shop', 'orders') }} 

{% if is_incremental() %} 

where _ETL_LOADED_AT > (Select max(_ETL_LOADED_AT) from {{this}})

{% endif %}