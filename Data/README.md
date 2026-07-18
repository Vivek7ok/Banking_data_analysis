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

## 📌 Notes

- All files are in **CSV** format.
- These tables are connected using customer IDs, account IDs, loan IDs, and other keys.
- The dataset is used for data cleaning, SQL analysis, and Power BI reporting.
