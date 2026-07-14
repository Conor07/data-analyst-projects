/*
 (This a CTE version of the query in 5_optimal_skills.sql, which is more efficient as it calculates the demand count and average salary separately before joining the results. This approach reduces the number of calculations needed and can improve performance, especially with larger datasets. The final output remains the same, providing insights into the most optimal skills for Data Analyst and Data Scientist roles based on demand and salary).
 Question: What are the most optial skills to learn for a Data Analyst or Data Scientist role?
 - Identify skills in high demand and associated with higher salaries for Data Analyst and Data Scientist roles.
 - Concentrates on remote positions ('Anywhere') and roles in the United Kingdom with specified salaries.
 - Why? Targets skills that offer job security (high demand) and financial benefits (higher salaries), guiding job seekers on which skills to prioritize for career growth in the data field.
 */
WITH skills_demand AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
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
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),
average_salary AS (
    SELECT skills_dim.skill_id,
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
    GROUP BY skills_dim.skill_id
    HAVING COUNT(skills) > 100
)
SELECT skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    average_salary
FROM skills_demand
    INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE demand_count > 10
ORDER BY average_salary DESC,
    demand_count DESC
LIMIT 25;
-- Result: Skills such as 'pytorch' and 'tensorflow' are among the top-paying skills, however, critical analyst skills such as 'python' and 'sql' also show high average salaries, indicating that both technical and analytical skills are valuable in the job market for these roles. This suggests that while specialized skills can lead to higher salaries, foundational skills remain essential for career growth in the data field.