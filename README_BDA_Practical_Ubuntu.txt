BDA PRACTICAL LIST — UBUNTU RUN GUIDE
====================================

This file contains all five practical experiments from the supplied BDA practical list.
The R experiments can run directly on Ubuntu after installing R. Hive requires an existing,
working Apache Hadoop/Hive setup; installing R alone does not install Hive.

FILES INCLUDED IN THE READY-TO-RUN PACK
---------------------------------------
experiment1_hive_commands.hql       Experiment 1: Hive commands
experiment2_vector_arithmetic.R     Experiment 2: Vector arithmetic
experiment3_sort_vector.R           Experiment 3: Ascending/descending sort
experiment4_functions.R             Experiment 4: Functions with/without arguments
experiment5_sequence_stats.R        Experiment 5: Sequence, mean, maximum and sum

PART A — PREPARE UBUNTU FOR R EXPERIMENTS
-----------------------------------------
1. Open Terminal.
2. Install R (one-time setup):

   sudo apt update
   sudo apt install -y r-base

3. Verify the installation:

   Rscript --version

4. Download/extract the ready-to-run files. If you downloaded the ZIP pack, open Terminal in
   the download folder and run:

   unzip BDA_Practical_Ubuntu_Pack.zip
   cd BDA_Practical_Ubuntu_Pack

   If you are using the individual .R files, place all of them in one folder and use `cd` to
   move into that folder. If you only have this TXT file, create a file for each R experiment:

   nano experiment2_vector_arithmetic.R

   Copy only the code for Experiment 2 from this TXT file into nano. Save with Ctrl+O, press
   Enter, and exit with Ctrl+X. Repeat with the matching filename for Experiments 3–5.

5. Run each R script from the terminal in the folder containing the file:

   Rscript experiment2_vector_arithmetic.R
   Rscript experiment3_sort_vector.R
   Rscript experiment4_functions.R
   Rscript experiment5_sequence_stats.R

No additional R packages are required. Inputs are already included in the scripts, so you do
not need to type anything when they run.

EXPERIMENT 1 — BASIC APACHE HIVE COMMANDS
========================================
AIM:
To use CREATE, SHOW, USE, DESCRIBE and DROP in Hive, create a database and table, and inspect
its schema.

BEFORE RUNNING:
Hive depends on compatible Java and Hadoop installations and Hive configuration. Check what is
available in Terminal:

   java -version
   hadoop version
   hive --version
   beeline --version

Not every installation has both `hive` and `beeline`. Hive's older CLI may be deprecated in
favour of Beeline/HiveServer2. If Hive is not installed/configured, use your college's Hadoop/Hive
lab setup or the official installation guide linked at the end. There is no reliable universal
single `apt install hive` command for a complete working Hadoop + Hive environment.

CODE (save as experiment1_hive_commands.hql):
--------------------------------------------
-- BDA Experiment 1: Basic Apache Hive commands on Ubuntu
-- Run from the terminal using either:
--   hive -f experiment1_hive_commands.hql
-- or, when HiveServer2 is running:
--   beeline -u 'jdbc:hive2://localhost:10000/default' -f experiment1_hive_commands.hql

CREATE DATABASE IF NOT EXISTS bda_practical;
SHOW DATABASES;
USE bda_practical;

CREATE TABLE IF NOT EXISTS student (
    student_id INT,
    student_name STRING,
    age INT
)
COMMENT 'Sample table for BDA Hive practical'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;

SHOW TABLES;
DESCRIBE student;
DESCRIBE FORMATTED student;
DROP TABLE IF EXISTS student;
SHOW TABLES;

-- Optional: uncomment the next line to remove the database too.
-- DROP DATABASE IF EXISTS bda_practical CASCADE;

HOW TO SAVE AND RUN THE HIVE FILE:
1. Save the code above in a file named `experiment1_hive_commands.hql`.
   You can create it in Terminal using:

   nano experiment1_hive_commands.hql

   Paste the Hive code, then save with Ctrl+O, Enter, and exit with Ctrl+X.

2. If the legacy Hive CLI is configured, run:

   hive -f experiment1_hive_commands.hql

   If HiveServer2 is already running locally, run:

   beeline -u 'jdbc:hive2://localhost:10000/default' -f experiment1_hive_commands.hql

   The Beeline command assumes HiveServer2 is listening on localhost port 10000. If your lab uses
   a different hostname, port, authentication method, or JDBC URL, use the details provided by
   your lab administrator. Start HiveServer2 first if your setup requires it.

WHAT EACH HIVE COMMAND DOES:
CREATE DATABASE — creates a database/namespace for tables.
SHOW DATABASES — lists databases.
USE — selects the database for later table commands.
CREATE TABLE — creates a table definition with three columns: student_id, student_name and age.
SHOW TABLES — lists tables in the selected database.
DESCRIBE student — displays the table's columns and data types.
DESCRIBE FORMATTED student — shows more metadata about the table.
DROP TABLE — deletes the table definition and associated table data managed by Hive.
DROP DATABASE ... CASCADE — optional cleanup that removes the database and its tables. It is
commented out by default to avoid deleting the database unless you choose to.

EXPECTED OBSERVATIONS:
- `SHOW DATABASES` should include `bda_practical` along with system/other databases.
- After `USE bda_practical`, `SHOW TABLES` should list `student`.
- `DESCRIBE student` should show these columns and types:

  student_id    int
  student_name  string
  age           int

- After `DROP TABLE`, a final `SHOW TABLES` should no longer list `student`.
- Exact formatting and extra metadata lines can differ by Hive version.

EXPERIMENT 2 — VECTOR ADDITION, SUBTRACTION, MULTIPLICATION AND DIVISION
=======================================================================
AIM: Perform arithmetic operations element-by-element on two R vectors.

CODE (save as experiment2_vector_arithmetic.R):
------------------------------------------------
# Install R once if needed: sudo apt update && sudo apt install -y r-base
# Run: Rscript experiment2_vector_arithmetic.R
# Input vectors are x = c(10, 20, 30) and y = c(2, 4, 5).

x <- c(10, 20, 30)
y <- c(2, 4, 5)

cat("Vector x:\n"); print(x)
cat("Vector y:\n"); print(y)

cat("Addition (x + y):\n")
print(x + y)

cat("Subtraction (x - y):\n")
print(x - y)

cat("Multiplication (x * y):\n")
print(x * y)

cat("Division (x / y):\n")
print(x / y)

RUN:
   Rscript experiment2_vector_arithmetic.R

EXPECTED OUTPUT (formatting may vary slightly):
Vector x:
[1] 10 20 30
Vector y:
[1] 2 4 5
Addition (x + y):
[1] 12 24 35
Subtraction (x - y):
[1]  8 16 25
Multiplication (x * y):
[1]  20  80 150
Division (x / y):
[1] 5 5 6

EXPERIMENT 3 — SORT VECTOR IN ASCENDING AND DESCENDING ORDER
===========================================================
AIM: Sort the values supplied in the practical list.

CODE (save as experiment3_sort_vector.R):
-----------------------------------------
# Run: Rscript experiment3_sort_vector.R
# Input values are taken from the practical list.

numbers <- c(33, 55, 20, 34, 99, 23, 67, 82)

cat("Original vector:\n")
print(numbers)

ascending <- sort(numbers, decreasing = FALSE)
descending <- sort(numbers, decreasing = TRUE)

cat("Ascending order:\n")
print(ascending)

cat("Descending order:\n")
print(descending)

RUN:
   Rscript experiment3_sort_vector.R

EXPECTED OUTPUT:
Original vector:
[1] 33 55 20 34 99 23 67 82
Ascending order:
[1] 20 23 33 34 55 67 82 99
Descending order:
[1] 99 82 67 55 34 33 23 20

EXPERIMENT 4 — FUNCTION WITH ARGUMENTS AND WITHOUT ARGUMENTS
===========================================================
AIM: Demonstrate R functions that do not receive arguments and functions that receive arguments.

CODE (save as experiment4_functions.R):
---------------------------------------
# Run: Rscript experiment4_functions.R
# No keyboard input is required; example arguments are passed in the function calls below.

# Function WITHOUT arguments
say_hello <- function() {
  cat("Hello! This function has no arguments.\n")
}

# Function WITH arguments
introduce <- function(name, subject) {
  cat(sprintf("Hello, %s. Your practical is %s.\n", name, subject))
}

# Function with arguments that returns a calculated value
add_numbers <- function(a, b) {
  result <- a + b
  return(result)
}

say_hello()
introduce("Asha", "BDA")
cat("Sum of 10 and 20 =", add_numbers(10, 20), "\n")

RUN:
   Rscript experiment4_functions.R

EXPECTED OUTPUT:
Hello! This function has no arguments.
Hello, Asha. Your practical is BDA.
Sum of 10 and 20 = 30

Note: R's `cat()` prints exactly the spaces in the strings/arguments. The function examples are
for demonstration; change "Asha" or "BDA" to your own example if desired.

EXPERIMENT 5 — SEQUENCE FROM 20 TO 60; MEAN, MAXIMUM AND SUM
============================================================
AIM: Generate all integers from 20 through 60 and calculate the mean, maximum and sum.

CODE (save as experiment5_sequence_stats.R):
--------------------------------------------
# Run: Rscript experiment5_sequence_stats.R
# No keyboard input is required; seq() generates the sequence.

numbers <- seq(from = 20, to = 60, by = 1)

cat("Sequence from 20 to 60:\n")
print(numbers)

cat("Mean:", mean(numbers), "\n")
cat("Maximum:", max(numbers), "\n")
cat("Sum:", sum(numbers), "\n")

RUN:
   Rscript experiment5_sequence_stats.R

EXPECTED FINAL LINES:
Mean: 40
Maximum: 60
Sum: 1640

The complete sequence contains every integer from 20 through 60, inclusive (41 numbers).

TROUBLESHOOTING
===============
- `Rscript: command not found`: install R with `sudo apt update && sudo apt install -y r-base`.
- `hive: command not found`: Hive is not installed or its `bin` directory is not on PATH. A working
  Hadoop/Hive environment is required for Experiment 1.
- Beeline connection refused: start HiveServer2 and confirm its host/port/JDBC URL with your lab.
- Permission or HDFS errors: the Hadoop/Hive services and warehouse directories may need to be
  configured by the lab administrator; the SQL code itself cannot repair an incomplete cluster.
- To see an R script interactively, run `R` and type the code line-by-line, or use `Rscript` as shown
  above (recommended for these saved files).

OFFICIAL REFERENCES
===================
Apache Hive Getting Started:
https://hive.apache.org/development/gettingstarted-latest/

Apache Hive installation manual:
https://hive.apache.org/docs/latest/admin/adminmanual-installation/

Ubuntu Rscript manual:
https://manpages.ubuntu.com/manpages/noble/man1/Rscript.1.html
