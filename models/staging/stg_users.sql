SELECT
    CAST(user_id AS INTEGER) AS user_id,
    CAST(account_id AS INTEGER) AS account_id,
    LOWER(TRIM(email)) AS email,
    LOWER(TRIM(role)) AS role,
    CAST(created_at AS TIMESTAMP) AS created_at,
    CAST(last_login AS TIMESTAMP) AS last_login,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM {{ source('clouddesk_raw', 'mp2_users') }}
WHERE user_id IS NOT NULL
