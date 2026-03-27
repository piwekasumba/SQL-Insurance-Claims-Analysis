# Insurance Claims Analysis (PostgreSQL)

## Project Overview
This project analyzes insurance claims data using PostgreSQL, focusing on transforming raw data into meaningful business insights.

It simulates a real-world data workflow where structured datasets are cleaned, processed, and analyzed to support decision-making.

## Objectives
- Clean and prepare raw insurance data
- Perform SQL joins and aggregations
- Analyze claim patterns across different customer segments
- Generate insights relevant to business and risk assessment

## Why This Project Matters
Insurance companies rely heavily on data to assess risk, detect patterns, and control costs.

This project demonstrates how SQL can be used to:
- Identify high-risk groups
- Understand cost drivers
- Support data-driven business decisions
- Build the foundation for scalable analytics pipelines

## Key Features
- Data cleaning and preprocessing
- SQL JOIN operations across multiple tables
- Aggregations using GROUP BY
- Filtering and segmentation of data
- Business-focused analytical queries

## Tech & Tools
- PostgreSQL
- SQL
- Git & GitHub

## Key Business Questions Answered
1. Which regions have the highest claim costs?
2. Do smokers generate higher insurance claims?
3. How do age and BMI impact claim amounts?
4. Which customer segments contribute most to total costs?

## Example Insights
- Certain regions show consistently higher claim totals, indicating possible risk concentration
- Smokers tend to have higher average claim costs compared to non-smokers
- Higher BMI and age are correlated with increased insurance expenses

## Example Queries
```sql
-- Average claim cost by smoker status
SELECT smoker, AVG(claim_amount) AS avg_claim
FROM insurance_claims
GROUP BY smoker;

-- Total claims by region
SELECT region, SUM(claim_amount) AS total_claims
FROM insurance_claims
GROUP BY region;
