/*
 Question: What are the top skills based on salary for Data Analyst and Data Scientist roles?
 - Look at the average salary for each skill associated for Data Analyst and Data Scientist job postings.
 - Focuses on roles with specified salaries in the United Kingdom and remote positions ('Anywhere').
 - Only focus on skills that are in more than 100 job postings to ensure statistical significance.
 - Why? It reveals how different skills impact salaries for Data Analyst and Data Scientist roles, helping job seekers understand which skills may lead to higher-paying opportunities.
 */
SELECT skills,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
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
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND skills IS NOT NULL
GROUP BY skills
HAVING COUNT(skills) > 100
ORDER BY average_salary DESC
LIMIT 25;
-- Result: Data Scientist skills such as 'pytorch' and 'tensorflow' are among the top-paying skills, however, critical analyst skills such as 'python' and 'sql' also show high average salaries, indicating that both technical and analytical skills are valuable in the job market for these roles.