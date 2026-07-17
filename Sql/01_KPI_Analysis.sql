-- ============================================
-- 01_KPI_Analysis.sql
-- Bank-wide summary KPIs
-- ============================================

-- How many customers does the bank have?
SELECT COUNT(*) AS total_customers
FROM customers;

-- How many branches are there?
SELECT COUNT(branch_id) AS total_branches
FROM branches;

-- How many loans have been issued?
SELECT COUNT(loan_id) AS total_loans_issued
FROM loans;

-- Calculate total loan amount issued.
SELECT SUM(loan_amount) AS total_loan_amount
FROM loans;

-- Find total card transactions.
SELECT COUNT(card_id) AS total_card_transactions
FROM card_transactions;

-- Count total support tickets.
SELECT COUNT(ticket_id) AS total_support_tickets
FROM support_tickets;

-- Find average customer credit score.
SELECT ROUND(AVG(credit_score)::numeric, 1) AS avg_credit_score
FROM customers;
