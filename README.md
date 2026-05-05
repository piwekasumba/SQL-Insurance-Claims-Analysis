# SQL Insurance Claims Analysis – ETL & Data Transformation

-  Project Overview

This project focuses on using SQL (PostgreSQL) to simulate a basic ETL workflow on insurance claims data.

The goal is to take raw, unstructured data and transform it into a clean, structured format that can be used for analysis.

---

-  Why This Matters

In real-world data environments, raw data is rarely ready for analysis.

Common challenges include:
- Missing values  
- Inconsistent formats  
- Duplicate records  

Being able to clean and structure data using SQL is a core skill for entry-level data roles such as Data Analyst and a foundation for Data Engineering.

---

 - What This Project Demonstrates

- Writing SQL queries to clean and standardize raw data  
- Handling missing values and inconsistent formats  
- Using JOINs to combine multiple datasets  
- Applying aggregations and filters to explore data  
- Structuring data into analysis-ready tables  
- Thinking through problems step-by-step using SQL  

---

- Tech & Tools

- PostgreSQL  
- SQL  
- Relational database concepts  
- Git & GitHub  

---

- Project Structure

- SQL Scripts  
  Step-by-step queries for:
  - Data cleaning  
  - Data transformation  
  - Basic analysis  

- Documentation  
  Explanations are included alongside queries to improve clarity and understanding.

This project focuses on building strong SQL foundations and clear thinking, rather than production-level pipeline development.

---

- Example Query

```sql
-- Example: Identify total claim amount per customer

SELECT 
    customer_id,
    SUM(claim_amount) AS total_claim_amount
FROM claims
WHERE claim_status = 'Approved'
GROUP BY customer_id
ORDER BY total_claim_amount DESC;

