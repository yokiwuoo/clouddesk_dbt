WITH sub_agg AS (
    SELECT
        account_id,
        COUNT(subscription_id) AS total_subscriptions,
        SUM(CASE WHEN status = 'active' THEN mrr ELSE 0 END) AS active_mrr,
        SUM(CASE WHEN status = 'active' THEN seats ELSE 0 END) AS active_seats
    FROM {{ ref('stg_subscriptions') }}
    GROUP BY account_id
),
user_agg AS (
    SELECT
        account_id,
        COUNT(user_id) AS total_users,
        COUNT(CASE WHEN role = 'admin' THEN 1 END) AS admin_users
    FROM {{ ref('stg_users') }}
    GROUP BY account_id
),
ticket_agg AS (
    SELECT
        account_id,
        COUNT(ticket_id) AS total_tickets,
        COUNT(CASE WHEN status IN ('open', 'pending') THEN 1 END) AS open_tickets
    FROM {{ ref('stg_tickets') }}
    GROUP BY account_id
)
SELECT
    a.account_id,
    COALESCE(s.total_subscriptions, 0) AS total_subscriptions,
    COALESCE(s.active_mrr, 0) AS active_mrr,
    COALESCE(s.active_seats, 0) AS active_seats,
    COALESCE(u.total_users, 0) AS total_users,
    COALESCE(u.admin_users, 0) AS admin_users,
    COALESCE(t.total_tickets, 0) AS total_tickets,
    COALESCE(t.open_tickets, 0) AS open_tickets
FROM {{ ref('stg_accounts') }} a
LEFT JOIN sub_agg s ON a.account_id = s.account_id
LEFT JOIN user_agg u ON a.account_id = u.account_id
LEFT JOIN ticket_agg t ON a.account_id = t.account_id
