CREATE TABLE customerss (
    customer_id SERIAL PRIMARY KEY,
    age INT,
    sex VARCHAR(10),
    bmi NUMERIC,
    children INT,
    smoker VARCHAR(10),
    region VARCHAR(50)
);

CREATE TABLE claimss (
    claim_id SERIAL PRIMARY KEY,
    customer_id INT,
    claim_amount NUMERIC,
    claim_date DATE
);

COPY customerss(age, sex, bmi, children, smoker, region)
FROM '/path/customers.csv'
DELIMITER ','
CSV HEADER;

COPY claimss(customer_id, claim_amount, claim_date)
FROM '/path/claims.csv'
DELIMITER ','
CSV HEADER;

SELECT region, SUM(claim_amount) AS total_claims
FROM customerss
JOIN claims
ON customerss.customer_id = claimss.customer_id
GROUP BY region;

SELECT smoker, AVG(claim_amount) AS avg_claim
FROM customerss
JOIN claims
ON customerss.customer_id = claimss.customer_id
GROUP BY smoker;

SELECT customer_id, MAX(claim_amount) AS highest_claim
FROM claimss
GROUP BY customer_id
ORDER BY highest_claim DESC
LIMIT 10;

SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(*) AS total_claims
FROM customerss
JOIN claimss
ON customerss.customer_id = claimss.customer_id
GROUP BY age_group;

