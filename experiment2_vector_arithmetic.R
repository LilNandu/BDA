# BDA Experiment 2: Vector addition, subtraction, multiplication and division in R
# HOW TO RUN ON UBUNTU:
# 1. Install R if needed: sudo apt update && sudo apt install -y r-base
# 2. Open a terminal in the folder containing this file.
# 3. Run: Rscript experiment2_vector_arithmetic.R
# INPUT: x = c(10, 20, 30) and y = c(2, 4, 5) (already included below).
# EXPECTED OUTPUT: add = 12 24 35; subtract = 8 16 25;
#                  multiply = 20 80 150; divide = 5 5 6.

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
