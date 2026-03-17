-- Count of claims per status
SELECT 
    claim_status_clean AS status,
    COUNT(*) AS num_claims,
    SUM(claim_amount) AS total_claim_amount,
    AVG(claim_amount) AS avg_claim_amount
FROM claims_clean
GROUP BY claim_status_clean
ORDER BY num_claims DESC;

-- Number of claims and total claim amount by month
SELECT
    claim_year,
    claim_month,
    COUNT(*) AS num_claims,
    SUM(claim_amount) AS total_claim_amount,
    AVG(claim_amount) AS avg_claim_amount
FROM claims_clean
GROUP BY claim_year, claim_month
ORDER BY claim_year, claim_month;

-- Average claim amount by claim type
SELECT
    claim_type_clean AS claim_type,
    COUNT(*) AS num_claims,
    AVG(claim_amount) AS avg_claim_amount,
    MAX(claim_amount) AS max_claim_amount,
    MIN(claim_amount) AS min_claim_amount
FROM claims_clean
GROUP BY claim_type_clean
ORDER BY avg_claim_amount DESC;

-- Identify high-value customers
SELECT
    cs.customer_id,
    cs.full_name,
    cs.total_claims,
    cs.total_claim_amount,
    cs.avg_claim_amount
FROM customer_summary cs
ORDER BY cs.total_claim_amount DESC
LIMIT 10;

-- Number of claims by severity
SELECT
    claim_severity,
    COUNT(*) AS num_claims,
    SUM(claim_amount) AS total_claim_amount
FROM claims_clean
GROUP BY claim_severity
ORDER BY FIELD(claim_severity, 'High', 'Medium', 'Low');  -- PostgreSQL workaround: use CASE if needed


