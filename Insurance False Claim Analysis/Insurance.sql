CREATE DATABASE claims;
USE claims;

-- Question 1
-- How many accidents occurred in each month?

SELECT 
AccidentMonth,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 1;

-- Question 2
-- How many accidents occurred in each week of the month?

SELECT 
AccidentMonth,
WeekOfMonth,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1,2
ORDER BY 1,2;

-- Question 3
-- Which day of the week has the highest number of accidents?

WITH CTE AS(SELECT 
DayOfWeek,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 2 DESC), 
TEMP AS(SELECT *, DENSE_RANK() OVER (ORDER BY Number_of_accidents DESC) AS Claim_Rank 
FROM CTE)
SELECT * FROM TEMP WHERE Claim_Rank= 1;

-- Question 4
-- Which vehicle make has the highest number of accidents?

WITH CTE AS(SELECT 
VehicleCategory,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 2 DESC), 
TEMP AS(SELECT *, DENSE_RANK() OVER (ORDER BY Number_of_accidents DESC) AS Claim_Rank 
FROM CTE)
SELECT * FROM TEMP WHERE Claim_Rank= 1;

-- Question 5
-- How many accidents occurred in urban vs rural areas?

SELECT
AccidentArea,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 6
-- How many claims were filed by male vs female policyholders were fraud claims?

SELECT
Sex,
FraudFound,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1, 2
HAVING FraudFound=1;

-- Question 7
-- How many claims were filed by policyholders of different marital statuses?

SELECT
MaritalStatus,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 8
-- What is the average age of policyholders involved in accidents by Policy Type?

SELECT 
PolicyType,
AVG(Age)
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 9
-- How many accidents were the policyholder's fault vs not their fault?

SELECT 
Fault,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 10
-- What is the distribution of accidents across different base policy?

SELECT 
BasePolicy,
COUNT(PolicyNumber) AS Number_of_accidents
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 11
-- How do accident trends change over each week?

WITH CTE AS(SELECT
Year, 
AccidentMonth,
WeekOfMonth,
COUNT(PolicyNumber) AS Number_of_Accidents
FROM insurance
GROUP BY 1, 2, 3
ORDER BY 1,2), TEMP AS(SELECT *, LAG(Number_of_Accidents) OVER (ORDER BY AccidentMonth) AS Previous_Week_month
FROM CTE) SELECT *, 
CASE WHEN Number_of_Accidents - Previous_Week_month > 0 THEN "Increased"
ELSE "Decreased" END AS trend FROM TEMP ;

-- Question 12
-- Examine the correlation between vehicle price ranges and average deductible amounts, and identify any significant outliers.

SELECT
VehiclePrice,
AVG(Deductible)
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 13
-- How many fraudulent claims are made by policyholders in different age groups?

SELECT
AgeOfPolicyHolder,
FraudFound,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1,2
HAVING FraudFound=1
ORDER BY 3 DESC;

-- Question 14
-- What is the count of fraudulent claims for each policy type?

SELECT
PolicyType,
FraudFound,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1,2
HAVING FraudFound=1
ORDER BY 3 DESC;

-- Question 15
-- How many accidents occurred for each vehicle make and price range?

SELECT
Make,
VehiclePrice,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1,2
ORDER BY 3 DESC;

-- Question 16
-- What is the average deductible amount for fraudulent claims?

SELECT 
FraudFound,
AVG(Deductible) AS Avg_deductible_amount
FROM insurance
GROUP BY 1
HAVING FraudFound=1;

-- Question 17
-- How many claims are filed by policyholders segmented by gender and marital status?

SELECT 
Sex,
MaritalStatus,
COUNT(PolicyNumber) AS Total_claims
FROM insurance
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Question 18
-- How many accidents had a police report filed, segmented by accident area?

SELECT
AccidentArea,
PoliceReportFiled,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1,2
HAVING PoliceReportFiled= "Yes"
ORDER BY 3 DESC;

-- Question 19
-- How often is a witness present in fraudulent claims?

SELECT
WitnessPresent,
FraudFound,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1,2
HAVING WitnessPresent = "Yes" AND FraudFound = 1
ORDER BY 3 DESC;

-- Question 20
-- What is the number of claims handled by each type of agent?

SELECT
AgentType,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 21
-- How many accidents involve vehicles of different ages?

SELECT
AgeOfVehicle,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1
ORDER BY 2 DESC;

-- Question 22
-- How does the number of past claims affect the likelihood of a new claim being fraudulent?

SELECT
PastNumberOfClaims,
FraudFound,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1, 2
HAVING FraudFound=1
ORDER BY 3 DESC;

-- Question 23
-- How many accidents involve vehicles of different makes and ages?

SELECT
Make,
AgeOfVehicle,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1, 2
ORDER BY 3 DESC;

-- Question 24
-- What is the monthly trend in the number of fraudulent claims?

WITH CTE AS(SELECT
Year, 
AccidentMonth,
COUNT(PolicyNumber) AS Number_of_Accidents
FROM insurance
GROUP BY 1, 2
ORDER BY 1,2), TEMP AS(SELECT *, LAG(Number_of_Accidents) OVER (ORDER BY AccidentMonth) AS Previous_Week_month
FROM CTE) SELECT *, 
CASE WHEN Number_of_Accidents - Previous_Week_month > 0 THEN "Increased"
ELSE "Decreased" END AS trend FROM TEMP ;

-- Question 25
-- How often are police reports filed when a witness is present?

SELECT
PoliceReportFiled,
WitnessPresent,
COUNT(PolicyNumber) AS Number_of_claims
FROM insurance
GROUP BY 1, 2
HAVING PoliceReportFiled = 'Yes' AND WitnessPresent = 'Yes'
ORDER BY 3 DESC;
