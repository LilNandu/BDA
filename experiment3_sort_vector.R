# BDA Experiment 3: Sort the given vector in ascending and descending order
# HOW TO RUN ON UBUNTU:
# 1. Install R if needed: sudo apt update && sudo apt install -y r-base
# 2. Open a terminal in the folder containing this file.
# 3. Run: Rscript experiment3_sort_vector.R
# INPUT: c(33, 55, 20, 34, 99, 23, 67, 82) (the practical-sheet values).
# EXPECTED OUTPUT:
# Ascending:  20 23 33 34 55 67 82 99
# Descending: 99 82 67 55 34 33 23 20

numbers <- c(33, 55, 20, 34, 99, 23, 67, 82)

cat("Original vector:\n")
print(numbers)

ascending <- sort(numbers, decreasing = FALSE)
descending <- sort(numbers, decreasing = TRUE)

cat("Ascending order:\n")
print(ascending)

cat("Descending order:\n")
print(descending)
