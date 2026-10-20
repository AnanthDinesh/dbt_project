{{ config(materialized='table') }}

SELECT
    COALESCE(COUNTRY, 'Unknown') AS COUNTRY,
    COUNT(*) AS CUSTOMER_COUNT,
    COUNT(DISTINCT CITY) AS CITY_COUNT

FROM {{ ref('stg_customers') }}

GROUP BY
    COALESCE(COUNTRY, 'Unknown')