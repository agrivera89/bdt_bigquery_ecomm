{{ config(materialized="table") }}

SELECT *
from {{ source("ecommerce_raw", "sellers") }}