-- ============================================
-- 04_Account_Analysis.sql
-- Account Analysis
-- ============================================

-- How many active accounts exist?
-- NOTE: original used GROUP BY status + HAVING status = 'Active', which
-- works but is roundabout for filtering a single value — WHERE is simpler.
SELECT COUNT(account_id) AS active_accounts
FROM accounts
WHERE status = 'Active';

-- Find total balance maintained by the bank.
SELECT SUM(balance) AS total_balance
FROM accounts;

-- Find average account balance.
SELECT ROUND(AVG(balance)::numeric, 1) AS avg_account_balance
FROM accounts;

-- Customers having more than one account.
SELECT customer_id, COUNT(account_id) AS number_of_accounts
FROM accounts
GROUP BY customer_id
HAVING COUNT(account_id) > 1
ORDER BY number_of_accounts DESC;
