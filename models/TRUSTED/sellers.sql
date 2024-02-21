{{ config(materialized="table") }}

SELECT
 SELLER_ID,
 SELLER_ZIP_CODE_PREFIX,
 UPPER(TRIM(SELLER_CITY)) AS SELLER_CITY,
 SELLER_STATE
from {{ source("ecommerce_raw", "sellers") }}
WHERE SELLER_ID IS NOT NULL