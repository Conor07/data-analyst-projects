/*
 Question: What are the top-paying Data Analyst and Data Scientist jobs?
 
 - Identify the top 25 highest-paying Data Analyst and Data Scientist jobs that are available remotely ('Anywhere') or in the United Kingdom.
 - Focuses on the job postings with specified salaries (remove NULLs).
 - Why? Highlight the top-paying opportunities for Data Analysts and Data Scientists, offering insights into employment trends and potential career paths in the field.
 */
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::DATE AS job_posted_date,
    company_dim.name AS company_name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE (
        job_title_short = 'Data Analyst'
        OR job_title_short = 'Data Scientist'
    )
    AND (
        job_location = 'Anywhere'
        OR job_location = 'United Kingdom'
    )
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 25;