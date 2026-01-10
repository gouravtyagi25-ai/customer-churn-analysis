-- create databas customer_churn
CREATE DATABASE if not exists customer_churn;
USE customer_churn;

-- create table schema
CREATE TABLE customer_churn (
    customerID VARCHAR(50),
    gender VARCHAR(10),
    SeniorCitizen INT,
    Partner VARCHAR(5),
    Dependents VARCHAR(5),
    tenure INT,
    PhoneService VARCHAR(5),
    MultipleLines VARCHAR(30),
    InternetService VARCHAR(20),
    OnlineSecurity VARCHAR(30),
    OnlineBackup VARCHAR(30),
    DeviceProtection VARCHAR(30),
    TechSupport VARCHAR(30),
    StreamingTV VARCHAR(30),
    StreamingMovies VARCHAR(30),
    Contract VARCHAR(20),
    PaperlessBilling VARCHAR(5),
    PaymentMethod VARCHAR(50),
    MonthlyCharges DECIMAL(10,2),
    TotalCharges VARCHAR(20),
    Churn VARCHAR(5)
);

-- check record count
SELECT COUNT(*) FROM customer_churn;

-- It avoid numeric conversion issues
UPDATE customer_churn
SET Totalcharges = NULL 
WHERE TRIM(Totalcharges) = '';

-- now create clean numeric column for Totalcharges
ALTER TABLE customer_churn
ADD COLUMN Totalcharges_Num DECIMAL(10, 2);

UPDATE customer_churn
SET Totalcharges_Num = CAST(TotalCharges AS DECIMAL(10,2))
WHERE Totalcharges IS NOT NULL;

-- Final Validation
SELECT COUNT(*) FROM customer_churn;

-- Check how many customers churned vs stayed.
SELECT Churn, COUNT(*) FROM customer_churn GROUP BY Churn;
-- Yes: Churned customer; No: Stayed customers

-- Convert Churn counts into percentange
SELECT Churn, ROUND(
				COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_churn), 2
) AS churn_percentage
FROM customer_churn GROUP BY Churn;

-- Churn behavior across different contract types
SELECT Contract, COUNT(*) AS total_customers, 
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers,
ROUND(
	SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2
) AS churn_rate
FROM customer_churn GROUP BY Contract ORDER BY churn_rate DESC;
/*
EXPLANATION:
- Month-to-month customers are at high risk with almost 43%, exact 42.71%.
- With 1 year contract customers churns drops to 11%, exact 11.27%.
- With 2 year contract customers churns drops to 3%, exact 2.83%.
*/

/*
COUNT(*) → total customers in that contract
CASE WHEN → flags churned customers
SUM() → counts churned customers
Percentage → churn rate per contract
ORDER BY → shows worst churn first
*/

-- Check for higher and lower monthly charge customer.
SELECT
	-- Convert numeric values into categorial (Low, Medium, High)
	CASE
		WHEN MonthlyCharges < 35 THEN 'Low Charges'
        WHEN MonthlyCharges BETWEEN 35 AND 70 THEN 'Medium Charges'
        ELSE 'High Charges'
	END AS charge_bucket,
    
    -- count of total customer(churn and stayed)
    COUNT(*) AS total_customers,
    
    -- count of only churn customers
    SUM(CASE
			WHEN Churn = 'YES' THEN 1
            ELSE 0
		END) AS churned_cutomers,
	
    -- churn rate to analyse Low, Medium and High charges
	ROUND(
		SUM(CASE
				WHEN Churn = 'Yes' THEN 1
                ELSE 0
			END) * 100.0 / COUNT(*), 2
    ) AS churn_rate
FROM customer_churn
GROUP BY charge_bucket ORDER BY churn_rate DESC;