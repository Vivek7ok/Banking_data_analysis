-- =========================================================
-- BankCorp Synthetic Banking Dataset — PostgreSQL Schema
-- 10 tables | ~300MB | 5M+ rows total
-- =========================================================

DROP TABLE IF EXISTS support_tickets, card_transactions, cards,
    transactions, loan_payments, loans, accounts, employees,
    customers, branches CASCADE;

CREATE TABLE branches (
    branch_id     INT PRIMARY KEY,
    branch_name   VARCHAR(100),
    city          VARCHAR(50),
    state         VARCHAR(50),
    opened_date   DATE,
    ifsc_code     VARCHAR(20)
);

CREATE TABLE employees (
    employee_id   INT PRIMARY KEY,
    name          VARCHAR(100),
    branch_id     INT REFERENCES branches(branch_id),
    role          VARCHAR(50),
    hire_date     DATE,
    salary        NUMERIC(12,2)
);

CREATE TABLE customers (
    customer_id   INT PRIMARY KEY,
    name          VARCHAR(100),
    gender        VARCHAR(10),
    date_of_birth DATE,
    city          VARCHAR(50),
    state         VARCHAR(50),
    phone         VARCHAR(15),
    email         VARCHAR(100),
    occupation    VARCHAR(50),
    annual_income NUMERIC(14,2),
    join_date     DATE,
    credit_score  INT
);

CREATE TABLE accounts (
    account_id    INT PRIMARY KEY,
    customer_id   INT REFERENCES customers(customer_id),
    branch_id     INT REFERENCES branches(branch_id),
    account_type  VARCHAR(30),
    balance       NUMERIC(14,2),
    open_date     DATE,
    status        VARCHAR(20)
);

CREATE TABLE loans (
    loan_id       INT PRIMARY KEY,
    customer_id   INT REFERENCES customers(customer_id),
    branch_id     INT REFERENCES branches(branch_id),
    loan_type     VARCHAR(30),
    loan_amount   NUMERIC(14,2),
    interest_rate NUMERIC(5,2),
    term_months   INT,
    start_date    DATE,
    status        VARCHAR(20)
);

CREATE TABLE loan_payments (
    payment_id          BIGINT PRIMARY KEY,
    loan_id             INT REFERENCES loans(loan_id),
    payment_date        DATE,
    amount_paid         NUMERIC(14,2),
    principal_component NUMERIC(14,2),
    interest_component  NUMERIC(14,2),
    late_payment_flag   SMALLINT
);

CREATE TABLE cards (
    card_id       INT PRIMARY KEY,
    customer_id   INT REFERENCES customers(customer_id),
    account_id    INT REFERENCES accounts(account_id),
    card_type     VARCHAR(30),
    issue_date    DATE,
    expiry_date   DATE,
    credit_limit  NUMERIC(12,2),
    status        VARCHAR(20)
);

CREATE TABLE card_transactions (
    card_txn_id       BIGINT PRIMARY KEY,
    card_id           INT REFERENCES cards(card_id),
    txn_date          DATE,
    merchant_category VARCHAR(30),
    amount            NUMERIC(12,2),
    is_fraud          SMALLINT
);

CREATE TABLE transactions (
    transaction_id    BIGINT PRIMARY KEY,
    account_id        INT REFERENCES accounts(account_id),
    txn_date          DATE,
    txn_type          VARCHAR(30),
    amount            NUMERIC(12,2),
    channel           VARCHAR(30),
    merchant_category VARCHAR(30)
);

CREATE TABLE support_tickets (
    ticket_id           INT PRIMARY KEY,
    customer_id         INT REFERENCES customers(customer_id),
    issue_type          VARCHAR(50),
    date_opened         DATE,
    date_resolved       DATE,
    status              VARCHAR(20),
    satisfaction_score  INT
);

-- =========================================================
-- LOAD DATA (run from psql, adjust path to where CSVs live)
-- =========================================================
copy branches FROM 'D:\Data_set\29_Bank\Data\branches.csv' DELIMITER ',' CSV HEADER;
copy employees FROM 'D:\Data_set\29_Bank\Data\employees.csv' DELIMITER ',' CSV HEADER;
copy customers FROM 'D:\Data_set\29_Bank\Data\customers.csv' DELIMITER ',' CSV HEADER;
copy accounts FROM 'D:\Data_set\29_Bank\Data\accounts.csv' DELIMITER ',' CSV HEADER;
copy loans FROM 'D:\Data_set\29_Bank\Data\loans.csv' DELIMITER ',' CSV HEADER;
copy loan_payments FROM 'D:\Data_set\29_Bank\Data\loan_payments.csv' DELIMITER ',' CSV HEADER;
copy cards FROM 'D:\Data_set\29_Bank\Data\cards.csv' DELIMITER ',' CSV HEADER;
copy card_transactions FROM 'D:\Data_set\29_Bank\Data\card_transactions.csv' DELIMITER ',' CSV HEADER;
copy transactions FROM 'D:\Data_set\29_Bank\Data\transactions.csv' DELIMITER ',' CSV HEADER;
copy support_tickets FROM 'D:\Data_set\29_Bank\Data\support_tickets.csv' DELIMITER ',' CSV HEADER;


-- Helpful indexes for query performance on large tables
CREATE INDEX idx_txn_account ON transactions(account_id);
CREATE INDEX idx_txn_date ON transactions(txn_date);
CREATE INDEX idx_cardtxn_card ON card_transactions(card_id);
CREATE INDEX idx_cardtxn_date ON card_transactions(txn_date);
CREATE INDEX idx_loanpay_loan ON loan_payments(loan_id);
CREATE INDEX idx_accounts_cust ON accounts(customer_id);
CREATE INDEX idx_loans_cust ON loans(customer_id);
CREATE INDEX idx_cards_cust ON cards(customer_id);