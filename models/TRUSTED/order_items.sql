{{ config(materialized="table") }}

SELECT
    ORDER_ID,
    ORDER_ITEM_ID,
    PRODUCT_ID,
    SELLER_ID,
    SHIPPING_LIMIT_DATE,
    PRICE,
    FREIGHT_VALUE
from {{ source("ecommerce_raw", "order_items") }}
WHERE ORDER_ID IS NOT NULL
 AND ORDER_ITEM_ID IS NOT NULL