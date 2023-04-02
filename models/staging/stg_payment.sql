
with source as (
select * from raw.stripe.payment ),

renamed as (

    select id as payment_id,
    ORDERID,
    amount/100 as amount -- cents / /dollors
    from source

)

select * from renamed