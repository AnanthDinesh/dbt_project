{{ config(materialized='table') }}

WITH cleaned_customers AS (

    SELECT
        CUSTOMER_ID,
        NULLIF(TRIM(CUSTOMER_NAME), '') AS CUSTOMER_NAME,
        NULLIF(TRIM(CITY), '') AS CITY,
        NULLIF(TRIM(COUNTRY), '') AS COUNTRY

    FROM {{ source('raw', 'CUSTOMERS') }}

    WHERE CUSTOMER_ID IS NOT NULL
)

SELECT
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CITY,
    COUNTRY

FROM cleaned_customers

QUALIFY ROW_NUMBER() OVER (
    PARTITION BY CUSTOMER_ID
    ORDER BY CUSTOMER_NAME, CITY, COUNTRY
) = 1