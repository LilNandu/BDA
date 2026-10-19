-- BDA Experiment 1: Basic Apache Hive commands on Ubuntu
-- HOW TO RUN:
-- 1. Make sure Hadoop and Hive are installed and configured.
-- 2. From the terminal, run one of these commands:
--      hive -f experiment1_hive_commands.hql
--    OR, when HiveServer2 is running:
--      beeline -u 'jdbc:hive2://localhost:10000/default' -f experiment1_hive_commands.hql
-- 3. This script creates a database/table, shows and describes them, then drops the table.
-- 4. It keeps the database after execution. To remove the database too, uncomment the final line. or nano install_hive_practical.sh

-- CREATE: create a database if it does not already exist.
CREATE DATABASE IF NOT EXISTS bda_practical;

-- SHOW: list all databases; bda_practical should appear in this list.
SHOW DATABASES;

-- USE: make bda_practical the active database for following commands.
USE bda_practical;

-- CREATE: create a simple student table.
CREATE TABLE IF NOT EXISTS student (
    student_id INT,
    student_name STRING,
    age INT
)
COMMENT 'Sample table for BDA Hive practical'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

-- SHOW: list tables in the currently selected database; student should appear.
SHOW TABLES;

-- DESCRIBE: show column names and data types for the student table.
DESCRIBE student;

-- DESCRIBE FORMATTED: optional extra details about storage and table metadata.
DESCRIBE FORMATTED student;

-- DROP: remove the student table if it exists.
DROP TABLE IF EXISTS student;

-- SHOW again to verify that student has been removed.
SHOW TABLES;

-- OPTIONAL CLEANUP: remove the database and its contents as well.
-- Uncomment this line only if you want to delete bda_practical completely.
-- DROP DATABASE IF EXISTS bda_practical CASCADE;
