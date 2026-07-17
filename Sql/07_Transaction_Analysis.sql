-- ============================================
-- 07_Transaction_Analysis.sql
-- Transaction Analysis
-- ============================================

-- Average transaction amount.
SELECT ROUND(AVG(amount)::numeric, 2) AS avg_transaction_amount
FROM transactions;

-- Monthly transaction volume.
SELECT
    EXTRACT(YEAR FROM txn_date) AS txn_year,
    EXTRACT(MONTH FROM txn_date) AS txn_month,
    COUNT(transaction_id) AS transaction_count
FROM transactions
GROUP BY EXTRACT(YEAR FROM txn_date), EXTRACT(MONTH FROM txn_date)
ORDER BY txn_year, txn_month;

-- Most used transaction channel.
SELECT txn_type, COUNT(*) AS number_of_txn
FROM transactions
GROUP BY txn_type
ORDER BY number_of_txn DESC
LIMIT 1;

-- Top 10 accounts with highest transaction value.
SELECT account_id, SUM(amount) AS total_amount
FROM transactions
GROUP BY account_id
ORDER BY total_amount DESC
LIMIT 10;

-- Cash withdrawal vs deposit comparison.
SELECT
    CASE
        WHEN txn_type IN ('Deposit', 'Interest Credit', 'Transfer In') THEN 'Deposit'
        WHEN txn_type IN ('Withdrawal', 'Fee Debit', 'Transfer Out') THEN 'Withdrawal'
        ELSE 'Other'
    END AS transaction_category,
    SUM(amount) AS total_amount,
    ROUND(AVG(amount)::numeric, 2) AS average_amount
FROM transactions
GROUP BY transaction_category;

-- Monthly deposit vs withdrawal trend.
-- FIXED: original ORDER BY month only, which sorts incorrectly across
-- different years — added txn_year to the ORDER BY.
SELECT
    EXTRACT(YEAR FROM txn_date) AS txn_year,
    EXTRACT(MONTH FROM txn_date) AS txn_month,
    CASE
        WHEN txn_type IN ('Deposit', 'Interest Credit', 'Transfer In') THEN 'Deposit'
        WHEN txn_type IN ('Withdrawal', 'Fee Debit', 'Transfer Out') THEN 'Withdrawal'
        ELSE 'Other'
    END AS transaction_category,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY EXTRACT(YEAR FROM txn_date), EXTRACT(MONTH FROM txn_date), transaction_category
ORDER BY txn_year, txn_month;
