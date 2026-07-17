-- ============================================
-- 05_Loan_Analysis.sql
-- Loan Analysis
-- ============================================

-- Loan amount by loan type.
SELECT loan_type, SUM(loan_amount) AS total_loan_amount
FROM loans
GROUP BY loan_type;

-- Average interest rate by loan type.
-- FIXED: original used SUM(interest_rate) but named it "avg_interset" —
-- switched to AVG() and corrected the alias spelling.
SELECT loan_type, ROUND(AVG(interest_rate)::numeric, 2) AS avg_interest_rate
FROM loans
GROUP BY loan_type;

-- Number of active loans.
-- FIXED: original mistakenly reused the "avg_interset" alias from the
-- previous query (copy/paste artifact) — renamed to reflect what it counts.
SELECT loan_type, COUNT(*) AS active_loan_count
FROM loans
WHERE status = 'Active'
GROUP BY loan_type;

-- Find overdue (late payment) loans.
-- FIXED: alias typo "late_paymetns" -> "late_payment_loan_id".
SELECT DISTINCT loan_id AS late_payment_loan_id
FROM loan_payments
WHERE late_payment_flag = 1;

-- Customers with maximum outstanding loans.
-- FIXED: alias typo "amount_raming" -> "amount_remaining".
SELECT l.customer_id, SUM(loan_amount - lp.amount_paid) AS amount_remaining
FROM loans AS l
JOIN loan_payments AS lp ON lp.loan_id = l.loan_id
GROUP BY l.customer_id
ORDER BY amount_remaining DESC;

-- Branches with highest late payment rate.
SELECT
    b.branch_id,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*)
         FROM loan_payments lp2
         JOIN loans l2 ON lp2.loan_id = l2.loan_id
         WHERE l2.branch_id = b.branch_id),
        2
    ) AS late_payment_percentage
FROM loan_payments lp
JOIN loans l ON lp.loan_id = l.loan_id
JOIN branches b ON l.branch_id = b.branch_id
WHERE lp.late_payment_flag = 1
GROUP BY b.branch_id
ORDER BY late_payment_percentage DESC;

-- Average repayment amount by loan type.
SELECT loan_type, ROUND(AVG(amount_paid)::numeric, 1) AS avg_repayment_amount
FROM loans AS l
JOIN loan_payments AS lp ON l.loan_id = lp.loan_id
GROUP BY loan_type;
