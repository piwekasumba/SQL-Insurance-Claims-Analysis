-- Create tables
CREATE TABLE IF NOT EXISTS claims_raw (
    claim_id SERIAL PRIMARY KEY,
    policy_id INT,
    customer_id INT,
    claim_amount NUMERIC,
    claim_date DATE,
    policy_type VARCHAR(50),
    fraud_flag BOOLEAN
);

-- Clean data
DELETE FROM claims_raw WHERE claim_amount IS NULL;
UPDATE claims_raw SET policy_type = INITCAP(policy_type);

-- Transform / Derived Metrics
CREATE TABLE claims_clean AS
SELECT *,
       EXTRACT(YEAR FROM claim_date) AS claim_year,
       CASE 
           WHEN claim_amount > 50000 THEN 'High'
           WHEN claim_amount > 10000 THEN 'Medium'
           ELSE 'Low'
       END AS claim_risk_level
FROM claims_raw;

-- Aggregations for insights
CREATE TABLE claims_summary AS
SELECT policy_type,
       COUNT(*) AS total_claims,
       AVG(claim_amount) AS avg_claim,
       SUM(CASE WHEN fraud_flag THEN 1 ELSE 0 END) AS total_fraud
FROM claims_clean
GROUP BY policy_type;

