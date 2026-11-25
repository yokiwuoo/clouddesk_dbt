SELECT
    CAST(subscription_id AS INTEGER) AS subscription_id,
    CAST(account_id AS INTEGER) AS account_id,
    LOWER(TRIM(plan)) AS plan,
    CAST(seats AS INTEGER) AS seats,
    CAST(mrr AS DECIMAL(10, 2)) AS mrr,
    LOWER(TRIM(status)) AS status,
    CAST(started_at AS TIMESTAMP) AS started_at,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM {{ source('clouddesk_raw', 'mp2_subscriptions') }}
WHERE subscription_id IS NOT NULL
