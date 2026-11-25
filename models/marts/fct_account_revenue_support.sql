SELECT
    a.account_id,
    a.company_name,
    a.region,
    m.total_subscriptions,
    m.active_mrr,
    m.active_seats,
    m.total_tickets,
    m.open_tickets,
    CASE
        WHEN m.active_seats > 0 THEN ROUND(m.active_mrr / m.active_seats, 2)
        ELSE 0
    END AS arpu_per_seat
FROM {{ ref('stg_accounts') }} a
LEFT JOIN {{ ref('int_account_metrics') }} m
    ON a.account_id = m.account_id
