-- 自定义业务规则测试：
-- 业务含义：任何处于 active 状态的订阅，其月经常性收入 (MRR) 必须大于 0 且席位数 (seats) 必须至少为 1。
-- 若返回任何行，说明存在免费激活或零席位异常订阅数据，测试将失败。
SELECT
    subscription_id,
    account_id,
    plan,
    seats,
    mrr,
    status
FROM {{ ref('stg_subscriptions') }}
WHERE status = 'active'
  AND (mrr <= 0 OR seats <= 0)
