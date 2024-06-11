CREATE DATABASE customer;
USE customer;
SELECT * FROM retail;
SELECT COUNT(*) FROM retail;

-- Question 1
-- What is the total revenue generated across all transactions?

SELECT SUM(TotalCost) AS Totalrevenue FROM retail;

-- Question 2
-- What is the average total cost per transaction?

SELECT AVG(TotalCost) AS AverageCostPerTransaction FROM retail;

-- Question 3
-- What is the total sales revenue for each month?

Select
MONTH(Date) AS Month,
SUM(TotalCost) AS MonthlyRevenue
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 4
-- How many transactions did each customer make?

SELECT
CustomerName,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 5
-- Who are the top 5 customers in terms of total spending?

WITH CTE AS(SELECT
CustomerName,
SUM(TotalCost) AS TotalAmountSpent
FROM retail
GROUP BY 1
ORDER BY 2 DESC), 
cte2 AS (
SELECT *, 
DENSE_RANK() OVER (ORDER BY TotalAmountSpent DESC) AS SpendingRank
FROM CTE) SELECT * FROM cte2 WHERE SpendingRank <6;

-- Question 6
-- How many transactions took place in a specific city (e.g., 'New York')?

SELECT 
City,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
HAVING City = "Houston";

-- Question 7
-- What is the total discount applied across all transactions?

SELECT 
DiscountApplied,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
HAVING DiscountApplied = True;

-- Question 8
-- What is the total number of items sold in each season?

SELECT 
Season,
SUM(TotalItems) AS NumberOfItemsSold
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 9
-- How many transactions used each payment method?

SELECT 
PaymentMethod,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 10
-- What is the average number of items per transaction?

SELECT AVG(TotalItem) AS AverageItemsPerTransaction FROM retail;

-- Question 11
-- How many transactions were made in each store type?

SELECT 
StoreType,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 12
-- How many transactions were made by each customer category?

SELECT 
CustomerCategory,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 13
-- What is the total revenue for each promotion?

SELECT 
Promotion,
SUM(TotalCost) AS TotalRevenue
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 14
-- How many transactions occurred in each year?

SELECT 
YEAR(Date) AS Date,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 15
-- What is the total number of items sold by each store type?

SELECT 
StoreType,
SUM(TotalItems) AS NumberOfItemsSold
FROM retail
GROUP BY 1
ORDER BY 2 DESC;

-- Question 16
-- What is the total number of transactions for each payment method in each city?

SELECT 
City,
PaymentMethod,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 1;

-- Question 17
-- How many transactions occurred in each city during each season?

SELECT 
City,
Season,
COUNT(TransactionID) AS NumberOfTransactions
FROM retail
GROUP BY 1
ORDER BY 1;

-- Question 18
-- Select the top 5 high spending senior citizen customers

WITH CTE AS(SELECT
CustomerName,
CustomerCategory,
SUM(TotalCost) AS TotalAmountSpent
FROM retail
GROUP BY 1, 2
HAVING CustomerCategory = "Senior Citizen"
ORDER BY 3 DESC), 
cte2 AS (
SELECT *, 
DENSE_RANK() OVER (ORDER BY TotalAmountSpent DESC) AS SpendingRank
FROM CTE) SELECT * FROM cte2 WHERE SpendingRank <6;

-- Question 19
-- Customers who visit the store in all months

WITH CTE AS(SELECT 
CustomerName,
MONTH(Date) AS Month,
COUNT(TransactionID) AS NumberOfTimesVisited
FROM retail
GROUP BY 1,2
ORDER BY 1), CTE1 AS (
SELECT 
CustomerName,
COUNT(CustomerName) AS MonthsVisited
FROM CTE 
GROUP BY 1
ORDER BY 2 DESC) SELECT * FROM CTE1 WHERE MonthsVisited = 12;

-- Question 20
-- Find the customers who are visiting the store from it's starting year

 WITH CTE AS(SELECT 
CustomerName,
Year(Date) AS Year,
COUNT(TransactionID) AS NumberOfTimesVisited
FROM retail
GROUP BY 1,2
ORDER BY 1), CTE1 AS (
SELECT 
CustomerName,
COUNT(CustomerName) AS YearsVisited
FROM CTE 
GROUP BY 1
ORDER BY 2 DESC) SELECT * FROM CTE1 WHERE YearsVisited = 5;

