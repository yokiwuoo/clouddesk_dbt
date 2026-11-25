SELECT
    CAST(account_id AS INTEGER) AS account_id,
    TRIM(company_name) AS company_name,
    LOWER(TRIM(industry)) AS industry,
    UPPER(TRIM(region)) AS region,
    CAST(signup_date AS DATE) AS signup_date,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM {{ source('clouddesk_raw', 'mp2_accounts') }}
WHERE account_id IS NOT NULL
