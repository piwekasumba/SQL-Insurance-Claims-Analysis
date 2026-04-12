-- CLAIMS BY REGION

SELECT 
region,
COUNT(claim_id) AS total_claims,
SUM(claim_amount) AS total_amount
FROM customerss c
JOIN claimss cl
ON c.customer_id = cl.customer_id
GROUP BY region;

-- CLAIM RISK BY SMOKER STATUS

SELECT 
smoker,
COUNT(claim_id) AS total_claims,
AVG(claim_amount) AS avg_claim_amount
FROM customerss c
JOIN claimss cl
ON c.customer_id = cl.customer_id
GROUP BY smoker;

-- TOP CUSTOMERS BY CLAIM VALUE

SELECT 
customer_id,
MAX(claim_amount) AS highest_claim
FROM claimss
GROUP BY customer_id
ORDER BY highest_claim DESC
LIMIT 10;

-- AGE GROUP CLAIM DISTRIBUTION

SELECT
CASE
WHEN age < 30 THEN 'Under 30'
WHEN age BETWEEN 30 AND 50 THEN '30-50'
ELSE 'Over 50'
END AS age_group,
COUNT(claim_id) AS total_claims
FROM customerss c
JOIN claimss cl
ON c.customer_id = cl.customer_id
GROUP BY age_group;

-- STANDARDISE SEX VALUES

UPDATE customerss
SET sex = LOWER(sex);

-- FIX NEGATIVE CLAIM VALUES

UPDATE claimss
SET claim_amount = ABS(claim_amount)
WHERE claim_amount < 0;

