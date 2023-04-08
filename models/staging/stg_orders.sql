
with source as (
select * from raw.jaffle_shop.orders ),

renamed as (

    select id as order_id,
    user_id as customer_id,
    status,
    order_date
    from source

)

select * from renamed