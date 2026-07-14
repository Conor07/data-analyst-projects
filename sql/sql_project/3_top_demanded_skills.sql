/*
 Question:Whare the most in-demand skills for Data Analyst and Data Scientist roles?
 - Join job posting to inner join table similar to query in file 2.ABORT
 - Identify the top 5 in-demand skills for Data Analyst and Data Scientist roles based on the frequency of their occurrence in job postings.
 - Focus on job postings that are available remotely ('Anywhere') or in the United Kingdom.
 - Why? Retreives the top 5 skills with highest demand in the job market, providing insights into the most valuable skills for job seekers.
 */
SELECT skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE (
        job_postings_fact.job_title_short = 'Data Analyst'
        OR job_postings_fact.job_title_short = 'Data Scientist'
    )
    AND (
        job_postings_fact.job_location = 'Anywhere'
        OR job_postings_fact.job_location = 'United Kingdom'
    )
GROUP BY skills
ORDER BY demand_count DESC
LIMIT 5;