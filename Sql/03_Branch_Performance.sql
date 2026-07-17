-- ============================================
-- 03_Branch_Performance.sql
-- Branch Performance
-- ============================================

-- Total deposits by branch.
SELECT b.branch_name, SUM(a.balance) AS total_deposits
FROM branches AS b
JOIN accounts AS a ON b.branch_id = a.branch_id
GROUP BY b.branch_name;

-- Branch issuing highest loan amount.
SELECT b.branch_name, SUM(l.loan_amount) AS total_loan_amount
FROM branches b
JOIN loans l ON b.branch_id = l.branch_id
GROUP BY b.branch_name
ORDER BY total_loan_amount DESC
LIMIT 1;

-- Branch having maximum customers.
SELECT b.branch_name, COUNT(DISTINCT c.customer_id) AS number_of_customers
FROM branches b
JOIN accounts a ON b.branch_id = a.branch_id
JOIN customers c ON c.customer_id = a.customer_id
GROUP BY b.branch_name
ORDER BY number_of_customers DESC
LIMIT 1;

-- Average employee salary branch-wise.
SELECT b.branch_name, ROUND(AVG(e.salary)::numeric, 1) AS avg_salary
FROM branches AS b
JOIN employees AS e ON b.branch_id = e.branch_id
GROUP BY b.branch_name;

-- Employees hired every year.
SELECT
    EXTRACT(YEAR FROM hire_date) AS hire_year,
    COUNT(employee_id) AS employees_hired
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year;

-- Top performing branches based on deposits.
SELECT b.branch_name, SUM(a.balance) AS total_deposits
FROM branches AS b
JOIN accounts AS a ON b.branch_id = a.branch_id
GROUP BY b.branch_name
ORDER BY total_deposits DESC
LIMIT 5;
