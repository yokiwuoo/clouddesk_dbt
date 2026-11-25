SELECT
    CAST(ticket_id AS INTEGER) AS ticket_id,
    CAST(account_id AS INTEGER) AS account_id,
    CAST(opened_at AS TIMESTAMP) AS opened_at,
    CAST(closed_at AS TIMESTAMP) AS closed_at,
    LOWER(TRIM(priority)) AS priority,
    LOWER(TRIM(category)) AS category,
    LOWER(TRIM(status)) AS status,
    CAST(updated_at AS TIMESTAMP) AS updated_at
FROM {{ source('clouddesk_raw', 'mp2_tickets') }}
WHERE ticket_id IS NOT NULL
