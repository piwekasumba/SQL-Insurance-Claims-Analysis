• Insurance Claims Analysis (SQL Project)

This project focuses on cleaning and analyzing insurance claims data using PostgreSQL.

The dataset contains issues commonly found in real-world data such as:

missing values
duplicate records
inconsistent categories
unstructured information

The goal of the project was to take raw insurance claims data and turn it into a cleaner, more usable dataset for reporting and analysis.

• What I Worked On

In this project, I used SQL to:

clean and standardize raw data
handle null and duplicate values
join related tables
create analysis-focused queries
explore business-related claim trends

I also focused on writing readable SQL queries and structuring the workflow step-by-step to better understand how raw data is prepared before reporting or dashboarding.

• Tools Used

PostgreSQL
SQL
Git & GitHub

• Project Contents

Data cleaning queries
Transformation queries
Exploratory analysis queries
Business insight examples

• Example Query

SELECT 
    customer_id,
    SUM(claim_amount) AS total_claim_value
FROM claims
WHERE claim_status = 'Approved'
GROUP BY customer_id
ORDER BY total_claim_value DESC;

