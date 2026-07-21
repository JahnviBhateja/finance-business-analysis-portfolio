--=======================
--DATA BASE CREATION
--========================
CREATE DATABASE indian_economy

USE indian_economy

CREATE TABLE IndianEconomy (
    Year INT PRIMARY KEY,
    GDP FLOAT,
    Inflation FLOAT,
    ExchangeRate FLOAT,
    IndustrialProduction FLOAT,
    Exports FLOAT,
    ForexReserves FLOAT);
--===================
--VERIFYING THE IMPORT
--======================

SELECT * FROM Indian_Economy;

--Total Oberservations
SELECT COUNT(*) AS Total_years FROM Indian_Economy;

--STUDY PERIOD
SELECT MIN(Year) AS Start_year, MAX(Year) AS End_year
FROM indian_economy

--CHECKING MISSING VALUES
SELECT *
FROM indian_economy
WHERE GDP IS NULL
OR Inflation IS NULL
OR Exchange_rate IS NULL
OR Industrial_Production IS NULL
OR Forex_Reserves IS NULL
OR Exports IS NULL;

--HIGHEST GDP AND INFLATION

SELECT TOP 1 Year,GDP
FROM indian_economy
ORDER BY GDP DESC;


SELECT TOP 1 Year,Inflation
FROM indian_economy
ORDER BY Inflation DESC;


--AVERAGE Inflation

SELECT AVG(Inflation) AS AVERAGE_INFLATION
FROM Indian_Economy;

--TOP EXPORT YEARS AND WITH BEST FOREX RESERVES

SELECT TOP 5 Year, EXPORTS
FROM Indian_Economy
ORDER BY Exports DESC;

SELECT TOP 5 Year, Forex_Reserves
FROM Indian_Economy
ORDER BY Forex_Reserves DESC;

--EXCHANGE RATE AFTER 2015

SELECT Year, Exchange_rate
FROM [dbo].[Indian_Economy]
WHERE Year >= 2015;

--YEARS WITH INFLATION ABOVE 7%

SELECT Year, INFLATION
FROM [dbo].[Indian_Economy]
WHERE INFLATION > 7;

--GDP COMPARISON BY DECADE

SELECT (Year/10)*10 AS DECADE, AVG(GDP) AS Avg_GDP
FROM indian_economy
GROUP BY (Year/10)*10
ORDER BY DECADE;

--TOP 5 YEARS WITH WITH STRONGEST GDP

SELECT TOP 5
Year, GDP, Exports, Forex_Reserves
FROM Indian_Economy
ORDER BY GDP DESC;

--RANKING YEARS BY GDP
SELECT Year, GDP,
RANK() OVER (ORDER BY GDP DESC) AS GDP_Rank
FROM indian_economy;

--CUMULATIVE GDP OVER THE YEAR TO ANALSYSE THE ECONOMIC GROWTH
SELECT Year, GDP,
SUM(GDP) OVER (ORDER BY Year) AS Running_GDP
FROM indian_economy;

--YoY COMPARISON

SELECT Year, GDP,
LAG(GDP) OVER (ORDER BY Year) AS Previous_year_GDP
FROM Indian_Economy;

--YoY CHANGE CALCULATION

SELECT Year, GDP,
GDP-LAG(GDP) OVER (ORDER BY Year) AS GDP_Change
FROM Indian_Economy;

--CATEGORIZING INFLATION

SELECT Year, INFLATION, GDP,

CASE
WHEN INFLATION<4 THEN 'Low Inflation'
WHEN INFLATION BETWEEN 4 AND 6 THEN 'Moderate Inflation'
WHEN INFLATION IS NULL THEN 'NA'
ELSE 'High Inflation'
END AS Inflation_Category,
CASE
WHEN GDP > 3000000 THEN 'High GDP'
WHEN GDP > 1000000 THEN 'Medium GDP'
WHEN GDP IS NULL THEN 'NA'
ELSE 'Low GDP'
END AS GDP_Category
FROM indian_economy;

--MAX EXPORTS AND INDUSTRIAL PRODUCTION 

SELECT
MAX(Industrial_Production) AS HighestProduction,
MAX(Exports) AS HighestExports
FROM indian_economy


--SUMMARY STATS

SELECT
AVG(GDP) AS AvgGDP,
AVG(Inflation) AS AvgInflation,
AVG(Exchange_rate) AS AvgExchangeRate,
AVG(Exports) AS AvgExports,
AVG(Forex_Reserves) AS AvgForexReserves,
AVG(Industrial_Production) AS AvgIndustrialProduction
FROM Indian_Economy;

--TOP 5 YEARS RANKED ACC TO BEST EXPORTS AFTER 2010

SELECT TOP 5
Year,
Exports
FROM Indian_Economy
WHERE Year >= 2010
ORDER BY Exports DESC;

--EXTRACTING YEARS WITH GDP>AVG_GDP

SELECT Year,GDP,Inflation,Exports,Forex_Reserves
FROM Indian_Economy
WHERE GDP >
(SELECT AVG(GDP)
FROM Indian_Economy)
ORDER BY GDP DESC;