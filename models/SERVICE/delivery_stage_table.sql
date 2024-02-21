{{config(materialized='table')}}

SELECT
    ORDER_ID,
    CASE
        WHEN ORDER_APPROVED_AT IS NULL THEN 'creation_step'
        WHEN ORDER_APPROVED_AT IS NOT NULL 
            AND ORDER_DELIVERED_CARRIER_DATE IS NULL THEN 'approval_step'
        WHEN ORDER_APPROVED_AT IS NOT NULL
            AND ORDER_DELIVERED_CARRIER_DATE IS NOT NULL 
            AND ORDER_DELIVERED_CUSTOMER_DATE IS NULL THEN 'shipping_step'
        WHEN ORDER_DELIVERED_CUSTOMER_DATE IS NOT NULL THEN 'delivery_step'
        ELSE 'null'
    END AS delivery_stage
FROM {{ref('orders')}}