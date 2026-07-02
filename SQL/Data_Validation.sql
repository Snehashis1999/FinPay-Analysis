USE FinPayAnalytics;
GO

--Recond Count Validation for Fact and Dimension Tables
SELECT COUNT(*) AS TotalTransactions
FROM Fact_Transactions;

SELECT COUNT(*) AS TotalCustomers
FROM Dim_Customer;

SELECT COUNT(*) AS TotalMerchants
FROM Dim_Merchant;

SELECT COUNT(*) AS TotalDates
FROM Dim_Date;

GO

--Duplicate Record Validation for Fact Table
SELECT
    TransactionID,
    COUNT(*) AS DuplicateCount
FROM Fact_Transactions
GROUP BY TransactionID
HAVING COUNT(*) > 1;

GO

-- Duplicate Record Validation for Dimension Tables
SELECT
    CustomerID,
    COUNT(*) AS DuplicateCount
FROM Dim_Customer
GROUP BY CustomerID
HAVING COUNT(*) > 1;

GO

SELECT
    MerchantID,
    COUNT(*) AS DuplicateCount
FROM Dim_Merchant
GROUP BY MerchantID
HAVING COUNT(*) > 1;

GO

-- Null Value Validation for Fact and Dimension Tables
SELECT
    SUM(CASE WHEN TransactionID IS NULL THEN 1 ELSE 0 END) AS TransactionID,
    SUM(CASE WHEN CustomerKey IS NULL THEN 1 ELSE 0 END) AS CustomerKey,
    SUM(CASE WHEN MerchantKey IS NULL THEN 1 ELSE 0 END) AS MerchantKey,
    SUM(CASE WHEN DateKey IS NULL THEN 1 ELSE 0 END) AS DateKey,
    SUM(CASE WHEN Amount IS NULL THEN 1 ELSE 0 END) AS Amount,
    SUM(CASE WHEN Fee IS NULL THEN 1 ELSE 0 END) AS Fee,
    SUM(CASE WHEN Cashback IS NULL THEN 1 ELSE 0 END) AS Cashback,
    SUM(CASE WHEN NetRevenue IS NULL THEN 1 ELSE 0 END) AS NetRevenue
FROM Fact_Transactions;

GO

--Primary Key Validation for Fact and Dimension Tables
--Customer Primary Key Validation
SELECT
COUNT(DISTINCT CustomerKey) AS UniqueCustomers,
COUNT(*) AS TotalCustomers
FROM Dim_Customer;
-- Merchant Primary Key Validation
SELECT
COUNT(DISTINCT MerchantKey) AS UniqueMerchants,
COUNT(*) AS TotalMerchants
FROM Dim_Merchant;
--Date Primary Key Validation
SELECT
COUNT(DISTINCT TimeKey) AS UniqueDates,
COUNT(*) AS TotalDates
FROM Dim_Date;


-- Foreign Key Validation for Fact and Dimension Tables
-- Customer Foreign Key Validation
SELECT
f.CustomerKey
FROM Fact_Transactions f

LEFT JOIN Dim_Customer c
ON f.CustomerKey = c.CustomerKey

WHERE c.CustomerKey IS NULL;

GO

-- Merchant Foreign Key Validation
SELECT
f.MerchantKey
FROM Fact_Transactions f

LEFT JOIN Dim_Merchant m
ON f.MerchantKey=m.MerchantKey

WHERE m.MerchantKey IS NULL;

GO

-- Date Foreign Key Validation
SELECT
f.DateKey
FROM Fact_Transactions f

LEFT JOIN Dim_Date d
ON f.DateKey=d.DateKey

WHERE d.DateKey IS NULL;

GO

--Fraud Validation for Fact Table
SELECT

SUM(IsFraud) AS FraudTransactions,

SUM(IsFlaggedFraud) AS FlaggedTransactions

FROM Fact_Transactions;

GO

--Balance Status Validation for Fact Table
SELECT

BalanceDataStatus,

COUNT(*) AS Transactions

FROM Fact_Transactions

GROUP BY BalanceDataStatus;

GO

--Transaction Type Validation for Fact Table
SELECT

TransactionType,

COUNT(*) AS Transactions

FROM Fact_Transactions

GROUP BY TransactionType

ORDER BY Transactions DESC;

GO

--Amount Band Validation for Fact Table
SELECT

AmountBand,

COUNT(*) AS Transactions

FROM Fact_Transactions

GROUP BY AmountBand

ORDER BY Transactions DESC;

GO

-- Revenue Validation for Fact Table
SELECT

SUM(Fee) AS TotalFee,

SUM(Cashback) AS TotalCashback,

SUM(NetRevenue) AS NetRevenue

FROM Fact_Transactions;

GO

-- Date Validation for Fact Table
SELECT

MIN(Date) AS StartDate,

MAX(Date) AS EndDate

FROM Dim_Date;

GO


