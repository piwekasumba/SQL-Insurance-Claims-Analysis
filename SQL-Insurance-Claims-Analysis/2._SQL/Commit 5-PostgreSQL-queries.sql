-- Create a clean, analysis-ready claims table
CREATE TABLE claims_clean AS
SELECT
    claim_id,
    customer_id,
    policy_number,
    claim_date,
    claim_amount,
    UPPER(claim_status) AS claim_status_clean,  -- Standardize status to uppercase
    COALESCE(claim_type, 'Unknown') AS claim_type_clean,  -- Fill missing claim types
    LEFT(description, 255) AS description_short,  -- Limit description length
    processed_by,
    created_at,
    EXTRACT(YEAR FROM claim_date) AS claim_year,  -- Derived metric
    EXTRACT(MONTH FROM claim_date) AS claim_month,
    CASE 
        WHEN claim_amount > 50000 THEN 'High'
        WHEN claim_amount BETWEEN 10000 AND 50000 THEN 'Medium'
        ELSE 'Low'
    END AS claim_severity  -- Derived field
FROM claims;

-- Summarize customers with claim statistics
CREATE TABLE customer_summary AS
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.gender,
    COUNT(cl.claim_id) AS total_claims,
    SUM(cl.claim_amount) AS total_claim_amount,
    AVG(cl.claim_amount) AS avg_claim_amount,
    MAX(cl.claim_amount) AS max_claim_amount,
    MIN(cl.claim_amount) AS min_claim_amount
FROM customers c
LEFT JOIN claims_clean cl ON c.customer_id = cl.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.gender;

-- Aggregate claims by policy
CREATE TABLE policy_summary AS
SELECT
    policy_number,
    COUNT(claim_id) AS num_claims,
    SUM(claim_amount) AS total_claim_amount,
    AVG(claim_amount) AS avg_claim_amount,
    MAX(claim_amount) AS max_claim_amount,
    MIN(claim_amount) AS min_claim_amount
FROM claims_clean
GROUP BY policy_number;

