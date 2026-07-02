USE FinPayAnalytics;
GO

--Transaction Distribution by Type
SELECT
    TransactionType,
    COUNT(*) AS TotalTransactions
FROM Fact_Transactions
GROUP BY TransactionType
ORDER BY TotalTransactions DESC;

GO

--Total Transaction Distribution by Type
SELECT
    TransactionType,
    SUM(Amount) AS TotalAmount
FROM Fact_Transactions
GROUP BY TransactionType
ORDER BY TotalAmount DESC;

GO

--Revenue by Transaction Type
SELECT
    TransactionType,
    SUM(NetRevenue) AS NetRevenue
FROM Fact_Transactions
GROUP BY TransactionType
ORDER BY NetRevenue DESC;

GO

--Revenue Trend
SELECT

    d.Day,

    SUM(f.NetRevenue) AS NetRevenue

FROM Fact_Transactions f

INNER JOIN Dim_Date d
ON f.DateKey=d.DateKey

GROUP BY d.Day

ORDER BY d.Day;

GO

--Hourly Transaction
SELECT

d.HourOfDay,

COUNT(*) AS Transactions

FROM Fact_Transactions f

JOIN Dim_Date d

ON f.DateKey=d.DateKey

GROUP BY d.HourOfDay

ORDER BY d.HourOfDay;

GO

-- Time Bucket Analysis
SELECT

d.TimeBucket,

COUNT(*) Transactions,

SUM(f.NetRevenue) Revenue

FROM Fact_Transactions f

JOIN Dim_Date d

ON f.DateKey=d.DateKey

GROUP BY d.TimeBucket

ORDER BY Revenue DESC;

GO

--Amount Band Distribution
SELECT

AmountBand,

COUNT(*) Transactions,

SUM(NetRevenue) Revenue

FROM Fact_Transactions

GROUP BY AmountBand

ORDER BY Revenue DESC;

GO

-- High Value Transaction
SELECT

HighValue,

COUNT(*) Transactions,

SUM(NetRevenue) Revenue

FROM Fact_Transactions

GROUP BY HighValue;

GO

-- Balance Status Analysis
SELECT

BalanceDataStatus,

COUNT(*) Transactions

FROM Fact_Transactions

GROUP BY BalanceDataStatus;

GO

-- Fee, Cashback, and Net Revenue Analysis
SELECT

SUM(Amount) TotalTransactionAmount,

SUM(Fee) TotalFee,

SUM(Cashback) TotalCashback,

SUM(NetRevenue) NetRevenue,

AVG(NetRevenue) AverageRevenue

FROM Fact_Transactions;

GO

-- Top 10 Highest Revenue Transactions
SELECT TOP 10

TransactionID,

TransactionType,

Amount,

NetRevenue

FROM Fact_Transactions

ORDER BY NetRevenue DESC;

GO

--Average Transaction Value
SELECT

AVG(Amount) AverageTransactionAmount,

MIN(Amount) MinimumTransaction,

MAX(Amount) MaximumTransaction

FROM Fact_Transactions;

GO

-- Revenue Contribution by Transaction Types
SELECT

TransactionType,

SUM(NetRevenue) Revenue,

ROUND(
100.0*SUM(NetRevenue)
/SUM(SUM(NetRevenue)) OVER(),
2
) RevenuePercentage

FROM Fact_Transactions

GROUP BY TransactionType

ORDER BY RevenuePercentage DESC;

GO

-- Running Revenue
SELECT

d.Day,

SUM(f.NetRevenue) Revenue,

SUM(SUM(f.NetRevenue))

OVER(

ORDER BY d.Day

) RunningRevenue

FROM Fact_Transactions f

JOIN Dim_Date d

ON f.DateKey=d.DateKey

GROUP BY d.Day

ORDER BY d.Day;

GO

-- Executive Summary
SELECT

COUNT(*) AS TotalTransactions,

COUNT(DISTINCT CustomerKey) AS TotalCustomers,

COUNT(DISTINCT MerchantKey) AS TotalMerchants,

SUM(Amount) TransactionAmount,

SUM(NetRevenue) NetRevenue,

SUM(IsFraud) FraudTransactions,

SUM(IsFlaggedFraud) FlaggedTransactions

FROM Fact_Transactions;

GO