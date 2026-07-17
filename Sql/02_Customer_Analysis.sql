-- ============================================
-- 02_Customer_Analysis.sql
-- Customer Analysis
-- ============================================

-- Top 10 customers by account balance.
SELECT customer_id, SUM(balance) AS total_balance
FROM accounts
GROUP BY customer_id
ORDER BY total_balance DESC
LIMIT 10;

-- Customers who have both a loan and an active credit card.
SELECT DISTINCT c.name
FROM loans AS l
JOIN customers AS c ON c.customer_id = l.customer_id
JOIN cards AS r ON r.customer_id = c.customer_id
WHERE r.status = 'Active' AND l.status = 'Active';

-- Average income by occupation.
SELECT occupation, ROUND(AVG(annual_income)::numeric, 1) AS avg_income
FROM customers
GROUP BY occupation;

-- Highest income customers.
-- NOTE: original query grouped by name and summed income, which silently
-- merges any customers who share the same name. Using customer_id instead
-- avoids that, since annual_income is a single value per customer anyway.
SELECT customer_id, name, annual_income
FROM customers
ORDER BY annual_income DESC
LIMIT 5;

-- Find customers whose credit score is below 600.
SELECT name
FROM customers
WHERE credit_score < 600;

-- Average customer age.
SELECT ROUND(AVG(age)::numeric, 1) AS avg_customer_age
FROM customers;

-- State-wise customer count.
SELECT state, COUNT(customer_id) AS customer_count
FROM customers
GROUP BY state;
