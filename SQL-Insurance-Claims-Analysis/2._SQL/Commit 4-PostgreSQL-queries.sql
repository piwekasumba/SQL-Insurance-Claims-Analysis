-- Create customers table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    age INT,
    sex VARCHAR(10),
    bmi NUMERIC(5,2),
    children INT,
    smoker VARCHAR(10),
    region VARCHAR(50)
);

-- Create claims table
CREATE TABLE claims (
    claim_id SERIAL PRIMARY KEY,
    customer_id INT,
    claim_amount NUMERIC(10,2),
    claim_date DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Import customer data
COPY customers(age, sex, bmi, children, smoker, region)
FROM '/path/customers.csv'
DELIMITER ','
CSV HEADER;

-- Import claims data
COPY claims(customer_id, claim_amount, claim_date)
FROM '/path/claims.csv'
DELIMITER ','
CSV HEADER;

-- Total claim amount by region
SELECT
    region,
    SUM(claim_amount) AS total_claim_amount
FROM customers
JOIN claims
ON customers.customer_id = claims.customer_id
GROUP BY region
ORDER BY total_claim_amount DESC;

-- Average claim amount by smoker status
SELECT
    smoker,
    ROUND(AVG(claim_amount), 2) AS average_claim_amount
FROM customers
JOIN claims
ON customers.customer_id = claims.customer_id
GROUP BY smoker;

-- Top 10 highest individual claims
SELECT
    customer_id,
    MAX(claim_amount) AS highest_claim
FROM claims
GROUP BY customer_id
ORDER BY highest_claim DESC
LIMIT 10;

-- Number of claims by age group
SELECT
    CASE
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(claim_id) AS total_claims
FROM customers
JOIN claims
ON customers.customer_id = claims.customer_id
GROUP BY age_group
ORDER BY total_claims DESC;

---

