-- ============================================
-- 08_Customer_Support.sql
-- Customer Support Analysis
-- ============================================

-- Average satisfaction score.
SELECT ROUND(AVG(satisfaction_score)::numeric, 1) AS avg_satisfaction_score
FROM support_tickets;

-- Average resolution time.
-- NOTE: original used GROUP BY status + HAVING status = 'Resolved' —
-- simplified to WHERE since only one status is being measured.
SELECT ROUND(AVG(date_resolved - date_opened)::numeric, 2) AS avg_resolution_days
FROM support_tickets
WHERE status = 'Resolved';

-- Most common issue type.
-- FIXED: alias "number_of_issue" -> "number_of_issues".
SELECT issue_type, COUNT(*) AS number_of_issues
FROM support_tickets
GROUP BY issue_type
ORDER BY number_of_issues DESC
LIMIT 1;

-- Branches having unhappy customers (lowest satisfaction).
SELECT branch_name, ROUND(AVG(satisfaction_score)::numeric, 1) AS avg_sat_score
FROM support_tickets AS st
JOIN accounts AS a ON a.customer_id = st.customer_id
JOIN branches AS b ON b.branch_id = a.branch_id
GROUP BY branch_name
ORDER BY avg_sat_score ASC
LIMIT 3;
