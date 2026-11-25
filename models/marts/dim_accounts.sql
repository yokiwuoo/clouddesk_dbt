SELECT
    a.account_id,
    a.company_name,
    a.industry,
    a.region,
    a.signup_date,
    m.total_users,
    m.admin_users,
    CASE
        WHEN m.active_mrr >= 1000 THEN 'Enterprise'
        WHEN m.active_mrr >= 200 THEN 'Mid-Market'
        ELSE 'SMB'
    END AS account_tier
FROM {{ ref('stg_accounts') }} a
LEFT JOIN {{ ref('int_account_metrics') }} m
    ON a.account_id = m.account_id
