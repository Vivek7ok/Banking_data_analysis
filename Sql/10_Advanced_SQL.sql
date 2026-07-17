-- ============================================
-- 10_Advanced_SQL.sql
-- Advanced SQL: Branch Performance Ranking
-- ============================================

-- Rank branches based on overall performance
-- (deposits, customers, accounts, loans, transactions).
--
-- FIXED: the original drafts joined accounts, loans, and transactions
-- directly, which caused row fan-out (a single account row gets duplicated
-- once per matching loan and once per matching transaction), inflating
-- SUM(balance) and the customer/account counts. A later draft tried to fix
-- this by pre-aggregating into subqueries, but then joined on columns
-- (a.customer_id, a.account_id) that don't exist in those aggregated
-- subqueries, which would error.
--
-- This version aggregates accounts, loans, and transactions independently
-- in their own subqueries, then combines them with LEFT JOINs on
-- branch_id (so branches with no loans/transactions still appear, with 0s
-- via COALESCE), and ranks the result with RANK().

SELECT
    acc.branch_id,
    acc.number_of_customers,
    acc.number_of_accounts,
    acc.total_balance,
    COALESCE(ln.total_loan_issued, 0) AS total_loan_issued,
    COALESCE(txn.number_of_transactions, 0) AS number_of_transactions,
    RANK() OVER (
        ORDER BY acc.total_balance DESC, acc.number_of_customers DESC
    ) AS branch_rank
FROM (
    SELECT
        branch_id,
        COUNT(DISTINCT customer_id) AS number_of_customers,
        COUNT(DISTINCT account_id) AS number_of_accounts,
        SUM(balance) AS total_balance
    FROM accounts
    GROUP BY branch_id
) acc
LEFT JOIN (
    SELECT branch_id, COUNT(*) AS total_loan_issued
    FROM loans
    GROUP BY branch_id
) ln ON acc.branch_id = ln.branch_id
LEFT JOIN (
    SELECT a.branch_id, COUNT(t.transaction_id) AS number_of_transactions
    FROM accounts a
    JOIN transactions t ON t.account_id = a.account_id
    GROUP BY a.branch_id
) txn ON acc.branch_id = txn.branch_id
ORDER BY branch_rank;
