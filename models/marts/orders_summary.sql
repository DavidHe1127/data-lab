{{ config(
    materialized='table',
    schema='SEMANTIC',
    alias='order_summary'
) }}

select
    c.customer_id,
    c.first_name,
    o.status,
    count(o.order_id) as total_orders
from {{ ref('stg_customers') }} as c
left join {{ ref('stg_orders') }} as o
    on c.customer_id = o.customer_id
where o.status is not null
group by c.customer_id, c.first_name, o.status
