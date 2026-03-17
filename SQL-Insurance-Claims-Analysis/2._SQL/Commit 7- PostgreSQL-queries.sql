SELECT
    c.customer_id,
    c.full_name,
    COUNT(cl.claim_id) AS num_claims,
    SUM(cl.claim_amount) AS total_claim_amount
FROM customer_summary c
JOIN claims_clean cl ON c.customer_id = cl.customer_id
WHERE cl.claim_year = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY c.customer_id, c.full_name
HAVING COUNT(cl.claim_id) > 5
ORDER BY num_claims DESC;

-- Claims that are above 2 standard deviations of the average claim amount
WITH stats AS (
    SELECT 
        AVG(claim_amount) AS avg_amount,
        STDDEV(claim_amount) AS std_dev
    FROM claims_clean
)
SELECT
    cl.claim_id,
    cl.customer_id,
    cl.claim_amount,
    cl.claim_date,
    cl.policy_number,
    cl.claim_status_clean
FROM claims_clean cl, stats s
WHERE cl.claim_amount > (s.avg_amount + 2 * s.std_dev)
ORDER BY cl.claim_amount DESC;

-- Policies with multiple high-severity claims in a short period
SELECT
    policy_number,
    COUNT(*) AS high_severity_claims,
    MIN(claim_date) AS first_claim_date,
    MAX(claim_date) AS last_claim_date
FROM claims_clean
WHERE claim_severity = 'High'
GROUP BY policy_number
HAVING COUNT(*) >= 3 AND (MAX(claim_date) - MIN(claim_date)) <= INTERVAL '90 days'
ORDER BY high_severity_claims DESC;


-- Customers flagged for multiple fraud indicators
WITH high_freq AS (
    SELECT customer_id
    FROM claims_clean
    GROUP BY customer_id
    HAVING COUNT(claim_id) > 5
),
high_amount AS (
    SELECT customer_id
    FROM claims_clean, (
        SELECT AVG(claim_amount) AS avg_amount, STDDEV(claim_amount) AS std_dev FROM claims_clean
    ) stats
    WHERE claim_amount > (stats.avg_amount + 2 * stats.std_dev)
)

SELECT DISTINCT c.customer_id, c.full_name
FROM customers c
JOIN high_freq hf ON c.customer_id = hf.customer_id
JOIN high_amount ha ON c.customer_id = ha.customer_id
ORDER BY c.customer_id;


