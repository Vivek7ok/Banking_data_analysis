-- ============================================
-- 06_Card_Analysis.sql
-- Card Analysis
-- ============================================

-- Total spending by card type.
SELECT card_type, SUM(amount) AS total_spending
FROM cards AS c
JOIN card_transactions AS ct ON c.card_id = ct.card_id
GROUP BY card_type;

-- Merchant category with highest spending.
SELECT merchant_category, SUM(amount) AS total_amount
FROM card_transactions
GROUP BY merchant_category
ORDER BY total_amount DESC
LIMIT 1;

-- Fraud transaction percentage.
SELECT
    is_fraud,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM card_transactions), 2) AS percentage
FROM card_transactions
GROUP BY is_fraud;

-- Top customers by card spending.
SELECT name, SUM(amount) AS total_amount
FROM customers AS c
JOIN cards AS ca ON ca.customer_id = c.customer_id
JOIN card_transactions AS ct ON ca.card_id = ct.card_id
GROUP BY name
ORDER BY total_amount DESC
LIMIT 5;

-- Most common fraud merchant category.
SELECT merchant_category, COUNT(*) AS number_of_frauds
FROM card_transactions
WHERE is_fraud = 1
GROUP BY merchant_category
ORDER BY number_of_frauds DESC
LIMIT 1;
