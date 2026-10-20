{{ config(materialized='table') }}

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    COUNTRY
FROM {{ source('raw', 'CUSTOMERS') }}