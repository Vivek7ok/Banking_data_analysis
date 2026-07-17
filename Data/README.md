# BankCorp Synthetic Banking Dataset

A realistic, relational banking dataset built for a portfolio project — sized
and structured to support a full SQL + Power BI + Excel analysis workflow.

**Size:** ~304 MB | **Tables:** 10 | **Total rows:** ~5.9 million

## Tables & Row Counts

| Table              | Rows      | Description                                  |
|--------------------|-----------|-----------------------------------------------|
| branches           | 150       | Bank branch locations                        |
| employees          | 1,800     | Staff, roles, salaries, branch assignment    |
| customers          | 60,000    | Demographics, income, credit score           |
| accounts           | 95,000    | Savings/current/FD accounts per customer     |
| loans              | 22,000    | Home/personal/auto/education/business loans  |
| loan_payments      | 600,000   | EMI payment history per loan                 |
| cards              | 65,000    | Debit/credit cards per customer              |
| card_transactions  | 3,000,000 | Card-level spend, includes fraud flag        |
| transactions       | 2,000,000 | Account-level deposits/withdrawals/transfers |
| support_tickets    | 25,000    | Customer service complaints & resolutions    |

## Relationships (ERD summary)

```
branches ─┬─< employees
          ├─< accounts >─ customers ─< loans ─< loan_payments
          └─< loans

customers ─< accounts ─< transactions
customers ─< cards ─< card_transactions
customers ─< support_tickets
accounts  ─< cards
```

## 1. Load into PostgreSQL

```bash
createdb bankcorp
psql -d bankcorp -f schema.sql
```

Then, inside `psql -d bankcorp`, run the `\copy` commands at the bottom of
`schema.sql` (uncomment them), pointing to wherever the CSVs are stored.
`\copy` is fast and works without server-side file permissions.

## 2. Suggested Resume-Worthy Analysis Angles

**SQL (PostgreSQL) — write these as a portfolio query set:**
- Customer segmentation by income, credit score, and account balance tiers
- Loan default/write-off rate by loan type, branch, and interest rate band
- Fraud rate analysis on card_transactions by merchant category and card type
- Monthly active accounts, deposit/withdrawal trend, net cash flow by branch
- Customer lifetime value: total balance + loan value + card spend per customer
- Support ticket resolution time and satisfaction by issue type
- Cohort analysis: retention of customers by join_date year

**Power BI dashboard ideas (great for a resume screenshot/GIF):**
- Executive summary: total deposits, active loans, fraud alerts, NPS-style satisfaction
- Branch performance map (city/state) with drill-through to accounts & loans
- Loan portfolio health (status, overdue %, interest revenue)
- Fraud & risk dashboard (is_fraud trends over time, by category)
- Customer 360 page (filter by customer_id → accounts, cards, loans, tickets)

**Excel angles (good for a "data cleaning + pivot" resume line):**
- Pivot tables: revenue by branch/loan type, transaction volume by channel
- What-if analysis on loan interest rate vs. total repayment (using loans + loan_payments)
- VLOOKUP/XLOOKUP customer → account → transaction chains for sampled records
- Conditional formatting dashboard for dormant/at-risk accounts

## 3. How to describe this on a resume

> "Designed and analyzed a 10-table relational banking database (~6M rows, 300MB)
> in PostgreSQL; built SQL queries for loan risk, fraud detection, and customer
> segmentation; delivered an interactive Power BI dashboard and Excel reporting
> layer for branch and portfolio performance."

Since this is a synthetic dataset generated for practice, be transparent about
that in interviews if asked — but the SQL, modeling, and dashboarding skills
demonstrated are exactly what real banking analyst roles need.
