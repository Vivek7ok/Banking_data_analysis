-- ============================================
-- 09_Risk_Analysis.sql
-- Risk Analysis
-- ============================================

-- Identify high-risk customers
-- (low credit score + large loan + history of late payment).
SELECT
    c.name,
    c.credit_score,
    l.loan_amount,
    'High Risk' AS risk_level
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
WHERE c.credit_score < 500
  AND l.loan_amount > 300000
  AND EXISTS (
      SELECT 1
      FROM loan_payments lp
      WHERE lp.loan_id = l.loan_id
        AND lp.late_payment_flag = 1
  );

-- Find customers likely to default.
-- NOTE: this uses the same risk criteria as the query above (low credit
-- score, large loan, at least one late payment) — kept separate since it
-- returns customer_id for downstream use instead of a display label.
SELECT
    c.customer_id,
    c.name,
    c.credit_score,
    l.loan_amount
FROM customers c
JOIN loans l ON c.customer_id = l.customer_id
WHERE c.credit_score < 500
  AND l.loan_amount > 300000
  AND EXISTS (
      SELECT 1
      FROM loan_payments lp
      WHERE lp.loan_id = l.loan_id
        AND lp.late_payment_flag = 1
  );

-- Calculate loan recovery rate.
SELECT
    ROUND(SUM(p.total_paid) * 100.0 / SUM(l.loan_amount), 2) AS loan_recovery_rate
FROM loans l
JOIN (
    SELECT loan_id, SUM(amount_paid) AS total_paid
    FROM loan_payments
    GROUP BY loan_id
) p ON l.loan_id = p.loan_id;
