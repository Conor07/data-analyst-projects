/* 
 Replace the file paths in the code below with the absolute file paths of your csv files to load data into the tables.
 
 Database Load Issues (follow if receiving permission denied when running SQL code below)
 
 Possible Errors: 
 - ERROR >>  duplicate key value violates unique constraint "company_dim_pkey"
 - ERROR >> could not open file "C:\Users\...\company_dim.csv" for reading: Permission denied
 
 1. Drop the Database 
 DROP DATABASE IF EXISTS sql_course;
 2. Repeat steps to create database and load table schemas
 - 1_create_database.sql
 - 2_create_tables.sql
 3. Open pgAdmin
 4. In Object Explorer (left-hand pane), navigate to `sql_course` database
 5. Right-click `sql_course` and select `PSQL Tool`
 - This opens a terminal window to write the following code
 6. Get the absolute file path of your csv files
 1. Find path by right-clicking a CSV file in VS Code and selecting “Copy Path”
 7. Paste the following into `PSQL Tool`, (with the CORRECT file path)
 
 \copy company_dim FROM '<company_dim.csv file location>' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 \copy skills_dim FROM '<skills_dim.csv file location>' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 \copy job_postings_fact FROM '<job_postings_fact.csv file location>' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 \copy skills_job_dim FROM '<skills_job_dim.csv file location>' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');
 
 */
-- NOTE: This has been updated from the video to fix issues with encoding
COPY company_dim
FROM "<company_dim.csv file location>" WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
COPY skills_dim
FROM "<skills_dim.csv file location>" WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
COPY job_postings_fact
FROM "<job_postings_fact.csv file location>" WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
COPY skills_job_dim
FROM "<skills_job_dim.csv file location>" WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );