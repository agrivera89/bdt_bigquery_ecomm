{{ config(materialized="table") }}

SELECT
 REVIEW_ID,
 ORDER_ID,
 REVIEW_SCORE,
 REVIEW_COMMENT_TITLE,
 REVIEW_COMMENT_MESSAGE,
 REVIEW_CREATION_DATE,
 REVIEW_ANSWER_TIMESTAMP
from {{ source("ecommerce_raw", "order_reviews") }}
WHERE REVIEW_ID IS NOT NULL