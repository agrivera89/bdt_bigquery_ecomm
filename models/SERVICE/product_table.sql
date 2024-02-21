{{config(materialized='table')}}

SELECT
 oi.ORDER_ID AS ORDER_ID,
 oi.ORDER_ITEM_ID AS ORDER_ITEM_ID,
 oi.PRODUCT_ID AS PRODUCT_ID,
 COALESCE(p.PRODUCT_CATEGORY_NAME, 'SIN CATEGORIA') as PRODUCT_CATEGORY_NAME,
 oi.SELLER_ID AS SELLER_ID,
 oi.SHIPPING_LIMIT_DATE AS SHIPPING_LIMIT_DATE,
 oi.PRICE AS PRICE,
 oi.FREIGHT_VALUE AS FREIGHT_VALUE
FROM {{ref('order_items')}} AS oi
    LEFT JOIN {{ref('products')}} AS p
    ON oi.PRODUCT_ID = p.PRODUCT_ID