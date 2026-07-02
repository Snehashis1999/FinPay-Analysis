USE FinPayAnalytics;
GO

CREATE TABLE Dim_Date
(
    [DateKey]         INT PRIMARY KEY,
    [Date]          DATE NOT NULL,
    [Day]           TINYINT NOT NULL,
    [MonthName]     VARCHAR(15) NOT NULL,
    [MonthNumber]   TINYINT NOT NULL,
    [Quarter]         CHAR(2) NOT NULL,
    [Year]          SMALLINT NOT NULL,
    [HourOfDay]       TINYINT NOT NULL,
    [TimeBucket]      VARCHAR(20) NOT NULL
);
GO

CREATE TABLE Dim_Customer
(
    [CustomerKey]         INT PRIMARY KEY,
    [CustomerID]          VARCHAR(20) UNIQUE NOT NULL,
    [CustomerSegment]     VARCHAR(20) NOT NULL,
    [Gender]              VARCHAR(10) NOT NULL,
    [Age]                 TINYINT NOT NULL,
    [AgeGroup]            VARCHAR(20) NOT NULL,
    [IncomeGroup]         VARCHAR(20) NOT NULL,
    [State]               VARCHAR(30) NOT NULL,
    [City]                VARCHAR(50) NOT NULL,
    [KYCStatus]           VARCHAR(20) NOT NULL,
    [JoinYear]            SMALLINT NOT NULL,
    [CustomerTenure]      TINYINT NOT NULL,
    [IsActive]            BIT NOT NULL
);
GO

CREATE TABLE Dim_Merchant
(
    [MerchantKey]         INT PRIMARY KEY,
    [MerchantID]          VARCHAR(20) UNIQUE NOT NULL,
    [MerchantCategory]    VARCHAR(40) NOT NULL,
    [BusinessSize]        VARCHAR(20) NOT NULL,
    [State]               VARCHAR(30) NOT NULL,
    [City]                VARCHAR(50) NOT NULL,
    [SettlementCycle]     VARCHAR(10) NOT NULL,
    [PartnerSince]        SMALLINT NOT NULL,
    [MerchantTenure]      TINYINT NOT NULL
);
GO

CREATE TABLE Fact_Transactions
(
    [TransactionID]           VARCHAR(25) PRIMARY KEY,
    [DateKey]                 INT NOT NULL,
    [CustomerKey]             INT NOT NULL,
    [MerchantKey]             INT NOT NULL,
    [TransactionType]         VARCHAR(20) NOT NULL,
    [Amount]                  DECIMAL(18,2) NOT NULL,
    [Fee]                     DECIMAL(18,2) NOT NULL,
    [Cashback]                DECIMAL(18,2) NOT NULL,
    [NetRevenue]              DECIMAL(18,2) NOT NULL,
    [HighValue]               BIT NOT NULL,
    [BalanceReduction]        DECIMAL(18,2),
    [BalanceDataStatus]       VARCHAR(20),
    [AmountBand]              VARCHAR(20),
    [IsFraud]                BIT NOT NULL,
    [IsFlaggedFraud]         BIT NOT NULL,

    CONSTRAINT FK_Date
        FOREIGN KEY(DateKey)
        REFERENCES Dim_Date(DateKey),

    CONSTRAINT FK_Customer
        FOREIGN KEY(CustomerKey)
        REFERENCES Dim_Customer(CustomerKey),

    CONSTRAINT FK_Merchant
        FOREIGN KEY(MerchantKey)
        REFERENCES Dim_Merchant(MerchantKey)

);
GO