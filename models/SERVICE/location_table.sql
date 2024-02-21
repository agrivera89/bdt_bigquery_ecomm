{{config(materialized='table')}}

WITH customers_geo_table AS (
SELECT
    c.CUSTOMER_ID AS CUSTOMER_ID,
    c.CUSTOMER_UNIQUE_ID AS CUSTOMER_UNIQUE_ID,
    c.CUSTOMER_ZIP_CODE_PREFIX AS ZIP_CODE_PREFIX,
    c.CUSTOMER_CITY AS CITY,
    c.CUSTOMER_STATE AS STATE,
    g.GEOLOCATION_LAT AS LAT,
    g.GEOLOCATION_LNG AS LNG,
    ROW_NUMBER() OVER (PARTITION BY C.CUSTOMER_ID ORDER BY g.GEOLOCATION_ZIP_CODE_PREFIX) AS  value_count
FROM {{ref('customers')}} AS c
    LEFT JOIN {{ref('geolocation')}} AS g
    ON c.CUSTOMER_ZIP_CODE_PREFIX = g.GEOLOCATION_ZIP_CODE_PREFIX
)
SELECT 
    CUSTOMER_ID,
    CUSTOMER_UNIQUE_ID,
    ZIP_CODE_PREFIX,
    CITY,
    STATE,
    LAT,
    LNG,
    value_count
FROM customers_geo_table
WHERE  value_count = 1
 AND CITY IS NOT NULL
ORDER BY value_count
