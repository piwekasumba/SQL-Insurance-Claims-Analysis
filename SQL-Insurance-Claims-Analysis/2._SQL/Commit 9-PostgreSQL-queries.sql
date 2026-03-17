-- Export claims_clean table to CSV
 claims_clean TO 'data/claims_clean.csv' CSV HEADER;

-- Export customer_summary table to CSV
 customer_summary TO 'data/customer_summary.csv' CSV HEADER;

-- Export policy_summary table to CSV
policy_summary TO 'data/policy_summary.csv' CSV HEADER;

-- Export flagged customers from fraud detection
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
) TO 'data/fraud_flagged_customers.csv' CSV HEADER;

