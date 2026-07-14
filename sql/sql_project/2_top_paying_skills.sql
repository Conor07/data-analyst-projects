/*
 Question: What skills are required for top-paying Data Analyst and Data Scientist roles?
 
 - Use the top 25 highest-paying Data Analyst and Data Scientist jobs identified in the first query file.
 - Add the specific skills required for these roles, as listed in the job postings.
 - Why? This analysis will provide insights into the key skills that are in demand for high-paying Data Analyst and Data Scientist positions, helping job seekers understand what skills they need to work on.
 */
WITH top_paying_jobs AS (
    SELECT job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
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
    LIMIT 25
)
SELECT top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
    INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
-- Results:
-- SQL and Python are the most commonly required skills for top-paying Data Analyst and Data Scientist roles, followed by Machine Learning and Data Visualizationa technologies.